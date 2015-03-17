FROM opamp/archlinux:latest
MAINTAINER opamp_sando <opampg@gmail.com>

# Install redmine
WORKDIR /srv
RUN pacman -Syu --noconfirm ruby clisp sqlite imagemagick gcc make > /dev/null
RUN curl -O http://www.redmine.org/releases/redmine-3.0.1.tar.gz &&tar xfz redmine-3.0.1.tar.gz &&rm -f *.tar.gz &&mv redmine-3.0.1 redmine
RUN rm -fr /srv/redmine/config
ADD config /srv/redmine/config

# Setup user
RUN groupadd redmine
RUN useradd -m -g redmine -G redmine,wheel,http redmine
RUN chown -R redmine:redmine /srv/redmine

USER redmine
ENV HOME /home/redmine
ENV PATH /usr/bin:/home/redmine/.gem/ruby/2.2.0/bin

WORKDIR /srv/redmine
ADD run.lisp /srv/redmine/run.lisp
ADD db /srv/redmine/db.tmp

RUN gem install bundler thin --no-ri --no-rdoc
RUN bundle install --without rmagick development test --path vendor/bundle

CMD ["clisp" ,"./run.lisp"]
#RUN bundle exec rake generate_secret_token
#RUN RAILS_ENV=production bundle exec rake db:migrate
#RUN RAILS_ENV=production REDMINE_LANG=ja bundle exec rake redmine:load_default_data

#EXPOSE 1080
#CMD ["thin","-e","production", "-p", "1080", "start"]
