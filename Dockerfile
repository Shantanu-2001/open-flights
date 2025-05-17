# Dockerfile

FROM ruby:3.1

# Set environment variables
ENV RAILS_ENV=development \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    NODE_OPTIONS=--openssl-legacy-provider

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  postgresql-client

# Set working directory
WORKDIR /app

# Copy Gemfiles and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy rest of the application code
COPY . .

# Precompile assets (optional: mostly for production)
# RUN bundle exec rake assets:precompile

# Expose port and start Rails server
EXPOSE 3000
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails s -b 0.0.0.0"]
