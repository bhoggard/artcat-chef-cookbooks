node[:deploy].each do |application, deploy|

  # execute "restart Rails app #{application}" do
  #   cwd deploy[:current_path]
  #   command node[:opsworks][:rails_stack][:restart_command]
  #   action :nothing
  # end

  template "#{deploy[:deploy_to]}/shared/config/application.yml" do
    source 'application.yml.erb'
    cookbook 'application_env'
    mode "0660"
    group deploy[:group]
    owner deploy[:user]
    variables(:env => node[:custom_env][application])
    notifies :run, "execute[restart Rails app #{application}]"

    only_if do
      File.exists?("#{deploy[:deploy_to]}") && File.exists?("#{deploy[:deploy_to]}/shared/config/")
    end
  end

end
