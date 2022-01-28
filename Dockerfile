FROM ruby:2.7.1
ARG RAILS_KEY
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt -y update && apt -y install yarn

RUN apt-get --allow-releaseinfo-change update
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

COPY package*.json ./
RUN yarn install

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN RAILS_ENV=production RAILS_MASTER_KEY=$RAILS_KEY rails webpacker:compile

CMD ["rails", "s"]
