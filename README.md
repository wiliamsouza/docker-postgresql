docker-postgresql
-----------------

Docker postgresql server generic image source. This is based on `ubuntu:14.04` image.

If mounted data volume is empty and all environment variables are specified new database and user will be created (see environment variables below).

Image
-----

You can `pull` a ready to use image from Docker
[index](https://index.docker.io/u/devoto13/) running:

```
$ docker pull devoto13/postgresql
```

Or build this repository:

```
$ git clone https://github.com/devoto13/docker-postgresql.git
$ cd docker-postgresql/
$ docker build -t devoto13/postgresql .
```

Change `devoto13/postgresql` to your Docker index username.

Container
---------

This image uses volumes and environment variables to control the postgresql server
configuration.

Volumes:

* `/etc/postgresql/9.3/main/conf.d`: Change server configurations using it.
* `/var/lib/postgresql/9.3/main`: Data goes here.
* `/var/log/postgresql`: Access log from the container using it.

You pass with `-v` docker option. Don't forget to use absolute path here.

Environment variable:

* `POSTGRESQL_DATABASE`: Database name.
* `POSTGRESQL_USER`: Owner of `POSTGRESQL_DATABASE`.
* `POSTGRESQL_PASSWORD`: Password for `POSTGRESQL_USER`.

You pass with `-e` docker option.

Shell access:

```
$ docker run -p 5432:5432 -i \
-v `pwd`/volumes/log:/var/log/postgresql \
-v `pwd`/volumes/lib:/var/lib/postgresql/9.3/main \
-v `pwd`/volumes/conf.d:/etc/postgresql/9.3/main/conf.d \
-e POSTGRESQL_DATABASE=api -e POSTGRESQL_USER=api \
-e POSTGRESQL_PASSWORD=12345 -t devoto13/postgresql /bin/bash
```

The command above will start a container give you a shell. Don't
forget to start the service running the `startup &` script.

Usage:

```
$ docker run --name postgresql -p 5432:5432 -d \
-v `pwd`/volumes/log:/var/log/postgresql \
-v `pwd`/volumes/lib:/var/lib/postgresql/9.3/main \
-v `pwd`/volumes/conf.d:/etc/postgresql/9.3/main/conf.d \
-e POSTGRESQL_DATABASE=mydb -e POSTGRESQL_USER=myuser \
-e POSTGRESQL_PASSWORD=mypass -t devoto13/postgresql
```

The command above will start a container and return its ID.
