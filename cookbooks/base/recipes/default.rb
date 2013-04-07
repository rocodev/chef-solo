#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install useful or required packages
["git-core", "screen", "vim", "tree", "htop", "ntp",
 "curl", "iftop", "psmisc", "sysstat" ].each do |pkg|
  package pkg
end

# Install packages defined at attribute
node[:base][:packages].each do |pkg|
  package pkg
end
