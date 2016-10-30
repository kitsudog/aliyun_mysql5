FROM kitsudo/aliyun_centos6.6
MAINTAINER Dave Luo <kitsudo163@163.com>
RUN yum install -y \
    mysql-server \
    mysql

RUN /etc/init.d/mysqld start
RUN /etc/init.d/mysqld stop

EXPOSE 3306
CMD ["/usr/bin/mysqld_safe"]
