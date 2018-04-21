# Dockerfile
FROM seapy/rails-nginx-unicorn
MAINTAINER minung.han(hmu332233@gmail.com)

CMD bundle exec rake assets:precompile && rake db:migrate && foreman start -f Procfile
EXPOSE 80
