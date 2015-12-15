FROM nordstrom/awscli:latest
MAINTAINER Innovation Platform Team "invcldtm@nordstrom.com"

COPY conf/* /templates/

ENTRYPOINT ["/templates/prepareRoute.sh"]