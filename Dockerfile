FROM nordstrom/awscli
MAINTAINER Innovation Platform Team "invcldtm@nordstrom.com"

COPY prepareRoute.sh /bin/
COPY route.json.tmpl /templates/

ENTRYPOINT ["/bin/prepareRoute.sh"]
