<!-- TOC -->

- [Software Engineering Debug Log](#software-engineering-debug-log)
    - [Bugs about PostgreSQL](#bugs-about-postgresql)
        - [PG::ConnectionBad](#pgconnectionbad)
        - [ERROR: invalid value for parameter "TimeZone": "UTC" : SET time zone 'UTC'](#error-invalid-value-for-parameter-timezone-utc--set-time-zone-utc)
    - [Bugs about Bundle](#bugs-about-bundle)
    - [Bugs about rails](#bugs-about-rails)
        - [/bin/rails does not exist](#binrails-does-not-exist)
- [Set up PostgreSQL](#set-up-postgresql)
    - [Install, start and stop postgresql server](#install-start-and-stop-postgresql-server)
    - [User](#user)
        - [CREATE ROLE with psql](#create-role-with-psql)
        - [The createuser utility](#the-createuser-utility)
- [Setup a new project with ruby on rails](#setup-a-new-project-with-ruby-on-rails)
- [homebrew](#homebrew)
- [Git](#git)
    - [branch](#branch)
    - [fork](#fork)
        - [问题来源](#%E9%97%AE%E9%A2%98%E6%9D%A5%E6%BA%90)
        - [fork别人的repo](#fork%E5%88%AB%E4%BA%BA%E7%9A%84repo)
        - [开发并且提交代码](#%E5%BC%80%E5%8F%91%E5%B9%B6%E4%B8%94%E6%8F%90%E4%BA%A4%E4%BB%A3%E7%A0%81)
            - [clone](#clone)
            - [commit](#commit)
            - [push](#push)
            - [pull request](#pull-request)

<!-- /TOC -->
# Software Engineering Debug Log
## Bugs about PostgreSQL
### PG::ConnectionBad
If you still cannot connect to PG, try another solution:
Rollback your changes to database.yml and Gemfile.
Run `bundle clean --force`
delete the gemfile.lock, add version number to the sqlite3 package in gemfile (gem 'sqlite3', '~> 1.3.13’)
re-run bundle install --without production.

If you face any issues after replacing sqlite3 with pg in the gemfile and database.yml, just restore those changes. In addition, you may need to specify the sqlite3 version. `1.3.13` is a tested version.

After doing this, sqlite3 will be used locally, and pg will be used when pushing to heroku. If you find any issues related to pg when pushing to heroku, you can copy the line of `gem 'pg', '~> 0.20'` and paste it outside the production group.

### ERROR: invalid value for parameter "TimeZone": "UTC" : SET time zone 'UTC'
Restarting postgresql works.
To restart if you've installed it using homebrew.
Reboot your computer

## Bugs about Bundle
To downgrade the version of bundler

`gem uninstall bundler`

`gem install bundler --version '1.16.6'`


## Bugs about rails
### /bin/rails does not exist
If you see an error said "/bin/rails does not exist" on heroku logs, run

`rake rails:update:bin`

Then commit and push to heroku again


# Set up PostgreSQL
See [this link](https://www.codementor.io/engineerapart/getting-started-with-postgresql-on-mac-osx-are8jcopb) for more detail about psql
## Install, start and stop postgresql server
- install:

	`brew install postgresql`

- start and stop the server:

	`brew services start postgresql`

	`brew services stop postgresql`

- check the running server:

	`brew services list`

- Make sure Postgres starts every time your computer starts up. Execute the following command:

	`pg_ctl -D /usr/local/var/postgres start && brew services start postgresql`

- See the version of postgresql:

	`postgres -V`

## User
Log in as specific user:
`psql postgres`
`psql -U postgres` (-U means User)

By default, it automatically creates the user postgres. Let’s see what other users it has created.
Show users:
`postgres=# \du`

`createuser -s postgres`
`ALTER USER postgres WITH PASSWORD ‘password’;`

### CREATE ROLE with psql
`CREATE ROLE username WITH LOGIN PASSWORD 'quoted password' [OPTIONS]`

See the password of a user
`postgres=# \password postgres`

Create role

```
postgres=# CREATE ROLE patrick WITH LOGIN PASSWORD 'Getting started';
postgres=# \du
```

Let’s add the CREATEDB permission to our new user to allow them to create databases:

```
postgres=# ALTER ROLE patrick CREATEDB;
postgres=# \du
postgres=# \q
```
[Documentation for `CREATE ROLE`](https://www.postgresql.org/docs/current/sql-createrole.html)
### The createuser utility
TBC

# Setup a new project with ruby on rails
See [this link](https://www.digitalocean.com/community/tutorials/how-to-setup-ruby-on-rails-with-postgres) for details.
`rails new myapp --database=postgresql`

edit this file: `RAILS_ROOT/config/database.yml`

```
development:
  adapter: postgresql
  encoding: unicode
  database: myapp_development
  pool: 5
  username: myapp
  password: password1

test:
  adapter: postgresql
  encoding: unicode
  database: myapp_test
  pool: 5
  username: myapp
  password: password1
```
`rake db:setup`
This will create development and test databases, set their owners to the user specified, and create "schema_migrations" tables in each. This table is used to record your migrations to schemas and data.

`rake db:create`
`rake db:reset`
`rake db:migrate`
`rake db:seed`

In the gem file, use
`gem 'pg', '~> 0.20.0'`

On heroku, you only need to run `db:migrate` and `db:seed`.
The test database is used locally so you don't need to run `db:test:prepare`

# homebrew
`brew search <search term>`

`brew list postgres`

# Git
See [this link](http://www.ruanyifeng.com/blog/2015/12/git-workflow.html) for Git 工作流程
## branch
Before creating a new branch, pull the changes from upstream. Your master needs to be up to date.

`$ git pull`

Create the branch on your local machine and switch in this branch :

`$ git checkout -b [name_of_your_new_branch]`

Push the branch on Github:

`$ git push origin [name_of_your_new_branch]`

You can see all branches created by using :

`$ git branch -a`

## fork
### 问题来源
1. github上你可以用别人的现成的代码
直接 git clone 即可了

2. 然后你也想改代码或者贡献代码咋办？

### fork别人的repo
从别人的项目中fork一个到你自己的仓库。这个时候这个仓库就是你的了，要删除这个仓库到设置那里，像你删除你自己创建的repo一样删除，（因为这个库就是你的了，你现在可以任意修改这个库，除非你pull request被接受否则你不会对原作者的库产生任何影响）。

比如A账号下有个名为repo_name的仓库，这个项目的地址是
https://github.com/A/repo_name.git

这时候我（B）想贡献代码了,fork之后，你的个人仓库就多了这个库

https://github.com/B/repo_name.git

### 开发并且提交代码

#### clone

首先要从github上下载代码到本地，你需要执行如下命令：

```
git clone https://github.com/A/repo_name.git
cd repo_name
```

然后代码到本地里了，你就可以各种修改了。

#### commit

当你修改代码之后，需要commit到本地仓库，执行的命令如下：

```
git add xx
git commit  -m '修改原因，相关说明信息'
```
或者

```
git commit -am 'xxx'
```

#### push

执行git commit之后，只是提交到了本机的仓库，而不是github上你账号的仓库。你需要执行push命令，把commit提交到服务器。

这里你可以直接git push直接到远程默认仓库

`git push`

这里的git push指的是push到
https://github.com/B/repo_name.git
的默认仓库（master）


`remote add`

remote add也可以，因为和操作自己的库没有任何区别。

这里如果你

`remote add origin_A A/repo_name.github.com`

然后

`git push origin_A master`
是没用的
因为你没有权限！没有权限修改别人(A)的库!


#### pull request

你(B)正在开发，项目负责人(A)也在开发，你当时fork的代码已经不是A的最新的代码了。

这时候的你对你的代码肯定没问题，但是pull request 就有可以会出错，因为你fork的repo和现在的B的repo已经不一样了。

这时候理论上A会close你的request，让你先pull B的最新代码。

于是乎

```
git remote add origin_A A/repo_name.github.com
git fetch origin_A master:develop
```

自己merge代码不和谐的地方，这里肯定不能git pull,会提示conflict

代码是需要自己merge的

你修改代码后

```
git add
git commit
```
然后测试一下是不是已经拉取完成最新的了。

`git pull origin_A master`

你就可以提交到自己的远程版本库了。
`git push origin master`

之后你再pull request，A那边就不会出现不能auto merge的情况了，然后A看你的代码给不给力，给力就merge你的代码到他的主分支去了。
功德圆满 ：）

登陆github，在你自己的账号中的仓库中点击pull request，就会要求你输入pull request的原因和详细信息，你确认之后。osteach的owner就会收到并且审查，审查通过就会合并到主干上。