FROM composer:latest

MAINTAINER Kamil Bednarek <kamil@nexilo.uk>

RUN apk add inotify-tools
ADD /scripts/command.sh /command.sh
RUN chmod +x /command.sh

CMD ["/command.sh"]
