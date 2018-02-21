class HomeController < ApplicationController
  def index
    @status = []
    SERVER_LIST.each do |server|
      sv_status       = Q2ServerQuery::Client.new(server[:host], server[:port]).status
      address         = server[:host]
      snaked_hostname = sv_status[:hostname].underscore.delete(" ")

      @status << sv_status.merge(address: address, snaked_hostname: snaked_hostname).with_indifferent_access
    end
  end
end
