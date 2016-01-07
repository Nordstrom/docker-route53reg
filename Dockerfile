FROM nordstrom/awscli
MAINTAINER Innovation Platform Team "invcldtm@nordstrom.com"

COPY conf /

ENTRYPOINT ["/prepareRoute.sh"]
