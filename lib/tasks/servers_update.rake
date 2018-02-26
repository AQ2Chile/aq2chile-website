namespace :servers do
  desc 'Checks the full list of servers regardless of status'
  task full_check: :environment do
    Rails.logger.info "-- Starting Servers Full Check"
    Server.update_servers_list(only_available: false)
  end

  desc 'Update servers list from q2servers.com'
  task update: :environment do
    Rails.logger.info "-- Starting Servers Update"
    Server.update_servers_list(only_available: true)
  end
end
