Legacy Unlight Docker
===

CPA 釋出了 Unlight's [原始碼](https://github.com/unlightcpa/Unlight) 但是並沒有提供任何文件或是穩定版本。
為了讓任何人都可以運行他們自己的 Unlight 遊戲，因此這個專案提供了預先封裝的 Docker Image 用來建置客戶端（SWF）和伺服器（Ruby）

## 系統需求

* Docker 19.03+
* Docker Compose 1.24+
* git 2+
* make

## 安裝

不論是編譯客戶端或者伺服器，你都會需要將這個專案的原始碼下載回來。

```
git clone https://github.com/open-unlight/legacy-unlight-docker.git
cd legacy-unlight-docker
# 將官方原本的原始碼及素材下載
git submodule init
git submodule update --recursive
```

## 使用方式

### 客戶端

因為字體檔案會被在編譯的時候加入 `Unlight.swf` 所以需要把對應的字體放到 `fonts/` 資料夾裡面。

|語言|必要字體|
|--------|--------------|
|繁體中文| cwming.ttf (cwTeXMing 明體), wt004.ttf (王漢宗特明體), nbr.ttf|

> `nbr.ttf` 是叫做 `Bradley Gratis` 的字體，但是 Unlight 是有客製化過的。

然後要設定編譯環境，透過設定 `compile.env` 來定義需要的編譯設定。

```bash
# 可以先複製範例檔然後調整
cp compile.env.example compile.env
```

接下來透過 Docker 就可以將 `Unlight.swf` 編譯出來。

```bash
make client
```

> 目前還暫時無法做太多客製化，會陸續加入客製化選項。


### 伺服端

首先，你需要伺服器的 Docker Image 來啟動伺服器，但是在這之前我們需要先設定伺服器。


```bash
cp server.env.example server.env
```

> 如果你打算把 MySQL 和 Memcached 放在其他伺服器，記得修改設定成你的伺服器位置。

```bash
make setup
```

這個指令會將遊戲的初始資料匯入進去，完成之後我們就可以將全部的伺服器打開。

```bash
make start
```

在伺服器啟動之後，我們需要確保遊戲的素材已經切換到目前的語言，所以需要執行以下指令。

```bash
bin/prepare-assets --t_chinese -P dist/
```

> 指令示範的 `dist/` 資料夾是有放著你從 Unlight-Images 抓出來的 `public/` 目錄的資料夾，這樣我們才能將語言切換。

##### 自訂 Docker

因為 Docker Compose 預設的 Scale 機制無法分配 Port 會造成無法開啟，請把你的額外伺服器放到  `docker-compose.custom.yml` 裡面。

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

修改後請記得執行 `make start` 更新伺服器。

##### 自訂 MySQL

如果你打算用 Docker 來當資料庫伺服器，你會需要修改設定來調整你的資料庫，請把你的 `.cnf` 設定檔案放到 `db/conf.d` 裡面，並且重新啟動伺服器。

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

完成後執行 `bin/unlight restart db` 將資料庫重開。

##### Unlight 指令

因為使用了共用的 `docker-compose.yml` 設定，所以請用 `bin/unlight` 來取代 `docker-compose` 指令，以免發生遺失設定的狀況。
