name "basebox"

run_list [ "recipe[base]",
           "recipe[sudo]",
           "recipe[users]",
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
      :passwordless => false,
      :include_sudoers_d => true
    }
  },
  # recipe[rvm]
  :rvm => {
    :default_ruby => 'ruby-2.0.0-p247',
    :global_gems => [
      { 'name' => 'bundler' },
      { 'name' => 'chef' },
    ]
  }
)
