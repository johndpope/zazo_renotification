FROM zazo/rails

RUN apt-get -y -q install cron
RUN rake assets:precompile

EXPOSE 80
CMD bin/start.sh
