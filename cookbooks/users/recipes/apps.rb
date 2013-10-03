
user "apps" do
  home    "/home/apps"
  shell   "/bin/bash"
  uid     1011
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

auth_keys = []
node[:users][:apps][:auth_keys].each do |user_id|
  data = data_bag_item("public-keys", user_id)
  auth_keys << data["public_key"]
end

template "/home/apps/.ssh/authorized_keys" do
  source "ssh/authorized_keys.erb"
  owner "apps"
  group "apps"
  mode 0600
  variables({
    :auth_keys => auth_keys
  })
  action :create
end

template "/home/apps/.tmux.conf" do
  source "tmux.conf"
  owner "apps"
  group "apps"
  mode 0644
  action :create
end
