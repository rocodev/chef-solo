#!/bin/bash -e
[ "$1" = "-n" ] && DRY_RUN=1

# ==================================================
# Check

if [ ! -f /root/.bootstrapped ]; then
  echo "Start bootstraping system..."
else
  echo "The system is bootstrapped."
  exit 0
fi

# ==================================================
# 1. Install rvm and ruby 1.9.3-p448
# 2. Install bundler chef gems
# 3. Setup chef user for chef-solo automation

# ==================================================
# Config
ruby_version='ruby-1.9.3-p448'
gems=(bundler chef)
chef_user=chef
chef_group=chef

# ==================================================
# Helpers

COLUMNS=${COLUMNS-80}
CLOSE_STEP=
SKIP_STEP=
SKIP_RUN=
SKIP_THIS_RUN=

function line() {
  printf "%0${COLUMNS}d\n" 0 | sed 's/./-/g'
}
function fold_lines() {
  fold -s -w "${COLUMNS}"
}
function wrap_lines() {
  fold_lines | sed "s/.*/${1}&${2}/"
}

function close_step() {
  line | sed 's/^./\`/'
  echo
}
function step() {
  if [ -n "$CLOSE_STEP" ]; then
    close_step
  else
    trap 'close_step' EXIT
  fi

  SKIP_RUN="$SKIP_STEP"
  line | sed 's/^./\//'
  if [ -n "$SKIP_STEP" ]; then
    echo '| [033mSkipped[0m'
  fi
  echo "$*" | wrap_lines '| [032m' '[0m'
  SKIP_STEP=
  CLOSE_STEP=1
}
function xstep() {
  SKIP_STEP=1
  step "$@"
}

function run() {
  echo "$*" | wrap_lines '[036;1m$[0m ' | sed '2,$s/\$/>  /'
  if [ -z "$DRY_RUN" -a -z "$SKIP_RUN" -a -z "$SKIP_THIS_RUN" ]; then
    eval "$*" || exit
  fi
}
function xrun() {
  SKIP_THIS_RUN=1
  run "$@"
  SKIP_THIS_RUN=
}
function info() {
  echo "$*" | wrap_lines '[036;1m*[0m '
}

function cat_error() {
  cat | wrap_lines '[031;1m>>> ' '[0m' >&3
}
exec 3>&2
exec 2> >(cat_error)

[ "$UID" = "0" ] || {
  echo "Require root privilege to bootstrap" >&2
  exit 1
}

step "Install nessesary packages"
run apt-get update
run aptitude install -y \
  libgdbm-dev libyaml-dev libffi-dev \
  libncurses5-dev libtool pkg-config \
  gawk autoconf automake bison \
  python-software-properties \
  build-essential zlib1g-dev \
  libxslt1-dev libxml2-dev \
  sqlite3 libsqlite3-dev \
  libssl-dev openssl \
  curl wget git-core \
  libmysqlclient-dev \
  libreadline-dev \
  openssh-server

step "Install/Upgrade rvm in /usr/local/rvm"
if [ -d /usr/local/rvm ]; then
  info 'upgrade rvm'
  run rvm get stable
else
  info 'install rvm'
  run curl -L https://get.rvm.io | bash  -s -- --branch stable --version head
fi

run source /etc/profile.d/rvm.sh

if ! grep 'rvm' /etc/skel/.bashrc &> /dev/null; then
  run 'sed -i "1asource /etc/profile.d/rvm.sh" /etc/skel/.bashrc'
fi
run 'touch "/root/.bashrc"'
if ! grep 'rvm' "/root/.bashrc" &> /dev/null; then
  run 'sed -i "1asource /etc/profile.d/rvm.sh" /root/.bashrc'
fi

step "Install ruby $ruby_version"
if [ -f "/usr/local/rvm/rubies/$ruby_version" ]; then
  info "ruby $ruby_version is already installed"
else
  info 'installation may take a long time, restart bootstrap if failed.'
  run rvm install "$ruby_version"
fi
run rvm default "$ruby_version"
info `ruby -v 2>&1`

step "Setup gems ${gems[*]}"
test -s ~/.gemrc || echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc
run gem install "${gems[@]}"

step "Create user ${chef_user}:${chef_group}"
run groupadd -r -f "$chef_group"
if ! id "$chef_user" &> /dev/null; then
  run useradd -r -g "$chef_group" -m "$chef_user" -s /bin/bash
fi

step "Setup chef deploy key"
if [ ! -d /home/chef/.ssh ]; then
  run mkdir -p /home/chef/.ssh
  echo "chef-deploy-public-key" > /home/chef/.ssh/authorized_keys
  run chown -R "$chef_user:$chef_group" /home/chef/.ssh
  run chmod 0700 /home/chef/.ssh
fi

step "Setup permission for chef no password sudo running chef-solo"
echo "chef ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/chef
run chmod 0440 /etc/sudoers.d/chef

step "Configure ssh to prevent password & root logins"
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
run service ssh restart

echo "The system is bootstrapped." > /root/.bootstrapped
