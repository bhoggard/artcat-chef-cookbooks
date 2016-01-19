node[:deploy].each do |application, deploy|

  # Since the rails::configure recipe isn't always available, we must re-declare this execute resource:
  execute "restart Rails app #{application}" do
    cwd deploy[:current_path]
    command "#{deploy[:deploy_to]}/shared/scripts/unicorn restart"

    # # make sure remote_syslog for papertrail is running
    # command "/usr/local/bin/bundle exec #{node[:deploy][application][:rake]} papertrail:start"
    # action :nothing
  end

end
