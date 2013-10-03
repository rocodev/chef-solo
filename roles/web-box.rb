name "web-box"

run_list [ "recipe[memcached]",
           "recipe[nodejs]",
           "recipe[nginx]" ]

default_attributes(
  # recipe[memcached]
  :memcached => {
    :memory => 64
  },
  # recipe[nodejs]
  :nodejs => {
    :install_method => "package"
  },
  # recipe[nginx]
  :nginx => {
    :version => "1.4.2",
    :worker_processes => 4,
    :worker_connections => "8192",
    :worker_rlimit_nofile => "32768",
    :client_max_body_size => "34m",
    :event => "epoll",
    :server_tokens => "off",
    :default_site_enabled => false,
    :install_method => "source",
    :configure_flags => [ "--with-http_spdy_module" ],
    :source => {
      :modules => [
        "nginx::passenger"
      ]
    },
    :passenger => {
      :version => "4.0.19",
      :root => "/usr/local/rvm/gems/ruby-2.0.0-p247/gems/passenger-4.0.19",
      :gem_binary => "/usr/local/rvm/rubies/ruby-2.0.0-p247/bin/gem",
      :max_pool_size => "4"
    }
  },
)
