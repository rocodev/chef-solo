user 'chef'
host '106.187.48.154'
port 22

node.set[:name] = 'rocodev'

run_list [
  'role[basebox]',
  'role[web-box]',

  'recipe[percona::server]',
  'recipe[redisio::install]',
  'recipe[redisio::enable]',

  'recipe[projects]',

  # for shuttle project
  'recipe[postgresql::server]',
  'recipe[elasticsearch::deb]',
]

# recipe[base]
node.set[:base] = {
  :packages => [ "sphinxsearch", "libarchive-dev", "openjdk-7-jre-headless" ]
}

# recipe[rvm]
node.set[:rvm] = {
  :rubies => [ "ruby-1.9.3-p448" ],
  :gems => {
    'ruby-2.0.0' => [
      { 'name' => 'whenever' },
      { 'name' => 'backup' },
    ]
  }
}

# recipe[percona::server]
node.set[:percona] = {
  :main_config_file => "/etc/mysql/my.cnf",
  :encrypted_data_bag => "rocodev"
}

# recipe[postgresql::server]
node.set[:postgresql] = {
  :password => {
    # run this from a linux commandline generate password hash
    # echo -n '=>password<=''postgres' | openssl md5 | sed -e 's/.* /md5/'
    :postgres => "md580cccdd9bec5d6c8025d892d93c080cf"
  }
}

# recipe[projects]
node.set[:projects] = [
  { :name => "accounting-book", :enabled => true },
  { :name => "roco-official",   :enabled => true },
  { :name => "goldmine",        :enabled => true },
  { :name => "audiophile",      :enabled => true },
  { :name => "bumblr",          :enabled => true },
  { :name => "breezeman",       :enabled => true },
  { :name => "shuttle",         :enabled => true },
]
