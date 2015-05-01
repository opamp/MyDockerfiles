FROM opamp/archlinux:latest
MAINTAINER opamp_sando <opampg@gmail.com>

# Install redmine
WORKDIR /srv
RUN echo 'Server = http://ftp.tsukuba.wide.ad.jp/Linux/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
RUN pacman -Syu --noconfirm base-devel ruby clisp sqlite imagemagick mercurial subversion > /dev/null
RUN curl -O http://www.redmine.org/releases/redmine-3.0.2.tar.gz &&tar xfz redmine-3.0.2.tar.gz &&rm -f *.tar.gz &&mv redmine-3.0.2 redmine
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

RUN gem install bundler thin --no-ri --no-rdoc > /dev/null
RUN bundle install --without rmagick development test --path vendor/bundle

EXPOSE 1080
CMD ["clisp" ,"./run.lisp"]
