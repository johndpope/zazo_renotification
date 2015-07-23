FROM zazo/rails

RUN rake db:migrate
RUN rake assets:precompile
RUN chown www-data:www-data -R /usr/src/app

EXPOSE 8000
