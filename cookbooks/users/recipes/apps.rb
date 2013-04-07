
user "apps" do
  home    "/home/apps"
  shell   "/bin/bash"
  supports :manage_home => true
  action  [ :create, :manage ]
end

directory "/home/apps/.ssh" do
  owner "apps"
  group "apps"
  mode 0700
  action :create
  not_if { File.exists? "/home/apps/.ssh" }
end

template "/home/apps/.ssh/config" do
  source "ssh/config.erb"
  owner "apps"
  group "apps"
  mode 0600
  action :create
end

template "/home/apps/.ssh/authorized_keys" do
  source "ssh/authorized_keys/apps.erb"
  owner "apps"
  group "apps"
  mode 0600
  action :create
end
