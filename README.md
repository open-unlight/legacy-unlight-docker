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

TODO
