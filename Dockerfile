FROM ruby:3.4-slim

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  libyaml-dev

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000
CMD ["sh", "-c", "if [ \"$RAILS_ENV\" = \"production\" ]; then bundle exec rails assets:precompile; fi && bundle exec rails db:migrate && rails server -b 0.0.0.0"]