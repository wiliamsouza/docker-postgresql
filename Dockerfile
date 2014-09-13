FROM ubuntu:14.04

MAINTAINER Yaroslav Admin <devoto13@gmail.com>

# base
ENV LANG en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US en_US.UTF-8
RUN dpkg-reconfigure locales
RUN apt-get update

RUN apt-get install -y python-software-properties

# supervisor
RUN apt-get install supervisor -y
RUN update-rc.d -f supervisor disable

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# start script
ADD startup /usr/local/bin/startup
RUN chmod +x /usr/local/bin/startup

CMD ["/usr/local/bin/startup"]

# postgresql
RUN apt-get -y install postgresql-9.3
RUN echo "host all all 172.17.0.0/16 md5" >> /etc/postgresql/9.3/main/pg_hba.conf
RUN sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/9.3/main/postgresql.conf
RUN sed -i "s/#include_dir = 'conf.d'/include_dir = 'conf.d'/g" /etc/postgresql/9.3/main/postgresql.conf

VOLUME ["/var/lib/postgresql/9.3/main", "/var/log/postgresql", "/etc/postgresql/9.3/main/conf.d"]

EXPOSE 5432
