user 'chef'
host '106.187.48.154'
port 22

node.set[:name] = 'rocodev'

run_list [
  'role[basebox]',
  'role[web-box]',
  'recipe[percona::server]',
  'recipe[redisio::install]',
  'recipe[redisio::enable]'
]

# recipe[percona::server]
node.set[:percona] = {
  :main_config_file => "/etc/mysql/my.cnf",
  :encrypted_data_bag => "rocodev"
}
