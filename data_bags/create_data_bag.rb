#!/usr/bin/env ruby

require 'rubygems'
require 'chef/encrypted_data_bag_item'
require 'fileutils'

secret = Chef::EncryptedDataBagItem.load_secret('../.chef/encrypted_data_bag_secret')

### Edit sample and fake data to create data bag
# http://docs.opscode.com/essentials_data_bags.html
# http://docs.opscode.com/essentials_data_bags.html#encrypt-a-data-bag

data_bags = "sample"
item_name = "fake"

data = {
  "id" => item_name,
  "kerker" => "haha"
}

### End

encrypted_data = Chef::EncryptedDataBagItem.encrypt_data_bag_item(data, secret)

FileUtils.mkpath("#{data_bags}")
File.open("#{data_bags}/#{item_name}.json", 'w') do |f|
  f.print encrypted_data.to_json
end
