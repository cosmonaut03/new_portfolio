# rails-new-template

docker build -t n20-r3.2.3-rails-new .
docker run --rm -v ${PWD}:/app n20-r3.2.3-rails-new rails new . --force --database=postgresql --skip-bundle
