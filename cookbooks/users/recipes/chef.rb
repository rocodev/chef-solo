
user "chef" do
  home    "/home/chef"
  shell   "/bin/bash"
  supports :manage_home => true
  action  [ :create, :manage ]
end

directory "/home/chef/.ssh" do
  owner "chef"
  group "chef"
  mode 0700
  action :create
  not_if { File.exists? "/home/chef/.ssh" }
end

template "/home/chef/.ssh/config" do
  source "ssh/config.erb"
  owner "chef"
  group "chef"
  mode 0600
  action :create
end

template "/home/chef/.ssh/authorized_keys" do
  source "ssh/authorized_keys/chef.erb"
  owner "chef"
  group "chef"
  mode 0600
  action :create
end

template "/etc/sudoers.d/chef" do
  source "sudo/chef.erb"
  owner "root"
  group "root"
  mode 0440
  action :create
end
