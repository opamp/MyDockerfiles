## -*- docker-image-name: "gollum-docker" -*-
FROM opamp/archlinux:latest
MAINTAINER opamp_sando <opampg@gmail.com>

WORKDIR /
RUN echo 'Server = http://ftp.jaist.ac.jp/pub/Linux/ArchLinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
RUN pacman -Syu --noconfirm ruby python2 clisp git gcc make icu > /dev/null

# Setup User
RUN mkdir -p /srv/wiki
RUN groupadd gollum
RUN useradd -m -g gollum -G gollum,wheel,http gollum
RUN chown -R gollum:gollum /srv/wiki

USER gollum
ENV HOME /home/gollum
ENV PATH /usr/bin:/home/gollum/.gem/ruby/2.2.0/bin

RUN gem install gollum bundler thin --no-ri --no-rdoc > /dev/null

WORKDIR /srv/wiki
ADD run.lisp /home/gollum/run.lisp

CMD ["/usr/bin/clisp", "/home/gollum/run.lisp"]
