user 'chef'
host '54.248.242.249'
port 22
ssh_options(:keys => '~/.ssh/tech_deploy_key')

node.set[:name] = 'awsec2'

run_list [ 'role[base-system]',
           'role[webserver]' ]
