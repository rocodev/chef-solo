# rocodev-chef-solo

## Setup ssh key for deploy

可自行決定產生一組新的 ssh key 來給 chef deploy 用或使用現有的 ssh key，在專案裡用指令 `git grep chef-deploy-public-key` 找到的檔案，把 chef-deploy-public-key 字串更換成要 deploy 用的 public key

    ssh-keygen -t rsa -C "user@example.com" -f ~/.ssh/chef_deploy_key

## Bootstrap server for chef deploy ready

使用 Vagrant 或 Linode、AWS EC2 剛建立的 Ubuntu Server，都需先上傳並執行 bootstrap.sh，安裝 rvm、ruby、bundler、chef，和設定 chef deploy 跑 chef-solo 的基本環境。由於每次 bootstrap 都要 compile 安裝 ruby 很費時，Vagrant 和 AWS EC2 可在跑過 bootstrap.sh 後先建立 chef deploy ready 的映像檔之後直接使用。

## Deploy server running chef-solo provision

Linode、AWS EC2 開好並 bootstrapped ready 的伺服器在 servers 下建立設定檔，執行 cap deploy 便會進行 chef-solo 自動化部署，一次可指定一個或多個伺服器，更多使用方式請看 HOWTO.md。

    cap deploy:setup servers/awsec2.rb servers/linode.rb # 第一次 deploy 前須先 setup
    cap deploy servers/awsec2.rb servers/linode.rb

## Vagrant

* 安裝 VirtualBox https://www.virtualbox.org/wiki/Downloads
* 安裝 Vagrant http://downloads.vagrantup.com

## Cookbooks

1. 一般會用到的通用套件盡量使用 http://community.opscode.com/ 上的，透過以下指令安裝：

        knife cookbook site install package -o cookbooks/.

2. 如果需要 fork community 的 cookbook 來改，盡量放在 github 上，還有要使用放在 github 上但沒註冊在 community 的 cookbook，Gemfile 裡有加入 [knife-github-cookbooks](https://github.com/websterclay/knife-github-cookbooks) plugin，所以可以透過以下方式安裝：

        # 必須先切換指令所在資料夾到 cookbooks 底下
        cd cookbooks && knife cookbook github install techbang/nginx

3. 比較客制化內部架構自己建立的 cookbooks 直接建立修改 commit 即可：

        knife cookbook create tech-base -o cookbooks/.

* base     - 在伺服器上安裝一些基本或必要的套件，及系統設定。
* users    - 建立管理使用者賬號，以及登入用的 ssh authorized_keys 和設定 sudo 權限。
* projects - 管理和啓動專案 nginx 設定檔，
* god-apps - 管理和啓動要用 god 監控的程序。

4. 直接修改 community 的 cookbook 並 commit：

* god - 修正相容 rvm 的使用環境。

cookbooks 照以上方式管理，使用網頁界面或 Git GUI 看 cookbooks 列表，就可以一目了然的知道 cookbook 是安裝自哪邊，或者是否自己有修改 community cookbook，升級到 community cookbook 時要注意修改過的會被覆蓋掉，[more cookbook usage](https://gitlab.techbang.com/systems/techbang-chef-solo/tree/readme/cookbooks/README.md)。

## Roles

* base-system - 伺服器基本環境

        base
        users
        rvm::system

* webserver - 網站前端伺服器

        memcached
        nginx + passenger
        projects
        nodejs

* monitor - 伺服器程序監控

        god-apps
