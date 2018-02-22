class HomeController < ApplicationController
  def index
    @status = []
    Server.all.each do |server|
      sv_status       = Q2ServerQuery::Client.new(server[:address], server[:port]).status
      address         = server[:address]
      snaked_hostname = sv_status[:hostname].underscore.delete(" ")

      @status << sv_status.merge(address: address, snaked_hostname: snaked_hostname).with_indifferent_access
    end
  end
end
