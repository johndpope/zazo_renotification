FROM zazo/rails

RUN apt-get -y -q install rsyslog cron
RUN rake assets:precompile
RUN chown www-data:www-data -R /usr/src/app

EXPOSE 80
CMD bin/start.sh
