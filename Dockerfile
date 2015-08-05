FROM zazo/rails

RUN apt-get -y -q install rsyslog cron
RUN rake assets:precompile
RUN chown www-data:www-data -R /usr/src/app
RUN bundle exec whenever -w

EXPOSE 80
CMD service rsyslog start && \
    service cron start && \
    rake db:migrate && \
    foreman start
