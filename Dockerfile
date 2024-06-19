# ベースイメージを指定
FROM ruby:3.3.3

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  postgresql-client \
  npm && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Yarnをインストール
RUN npm install -g yarn

# アプリケーションのディレクトリを作成
RUN mkdir /app

# 作業ディレクトリを設定
WORKDIR /app

# GemfileとGemfile.lockをコピー
COPY Gemfile Gemfile.lock ./

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

RUN gem install bundler:2.3.7

# バンドルインストールを実行
RUN bundle install

# アプリケーションのコードをコピー
COPY . .

# エントリポイントスクリプトをコピーして実行権限を付与
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# エントリポイントを指定
ENTRYPOINT ["entrypoint.sh"]

# サーバーを起動
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
ARG RUBY_VERSION=3.3.3
