namespace :servers do
  desc 'Update servers list from q2servers.com'
  task update: :environment do
    Server.update_servers_list
  end
end
