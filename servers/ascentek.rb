user 'chef'
host '106.186.17.29'
port 22

node.set[:name] = 'ascentek'

run_list [
  'role[basebox]',
  'role[web-box]',

  'recipe[percona::server]',
]

# recipe[percona::server]
node.set[:percona] = {
  :main_config_file => "/etc/mysql/my.cnf",
  :encrypted_data_bag => "ascentek"
}
