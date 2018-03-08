class Server < ApplicationRecord

  scope :available, -> { where('last_available > ?', 30.minutes.ago) }

  def update_from_status(sv_status)
    attrs = {
      name:           sv_status[:hostname],
      country:        GeoIp.geolocation(address, precision: :country).try(:[], :country_code),
      game:           sv_status[:gamename],
      last_available: DateTime.now
    }

    Rails.logger.info "---- Updating Server #{self.address}:#{self.port}"
    self.update(attrs)
  end

  # Get servers list and request status via the Q2ServerQuery gem.
  # If all, fetch q2servers.com list, otherwise just check available ones.
  def self.update_servers_list(all: true)
    sv_list = (all ? available : get_q2servers_list)

    sv_list.each do |sv|
      server    = find_or_create_by!(address: sv[:address], port: sv[:port])
      sv_status = Q2ServerQuery::Client.new(sv[:address], sv[:port]).status

      server.update_from_status(sv_status)
      sleep(1) # Because geo_ip allows 1 req per second.
    end
  end

  # Only get the IPs from q2servers.com
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
