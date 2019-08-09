Legacy Unlight Docker
===

The CPA is released Unlight's [source code](https://github.com/unlightcpa/Unlight) but there is no any document and stable version for setup.
This repository provides a pre-package docker image for compile client (SWF) and server (Ruby) and lets anyone can serve their Unlight server.

## Requirement

* Docker 19.03+
* Docker Compose 1.24+
* git 2+
* make

## Install

For compile client or serve a game server, you need to download this repository to your local machine or server.

```bash
git clone https://github.com/open-unlight/legacy-unlight-docker.git
cd legacy-unlight-docker
# Download offical source code and assets
git submodule init
git submodule update --recursive
```

## Usage

### Client

The fonts are included in `Unlight.swf`, you have to download the font file and put it into `fonts/` directory.

|Language|Required Fonts|
|--------|--------------|
|Traditional Chinese| cwming.ttf (cwTeXMing 明體), wt004.ttf (王漢宗特明體), nbr.ttf|

> `nbr.ttf` is `Bradley Gratis` but with customize.

Next, you need to configure `compile.env` to define the preferences you want.

```bash
# Copy example file and modify
cp compile.env.example compile.env
```

Then you can compile `Unlight.swf` via Docker.

```bash
make client
```

> More customize options will add soon

### Server

To setup server, you need build server docker image in first run.

Before start, we need to setup server config.

```bash
cp server.env.example server.env
```

> If you host the database and Memcached in another server, please update the config.

```bash
make setup
```

This command will build a docker image and initialize load database.

After the server is ready, we can start all servers

```bash
make start
```

After servers are ready, we have to set up static files.

```bash
bin/prepare-assets --t_chinese -P dist/
```

> The `dist/` directory is your web server root folder includes Unlight's `public/` directory. This will change SWF to your locale.

##### Customize Docker

The Docker Compose's scale feature will break our services, please add your external server to `docker-compose.custom.yml`

```yml
version: '3.4'
x-image: &image
  image: unlight-server
  env_file:
    - server.env
  restart: unless-stopped
  lobby2_server:
    <<: *image
    command: server lobby 12002
    ports:
      - '12003:12002'
```

And run `make start` to start the new server.

#### Customize MySQL

If you plan to use Docker to run your database server and want to change something, add your `.cnf` to `db/conf.d` and restart the database.

```cnf
; my.cnf
[mysqld]
character-set-server=utf8mb4
collation-server=utf8mb4_unicode_ci
init_connect='SET NAMES utf8mb4'

[client]
default-character-set=utf8mb4

[mysql]
default-character-set=utf8mb4
```

And run `bin/unlight restart db` to restart your database server.

##### Unlight Command

This project use shared docker-compose.yml, please use `bin/unlight` to replace with `docker-compose` otherwise you will lose config.
