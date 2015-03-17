FROM opamp/archlinux:latest
MAINTAINER opamp_sando <opampg@gmail.com>

RUN pacman --noconfirm -q -Syu lighttpd && rm -fr /etc/lighttpd
ADD lighttpd /etc/lighttpd

RUN pacman --noconfirm -q -S ruby perl php php-cgi clisp && rm -f /etc/php/php.ini
ADD php.ini /etc/php/php.ini

CMD ["/usr/bin/lighttpd-angel", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
