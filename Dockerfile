FROM ruby:2.5

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    postgresql-client \
    nodejs \
    vim \
    && rm -rf /var/lib/apt/lists/*
    
RUN mkdir /noticeboard

WORKDIR /noticeboard

COPY Gemfile /noticeboard/Gemfile
COPY Gemfile.lock /noticeboard/Gemfile.lock

RUN bundle install

COPY . /noticeboard

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]