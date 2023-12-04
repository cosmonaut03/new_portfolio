## 起動方法

### 起動準備

1. `$ docker compose build`
2. `$ docker compose run --rm web rails db:create`

### 起動

1. `$ docker compose up`
2. open http://localhost:3000

### 不要ファイルの削除

1. `$ rm -rf Dockerfile.tmp && rm -rf scripts`