name "webserver"

run_list [ "recipe[memcached]",
           "recipe[nginx]",
           "recipe[nodejs]" ]

default_attributes(
  :nginx => {
    :version => "1.2.7",
    :worker_processes => 4,
    :worker_connections => "8192",
    :worker_rlimit_nofile => "32768",
    :client_max_body_size => "34m",
    :event => "epoll",
    :install_method => "source",
    :source => {
      :modules => [
        "http_ssl_module", "http_gzip_static_module", "passenger"
      ]
    },
    :passenger => {
      :version => "3.0.19",
      :root => "/usr/local/rvm/gems/ruby-1.9.3-p392/gems/passenger-3.0.19",
      :gem_binary => "/usr/local/rvm/rubies/ruby-1.9.3-p392/bin/gem",
      :max_pool_size => "4"
    }
  },
  :nodejs => {
    :make_threads => 2,
  }
)
