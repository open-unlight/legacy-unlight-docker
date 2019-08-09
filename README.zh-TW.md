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

TODO
