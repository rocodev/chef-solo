user 'chef'
host 'ec2-54-249-194-148.ap-northeast-1.compute.amazonaws.com'
port 22
ssh_options(:keys => '~/.ssh/tech_deploy_key')

node.set[:name] = 'awsec2'

run_list [ 'role[base-system]',
           'role[webserver]' ]