Bootstrap Vagrant
=================

- How to Use
    add basebox, if you alread added, skip
    ```bash
    vagrant box add ubuntu-14.04
    vagrant init ubuntu-14.04
    ```
    init vagrant
    ```bash
    git init
    git add Vagrantfile
    git commit -am "init vagrant"
    ```

    add subtree to remote
    ```bash
    git remote add -f bootstrap-vagrant https://github.com/SkyLothar/bootstrap-vagrant.git
    git subtree add --prefix bootstrap-vagrant bootstrap-vagrant master --squash
    ```

    update sub-project
    ```bash
    git fetch bootstrap-vagrant master
    git subtree pull --prefix bootstrap-vagrant bootstrap-vagrant master
    ```

- Basic Setup
    timezone setup
    alternate mirror
    ```bash
    ./basic-setup.sh $TIMEZONE $UBUNTU_MIRROR
    ```

- Install Nodejs
    install nodejs using given tar url
    ```bash
    ./install-nodejs.sh $NODEJS_URL
    ```

- Install Python
    install python using given tar url, install virtualenv
    ```
    ./install-python.sh $PY_URL $PYPI_MIRROR
    ```

- Install Ruby
    install ruby using given tar url, install bundle
    ```
    ./install-ruby.sh $RUBY_URL RUBY_MIRROR
    ```

- Install Mysql
    install mysql and setup a basic database
    ```
    ./install-mysql.sh  $MYSQL_PKG $MYSQL_ROOT_PWD $NEW_DB $NEW_USR $NEW_USR_PWD
    ```

- Sample Config
    ```bash
    TIMEZONE="Asia/Shanghai"
    UBUNTU="http://mirrors.aliyun.com/ubuntu"

    NODEJS_URL="http://nodejs.org/dist/v0.10.32/node-v0.10.32.tar.gz"

    PY_TARBALL="https://www.python.org/ftp/python/2.7.8/Python-2.7.8.tgz"
    PYPI_MIRROR="http://pypi.douban.com/simple"

    RUBY_TARBALL="http://ruby.taobao.org/mirrors/ruby/2.1/ruby-2.1.3.tar.gz"
    RUBY_MIRROR="https://ruby.taobao.org/"

    MYSQL_PKG="mysql-server-5.6"
    MYSQL_ROOT_PWD="root-password"
    MYSQL_NEW_DB="mobvoi-db"
    MYSQL_NEW_USR="mobvoi-usr"
    MYSQL_NEW_USR_PWD="mobvoi-pwd"
    ```

- Undocumented:
    - install-nginx.sh
    - install-supervisor.sh
