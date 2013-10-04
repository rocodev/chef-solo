#
# Cookbook Name:: projects
# Recipe:: default
#
# Copyright 2013, RocoDev
#
# All rights reserved - Do Not Redistribute
#

# setup and enable project nginx config
node[:projects].each do |project|
  directory "#{node['nginx']['log_dir']}/#{project[:name]}" do
    group "root"
    owner "root"
    mode   0755
    recursive true
  end

  template "#{node['nginx']['dir']}/sites-available/#{project[:name]}" do
    source "nginx/#{project[:name]}.erb"
    owner "root"
    group "root"
    mode 0644
    notifies :reload, 'service[nginx]'
  end

  nginx_site project[:name] do
    enable project[:enabled]
  end
end
