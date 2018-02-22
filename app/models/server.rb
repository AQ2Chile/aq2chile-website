class Server < ApplicationRecord

  def self.get_q2servers_list
    uri         = URI.parse "http://q2servers.com/?mod=action&raw=1"
    res         = Net::HTTP.get_response uri

    sv_list = res.body.split("\n")

    sv_list.map do |server|
      sv = server.split(":")
      {
        address: sv[0],
        port:    sv[1].to_i
      }.with_indifferent_access
    end
  end

  def self.update_servers_list
    sv_list = self.get_q2servers_list

    sv_list.each do |sv|
      sleep(2)
      client    = Q2ServerQuery::Client.new(sv[:address], sv[:port])
      sv_status = client.status
      server    = self.find_or_initialize_by(address: sv[:address])

      server.name     = sv_status[:hostname]
      server.address  = sv[:address]
      server.port     = sv_status[:port] || sv[:port]
      server.country  = GeoIp.geolocation(sv[:address], precision: :country).try(:[], :country_code)
      server.game     = sv_status[:gamename]

      Rails.logger.info "Trying to save server #{sv[:address]}:#{sv[:port]}"
      server.save
    end
  end
end
