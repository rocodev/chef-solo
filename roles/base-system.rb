name "base-system"

run_list [ "recipe[rvm::system]" ]

default_attributes(
  :rvm => {
    :default_ruby => 'ruby-1.9.3-p392',
    :global_gems => [
      { 'name' => 'bundler' },
      { 'name' => 'chef' },
    ]
  }
)
