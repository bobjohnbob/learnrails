FROM ruby:2.4.1-alpine
ENV BUNDLE_PATH=/app/bundle \
    APP=/app/src \
    PATH=/app/bin:/bundle/bin:$PATH \
		PID_PATH=/tmp/app/pids
RUN apk add --no-cache \
    bash less nodejs \
    build-base\
    dpkg openssl \
		postgresql-dev \
		linux-headers \
		tzdata \
	&& echo "Hello container!1" >> hello.txt

RUN mkdir -p $BUNDLE_PATH $PID_PATH
VOLUME $APP
WORKDIR $APP
COPY Gemfile .
RUN ls -la && bundle install --path=$BUNDLE_PATH

CMD pwd && rails server -b 0.0.0.0 -P $PID_PATH/server.pid
