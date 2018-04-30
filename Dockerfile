# Dockerfile
FROM hmu332233/ubuntu-nginx-rails-unicorn:ruby2.3.1
MAINTAINER minung.han(hmu332233@gmail.com)

CMD bundle exec rake assets:precompile && rake db:migrate && foreman start -f Procfile
EXPOSE 80
