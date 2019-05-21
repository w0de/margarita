FROM tiangolo/uwsgi-nginx-flask:python2.7
LABEL maintainer="it-cpe@gusto.com"
LABEL description="Reposado/Margarita instance for use by Gusto's IT CPE team"

COPY saml margarita requirements.txt /app/

RUN apt-get update -y && apt-get -y install libxmlsec1-dev

RUN ln -s /reposado/code/reposadolib /app/ && ln -s /reposado/code/preferences.plist /app/

RUN pip install --no-cache-dir -r requirements.txt

HEALTHCHECK --interval=5s --timeout=2s --retries=12 \
  CMD curl --silent --fail localhost:9200/_cluster/health || exit 1
