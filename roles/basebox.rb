name "basebox"

run_list [ "recipe[base]",
           "recipe[sudo]",
           "recipe[users]",
           "recipe[ulimit]",
           "recipe[rvm::system]" ]

default_attributes(
  # recipe[sudo]
  :authorization => {
    :sudo => {
      :sudoers_defaults => [
        'env_reset',
        'exempt_group=admin',
        'secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"'],
      :groups => [ "admin", "sudo" ],
      :users  => [ "apps" ],
      :passwordless => false,
      :include_sudoers_d => true
    }
  },
  # recipe[users]
  :users => {
    :chef => {
      :auth_keys => [ "v1nc3ntlaw", "domon" ]
    },
    :apps => {
      :auth_keys => [ "v1nc3ntlaw", "xdite", "bc", "tonilin", "domon" ],
      :password  => "$6$i3NIuKNf$ddMUJRkDZc4HMer0UXIYmAjrSAWtw9z36QFWcYGugMQNipic2HslDtYZ7HOTD8YI6VDxe2MQxfIKKQMejWG2j1"
    }
  },
  # recipe[ulimit]
  :ulimit => {
    :users => {
      :apps => {
        :filehandle_limit => 8192,
      }
    }
  },
  # recipe[rvm]
  :rvm => {
    :default_ruby => 'ruby-2.0.0-p247',
    :global_gems => [
      { 'name' => 'bundler' },
      { 'name' => 'chef', 'version' => '11.8.0' },
      { 'name' => 'ruby-shadow' },
    ]
  }
)
