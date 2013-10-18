node[:deploy].each do |application, deploy|

  # Since the rails::configure recipe isn't always available, we must re-declare this execute resource:
  execute "restart Rails app #{application}" do
    cwd deploy[:current_path]
    command "#{deploy[:deploy_to]}/shared/scripts/unicorn restart"
    action :nothing
  end

end
