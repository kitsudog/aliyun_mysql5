FROM kitsudo/aliyun_centos6.6
MAINTAINER Dave Luo <kitsudo163@163.com>
RUN yum install -y \
    mysql-server \
    mysql

ADD run.sh /root/

EXPOSE 3306
ENTRYPOINT ["/root/run.sh"]
