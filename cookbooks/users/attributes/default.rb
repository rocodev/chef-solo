# http://docs.opscode.com/resource_user.html#password-shadow-hash
# Find a linux system using mkpasswd -m sha-512 to generate password hash

default[:users][:apps][:auth_keys] = []
default[:users][:apps][:password]  = "!"
default[:users][:chef][:auth_keys] = []
