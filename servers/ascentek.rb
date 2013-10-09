user 'chef'
host '106.186.17.29'
port 22

node.set[:name] = 'ascentek'

run_list [
  'role[basebox]',
  'role[web-box]',

  'recipe[percona::server]',
]

# recipe[users]
node.set[:users] = {
  :chef => {
    :auth_keys => [ "v1nc3ntlaw" ]
  },
  :apps => {
    :auth_keys => [ "v1nc3ntlaw", "xdite" ],
    :password  => "$6$i3NIuKNf$ddMUJRkDZc4HMer0UXIYmAjrSAWtw9z36QFWcYGugMQNipic2HslDtYZ7HOTD8YI6VDxe2MQxfIKKQMejWG2j1"
  }
}

# recipe[percona::server]
node.set[:percona] = {
  :main_config_file => "/etc/mysql/my.cnf",
  :encrypted_data_bag => "ascentek"
}
