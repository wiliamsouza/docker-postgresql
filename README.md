docker-postgresql
-----------------

Docker postgresql server generic image source. This is based on `ubuntu:14.04` image.

Image
-----

You can `pull` a ready to use image from Docker
[index](https://index.docker.io/u/wiliamsouza/) running:

```
$ docker.io pull wiliamsouza/postgresql
```

Or build this repository:

```
$ git clone https://github.com/wiliamsouza/docker-postgresql.git
$ cd docker-postgresql/
$ docker.io build -t wiliamsouza/postgresql .
```

Change `wiliamsouza/postgresql` to your Docker index username.

Container
---------

This image uses volumes and environment variables to control the postgresql server
configuration.

Volumes:

* `/etc/postgresql/conf.d`: Change server configurations using it.
* `/var/lib/postgresql`: Data goes here.
* `/var/log/postgresql`: Access log from the container using it.

You pass with `-v` docker option. Don't forget to use absolute path here.

Environment variable:

* `POSTGRESQL_DATABASE`: Database name.
* `POSTGRESQL_USER`: If `POSTGRESQL_DATABASE` is specified create a user.
* `POSTGRESQL_PASSWORD`: Password for `POSTGRESQL_USER`.
* `POSTGRESQL_CHARACTER_SET`: Character set for `POSTGRESQL_DATABASE`.
* `POSTGRESQL_COLLATE`: Collate for `POSTGRESQL_DATABASE`.
* `GRANT_HOSTNAME`: Hostname used on `GRANT` for `POSTGRESQL_DATABASE`.

You pass with `-e` docker option.

Shell access:

```
$ docker.io run -p 5432:5432 -i \
-v `pwd`/volumes/log:/var/log/postgresql \
-v `pwd`/volumes/lib:/var/lib/postgresql \
-v `pwd`/volumes/conf.d:/etc/postgresql/conf.d \
 -e POSTGRESQL_DATABASE=api -e POSTGRESQL_USER=api \
-e POSTGRESQL_PASSWORD=12345 -t wiliamsouza/postgresql /bin/bash
```

The command above will start a container give you a shell. Don't
forget to start the service running the `startup &` script.

Usage:

```
$ docker.io run --name postgresql -p 5432:5432 -d \
-v `pwd`/volumes/log:/var/log/postgresql \
-v `pwd`/volumes/lib:/var/lib/postgresql \
-v `pwd`/volumes/conf.d:/etc/postgresql/conf.d \
-e POSTGRESQL_DATABASE=mydb -e POSTGRESQL_USER=myuser \
-e POSTGRESQL_PASSWORD=mypass -t wiliamsouza/postgresql
```

The command above will start a container and return its ID.
