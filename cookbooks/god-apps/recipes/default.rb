#
# Cookbook Name:: god-apps
# Recipe:: default
#
# Copyright 2013, RocoDev
#
# All rights reserved - Do Not Redistribute
#

include_recipe "god"

node[:god][:applications].each do |application|
  god_monitor application do
    config "#{application}.god.erb"
  end
end
