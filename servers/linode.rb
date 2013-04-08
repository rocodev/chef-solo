user 'chef'
host '106.187.96.10'
port 22
ssh_options(:keys => '~/.ssh/chef-deploy-private-key')

node.set[:name] = 'linode'

run_list [ 'role[base-system]',
           'role[webserver]',
           'role[monitor]' ]
