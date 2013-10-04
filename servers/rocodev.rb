user 'chef'
host '106.187.48.154'
port 22

node.set[:name] = 'rocodev'

run_list [ 'role[basebox]' ]
