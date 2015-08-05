FROM zazo/rails

RUN apt-get -y -q install cron
RUN rake assets:precompile
RUN chown www-data:www-data -R /usr/src/app
RUN bundle exec whenever -w

EXPOSE 80
CMD rake db:migrate && foreman start
