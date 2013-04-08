name "monitor"

run_list [ "recipe[god-apps]" ]

default_attributes(
  :god => {
    :applications => [ "memcached" ]
  }
)
