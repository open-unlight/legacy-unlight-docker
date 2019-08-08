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

TODO

### 伺服端

TODO
