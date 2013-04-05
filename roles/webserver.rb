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
      :prefix => "/opt/nginx",
      :modules => [
        "http_ssl_module", "http_gzip_static_module",
      ]
    }
  }
)
