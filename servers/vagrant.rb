user 'vagrant'
host '127.0.0.1'
port 2222
ssh_options(:keys => '~/.vagrant.d/insecure_private_key')

node.set[:name] = 'vagrant'

run_list [ 'role[basebox]',
           'role[webserver]',
           'role[monitor]' ]
