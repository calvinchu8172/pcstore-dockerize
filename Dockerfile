FROM drecom/ubuntu-ruby:2.3.3

ENV LANG C.UTF-8
# 指定時區，否則會用 GMT
ENV TZ Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -qq && apt-get install -y build-essential imagemagick libmagickwand-dev qt5-default libqt5webkit5-dev nodejs redis-server xvfb mysql-client

ENV APP_HOME /home/app/rails-app

ENV DOCKERIZE_VERSION v0.6.1

RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz


RUN mkdir -p $APP_HOME
COPY ./pcstore $APP_HOME
WORKDIR $APP_HOME
RUN mkdir -p tmp/bids
RUN bundle install

# Add a script to be executed every time the container starts.
COPY ./pcstore/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# 設定 Server Port
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]