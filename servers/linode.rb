user 'chef'
host '106.186.21.137'
port 22
ssh_options(:keys => '~/.ssh/chef_deploy_key')

node.set[:name] = 'linode'

run_list [ 'role[basebox]',
           'role[webserver]',
           'role[monitor]' ]
