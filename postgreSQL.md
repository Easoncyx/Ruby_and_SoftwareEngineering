















# PSQL

## 安装

自然，在你能开始使用PostgreSQL之前， 你必须安装它。PostgreSQL很有可能已经安装到你的节点上了， 因为它可能包含在你的操作系统的发布里， 或者是系统管理员已经安装了它。如果是这样的话， 那么你应该从操作系统的文档或者你的系统管理员那里获取有关如何访问PostgreSQL的信息。

如果你不清楚PostgreSQL是否已经安装， 或者不知道你能否用它（已经安装的）做自己的实验，那么你就可以自己安装。 这么做并不难，并且是一次很好的练习。PostgreSQL可以由任何非特权用户安装， 并不需要超级用户 （root）的权限。

如果你准备自己安装PostgreSQL， 那么请参考Chapter 16以获取安装的有关信息， 安装之后再回到这个指导手册来。一定要记住要尽可能遵循有关设置合适的环境变量章节里的信息。

如果你的站点管理员没有按照缺省的方式设置各项相关参数， 那你还有点额外的活儿要干。比如，如果数据库服务器机器是一个远程的机器， 那你就需要把PGHOST环境变量设置为数据库服务器的名字。环境变量PGPORT也可能需要设置。总而言之就是： 如果当你试着启动一个应用而该应用报告说不能与数据库建立联接时， 你应该马上与你的数据库管理员联系，如果你就是管理员， 那么你就要参考文档以确保你的环境变量得到正确的设置。 如果你不理解随后的几段，那么先阅读下一节。

## 架构基础

在我们继续之前，你应该先了解PostgreSQL的系统架构。 对PostgreSQL的部件之间如何相互作用的理解将会使本节更易理解。

在数据库术语里，PostgreSQL使用一种客户端/服务器的模型。一次PostgreSQL会话由下列相关的进程（程序）组成：

一个服务器进程，它管理数据库文件、接受来自客户端应用与数据库的联接并且代表客户端在数据库上执行操作。 该数据库服务器程序叫做postgres。

那些需要执行数据库操作的用户的客户端（前端）应用。 客户端应用可能本身就是多种多样的：可以是一个面向文本的工具， 也可以是一个图形界面的应用，或者是一个通过访问数据库来显示网页的网页服务器，或者是一个特制的数据库管理工具。 一些客户端应用是和 PostgreSQL发布一起提供的，但绝大部分是用户开发的。

和典型的客户端/服务器应用（C/S应用）一样，这些客户端和服务器可以在不同的主机上。 这时它们通过 TCP/IP 网络联接通讯。 你应该记住的是，在客户机上可以访问的文件未必能够在数据库服务器机器上访问（或者只能用不同的文件名进行访问）。

PostgreSQL服务器可以处理来自客户端的多个并发请求。 因此，它为每个连接启动（"forks"）一个新的进程。 从这个时候开始，客户端和新服务器进程就不再经过最初的 postgres进程的干涉进行通讯。 因此，主服务器进程总是在运行并等待着客户端联接， 而客户端和相关联的服务器进程则是起起停停（当然，这些对用户是透明的。我们介绍这些主要是为了内容的完整性）。

## 创建一个数据库

看看你能否访问数据库服务器的第一个例子就是试着创建一个数据库。 一台运行着的PostgreSQL服务器可以管理许多数据库。 通常我们会为每个项目和每个用户单独使用一个数据库。

你的站点管理员可能已经为你创建了可以使用的数据库。 如果这样你就可以省略这一步， 并且跳到下一节。

要创建一个新的数据库，在我们这个例子里叫mydb，你可以使用下面的命令：

```
$ createdb mydb
```

如果不产生任何响应则表示该步骤成功，你可以跳过本节的剩余部分。

如果你看到类似下面这样的信息：

```
createdb: command not found
```

那么就是PostgreSQL没有安装好。或者是根本没安装， 或者是你的shell搜索路径没有设置正确。尝试用绝对路径调用该命令试试：

```
$ /usr/local/pgsql/bin/createdb mydb
```

在你的站点上这个路径可能不一样。和你的站点管理员联系或者看看安装指导获取正确的位置。

另外一种响应可能是这样：

```
createdb: could not connect to database postgres: could not connect to server: No such file or directory
        Is the server running locally and accepting
        connections on Unix domain socket "/tmp/.s.PGSQL.5432"?
```

这意味着该服务器没有启动，或者没有按照createdb预期地启动。同样， 你也要查看安装指导或者咨询管理员。

另外一个响应可能是这样：

```
createdb: could not connect to database postgres: FATAL:  role "joe" does not exist
```

在这里提到了你自己的登陆名。如果管理员没有为你创建PostgreSQL用户帐号， 就会发生这些现象。（PostgreSQL用户帐号和操作系统用户帐号是不同的。） 如果你是管理员，参阅Chapter 21获取创建用户帐号的帮助。 你需要变成安装PostgreSQL的操作系统用户的身份（通常是 postgres）才能创建第一个用户帐号。 也有可能是赋予你的PostgreSQL用户名和你的操作系统用户名不同； 这种情况下，你需要使用-U选项或者使用PGUSER环境变量指定你的PostgreSQL用户名。

如果你有个数据库用户帐号，但是没有创建数据库所需要的权限，那么你会看到下面的信息：

```
createdb: database creation failed: ERROR:  permission denied to create database
```

并非所有用户都被许可创建新数据库。 如果PostgreSQL拒绝为你创建数据库， 那么你需要让站点管理员赋予你创建数据库的权限。出现这种情况时请咨询你的站点管理员。 如果你自己安装了PostgreSQL， 那么你应该以你启动数据库服务器的用户身份登陆然后参考手册完成权限的赋予工作。 [1]

你还可以用其它名字创建数据库。PostgreSQL允许你在一个站点上创建任意数量的数据库。 数据库名必须是以字母开头并且小于 63 个字符长。 一个方便的做法是创建和你当前用户名同名的数据库。 许多工具假设该数据库名为缺省数据库名，所以这样可以节省你的敲键。 要创建这样的数据库，只需要键入：

```
$ createdb
```

如果你再也不想使用你的数据库了，那么你可以删除它。 比如，如果你是数据库mydb的所有人（创建人）， 那么你就可以用下面的命令删除它：

```
$ dropdb mydb
```

（对于这条命令而言，数据库名不是缺省的用户名，因此你就必须声明它） 。这个动作将在物理上把所有与该数据库相关的文件都删除并且不可取消， 因此做这中操作之前一定要考虑清楚。

更多关于createdb和dropdb的信息可以分别在createdb和dropdb中找到。

**Notes**

[1] 
为什么这么做的解释：PostgreSQL用户名是和操作系统用户账号分开的。 如果你连接到一个数据库时，你可以选择以何种PostgreSQL用户名进行联接； 如果你不选择，那么缺省就是你的当前操作系统账号。 如果这样，那么总有一个与操作系统用户同名的PostgreSQL用户账号用于启动服务器， 并且通常这个用户都有创建数据库的权限。如果你不想以该用户身份登陆， 那么你也可以在任何地方声明一个-U选项以选择一个用于连接的PostgreSQL用户名。

## 访问数据库

一旦你创建了数据库，你就可以通过以下方式访问它：

- 运行PostgreSQL的交互式终端程序，它被称为psql， 它允许你交互地输入、编辑和执行SQL命令。
- 使用一种已有的图形化前端工具，比如pgAdmin或者带ODBC或JDBC支持的办公套件来创建和管理数据库。这种方法在这份教程中没有介绍。
- 使用多种绑定发行的语言中的一种写一个自定义的应用。这些可能性在Part IV中将有更深入的讨论。

你可能需要启动psql来试验本教程中的例子。 你可以用下面的命令为mydb数据库激活它：

```
$ psql mydb
```

如果你不提供数据库名字，那么它的缺省值就是你的用户账号名字。在前面使用createdb的小节里你应该已经了解了这种方式。

在psql中，你将看到下面的欢迎信息：

```
psql (9.6.0)
Type "help" for help.

mydb=>
```

最后一行也可能是：

```
mydb=#
```

这个提示符意味着你是数据库超级用户，最可能出现在你自己安装了 PostgreSQL实例的情况下。 作为超级用户意味着你不受访问控制的限制。 对于本教程的目的而言， 是否超级用户并不重要。

如果你启动psql时碰到了问题，那么请回到前面的小节。诊断createdb的方法和诊断 psql的方法很类似， 如果前者能运行那么后者也应该能运行。

psql打印出的最后一行是提示符，它表示psql正听着你说话，这个时候你就可以敲入 SQL查询到一个psql维护的工作区中。试验一下下面的命令：

```
mydb=> SELECT version();
                                         version
------------------------------------------------------------------------------------------
 PostgreSQL 9.6.0 on x86_64-pc-linux-gnu, compiled by gcc (Debian 4.9.2-10) 4.9.2, 64-bit
(1 row)

mydb=> SELECT current_date;
    date
------------
 2016-01-07
(1 row)

mydb=> SELECT 2 + 2;
 ?column?
----------
        4
(1 row)
```

psql程序有一些不属于SQL命令的内部命令。它们以反斜线开头，""。 欢迎信息中列出了一些这种命令。比如，你可以用下面的命令获取各种PostgreSQL的SQL命令的帮助语法：

```
mydb=> \h
```

要退出psql，输入：

```
mydb=> \q
```

psql将会退出并且让你返回到命令行shell。 （要获取更多有关内部命令的信息，你可以在psql提示符上键入?。） psql的完整功能在psql中有文档说明。在这份文档里，我们将不会明确使用这些特性，但是你自己可以在需要的时候使用它们。



# Set up Postgres on Mac

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

# Set up Postgres on Heroku

Heroku create postgresql addons

```
 3453  heroku addons:create heroku-postgresql:hobby-dev
 3454  heroku addons
 3459  heroku pg:psql
 3460  heroku pg:info
```



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

# 

# Set up Postgres on Cloud 9

### Install Postgres via Yum

```
sudo yum install postgresql postgresql-server postgresql-devel postgresql-contrib postgresql-docs
```

### Run postgres service init

```
sudo service postgresql initdb
```

### Edit postgres conf to connect via localhost:5432

```
sudo vim /var/lib/pgsql9/data/postgresql.conf
```

Uncomment `listen_addresses` and `port`

```
#listen_addresses = 'localhost'
```

to

```
listen_addresses = 'localhost'
```

AND

```
#port = 5432
```

to

```
port = 5432
```

exit vim…

### Update `pg_hba.conf` file for `ec2-user` auth:

```
sudo vim /var/lib/pgsql9/data/pg_hba.conf
```

Edit conf to be:

```
# TYPE  DATABASE        USER            ADDRESS                 METHOD
# "local" is for Unix domain socket connections only
local   all             all                                     trust
# IPv4 local connections:
host    all             ec2-user        127.0.0.1/0             trust
# IPv6 local connections:
host    all             all             ::1/128                 md5
```

### Start / Restart postgres server

```
sudo service postgresql start
```

or

```
sudo service postgresql restart
```

### Login as Postgres User and Change Password / Add ec2-user

```
sudo su - postgres # login as postgres user
psql -U postgres # login to postgres db as postgres user
```

Change Password:

```
ALTER USER postgres WITH PASSWORD 'YOUR_PASSWORD';
```

Add `ec2-user` :

```
CREATE USER "ec2-user" SUPERUSER;
ALTER USER "ec2-user" WITH PASSWORD 'YOUR_PASSWORD';
```

Exit postgres:

```
postgres=# \q
```

Logout of postgres user account:

```
exit
```

### Login to Postgres from `ec2-user`

```
psql postgres
```

Create your custom databases from there…