FROM zazo/rails

RUN apt-get -y -q install rsyslog cron
RUN rake assets:precompile
RUN chown www-data:www-data -R /usr/src/app

EXPOSE 80
CMD service rsyslog start && \
    service cron start && \
    bundle exec whenever -w && \
    rake db:migrate && \
    foreman start
