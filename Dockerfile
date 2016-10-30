FROM kitsudo/aliyun_centos6.6
MAINTAINER Dave Luo <kitsudo163@163.com>
RUN yum install -y \
    mysql-server \
    mysql

VOLUME /var/lib/mysql

RUN service mysqld start

EXPOSE 3306
CMD ["/usr/bin/mysqld_safe"]
