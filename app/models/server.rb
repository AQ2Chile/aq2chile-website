class Server < ApplicationRecord

  def update_info(sv_status)
    self.name     = sv_status[:hostname]
    self.country  = GeoIp.geolocation(address, precision: :country).try(:[], :country_code)
    self.game     = sv_status[:gamename]
    self.save
  end

  def self.update_servers_list
    sv_list = self.get_q2servers_list

    sv_list.each do |sv|
      sv_status = Q2ServerQuery::Client.new(sv[:address], sv[:port]).status
      server    = find_or_create_by!(address: sv[:address], port: sv[:port])

      server.update_info(sv_status)
      sleep(1) # Because geo_ip allows 1 req per second.
    end
  end

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
end
