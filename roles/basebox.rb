name "base-system"

run_list [ "recipe[base]",
           "recipe[users]",
           "recipe[rvm::system]" ]

default_attributes(
  :rvm => {
    :default_ruby => 'ruby-2.0.0-p247',
    :global_gems => [
      { 'name' => 'bundler' },
      { 'name' => 'chef' },
    ]
  }
)
