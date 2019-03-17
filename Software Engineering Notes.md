
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

After development, in order to merge to the master, run:

`git checkout master`

`git merge [name_of_your_new_branch]`

In order to get the latest code from master:

check out to your branch, run:

`git merge master`

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

## git add and git commit
I would suggest, if you only changed one file then you might do something like this:

```
git add "Your_file.txt"
git commit -m "added a new feature in a file"
git push heroku master
```

Or if you changed multiple files then you could do something like this:

```
git add .
git commit -m "some files changed"
git push heroku master
```

Similarly, you could add and commit all the files on one line with this command:

`git commit -am "added a new feature some files changed"`


`git add -A` stages ALL files (new, modified, deleted)

`git add .` stages new and modified files

`git add -u` stages Modified and Deleted files

## git push

`git push -u origin master`

把主分支推送到github，以后再推送时，可以省略后面的参数，简写成：

`git push`


## Mirroring a repository
[See this link](https://help.github.com/en/articles/duplicating-a-repository)

To duplicate a repository without forking it, you can run a special clone command, then mirror-push to the new repository.

Before you can duplicate a repository and push to your new copy, or mirror, of the repository, you must create the new repository on GitHub.

In these examples, `exampleuser/new-repository` is the mirrors.

Mirroring a repository

Open Terminal.

Create a bare clone of the repository.
```
$ git clone --bare https://github.com/exampleuser/old-repository.git
```

Mirror-push to the new repository.

```
$ cd old-repository.git
$ git push --mirror https://github.com/exampleuser/new-repository.git
```

Remove the temporary local repository you created in step 1.
```
$ cd ..
$ rm -rf old-repository.git
```





# HW4

In cloud 9:

```
sudo service postgresql start
rake db:setup
rake db:migrate
rails server -p $PORT -b $IP

bundle exec rake cucumber
bundle exec rake spec
```

my history:

to [configure postsql](https://medium.com/@floodfx/setting-up-postgres-on-cloud9-ide-720e5b879154) on cloud 9

```
    1  ls
    2  git clone https://github.com/Easoncyx/typo.git
    3  sudo yum install libxml2-devel libxslt-devel
    4  sudo chmod o+t -R /tmp
    5  nvm i v8
    6  cd typo/
    7  npm install -g heroku
    8  sudo yum install postgresql postgresql-server postgresql-devel postgresql-contrib postgresql-docs
    9  sudo su
   10  rvm install 2.4.0
   11  rvm install 1.9.3
   12  rvm use 1.9.3
   13  gem install rails -v '3.0.10'
   14  bundle install
   15  vim Gemfile
   16  sudo su
   17  bundle install
   18  sudo service postgresql initdb
   19  sudo vim /var/lib/pgsql9/data/postgresql.conf
   20  sudo vim /var/lib/pgsql9/data/pg_hba.conf
   21  sudo service postgresql restart
   22  sudo su - postgres
   23  rake db:setup
   24  rake db:migrate
   25  rails server -p $PORT -b $IP
   26  heroku create --stack cedar-14
   27  git add .
   28  git status
   29  git commit -m "first"
   30  git config --global user.name "Yixu Chen"
   31  git config --global user.email cyx709671676@gmail.com
   33  git remote -v
   35  git push origin master
   36  git push heroku master
   37  heroku rake db:migrate
   38  heroku open
```

