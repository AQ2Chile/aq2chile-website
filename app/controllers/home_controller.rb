class HomeController < ApplicationController
  def index
    @status_list = []

    Server.available.each do |server|
      extras               = {}
      sv_status            = Q2ServerQuery::Client.new(server.address, server.port).status
      next if sv_status.nil?

      extras[:address]     = server.address
      extras[:port]        = server.port
      extras[:snaked_name] = sv_status[:hostname].underscore.delete(" ")
      extras[:country]     = server.country

      @status_list << sv_status.merge(extras: extras).with_indifferent_access
    end
  end

  def downloads
  end
end
