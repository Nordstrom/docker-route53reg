FROM nordstrom/awscli
MAINTAINER Innovation Platform Team "invcldtm@nordstrom.com"

COPY conf/prepareRoute.sh /bin/
COPY conf/route.json.tmpl /templates/

ENTRYPOINT ["/prepareRoute.sh"]
