FROM zazo/rails

RUN apt-get -y -q install cron

RUN rake assets:precompile
RUN chown www-data:www-data -R /usr/src/app

RUN /etc/init.d/cron start
RUN /etc/init.d/cron status
RUN bundle exec whenever -w
RUN crontab -l

EXPOSE 80
CMD rake db:migrate && foreman start
