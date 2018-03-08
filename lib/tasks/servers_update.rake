namespace :servers do
  desc 'Update servers, all: Full server list from q2servers.com, Default (without arg): Only available servers in the last 30 minutes.'
  task :update, [:all] => :environment do |_, args|
    all = (args[:all].present? && args[:all] == "all")
    Rails.logger.info "-- Starting Servers Update. all: #{all}"
    Server.update_servers_list(all: all)
  end
end
