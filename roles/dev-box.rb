name "dev-box"

default_attributes(
  # recipe[sudo]
  :authorization => {
    :sudo => {
      :sudoers_defaults => [
        'env_reset',
        'exempt_group=admin',
        'secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"'],
      :groups => [ "admin", "sudo" ],
      :passwordless => true,
      :include_sudoers_d => true
    }
  },
  # recipe[nginx]
  :nginx => {
    :server_tokens => "on",
    :default_site_enabled => true,
  }
)
