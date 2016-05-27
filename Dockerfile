# Dockerfile companion for Accelerating Healthcare Transactions with Python and PyPy
FROM ubuntu:14.04
MAINTAINER Brian Corbin

ENV LANG=C.UTF-8

ARG PYPY_VERSION=5.1.1

# grab curl so we can fetch the appropriate PyPy version
# install java (OpenJDK) so we can do some comparisons with Python and PyPy
RUN apt-get update && \
    apt-get -y --force-yes dist-upgrade && \
    apt-get update && \
    apt-get install -y curl default-jdk

RUN apt-get install -q -y software-properties-common && \
    add-apt-repository ppa:fkrull/deadsnakes && \
    add-apt-repository ppa:fkrull/deadsnakes-python2.7 && \
    apt-get update && \
    apt-get -y install python2.7 python2.7-dev python3.5 python3.5-dev libffi-dev

RUN set -x && \
    curl -SL "https://bitbucket.org/pypy/pypy/downloads/pypy-${PYPY_VERSION}-linux64.tar.bz2" \
		| tar -xjC /usr/local --strip-components=1

RUN curl -SL http://apache.claz.org//commons/validator/binaries/commons-validator-1.5.1-bin.tar.gz -o /tmp/commons-validator-1.5.1-bin.tar.gz && \
    cd /tmp && \
    tar zxvf commons-validator-1.5.1-bin.tar.gz && \
    mkdir -p /npi/ && \
    cp commons-validator-1.5.1/commons-validator-1.5.1.jar /npi/

# fetch May's NPI data
RUN apt-get install -y unzip && \
    curl -SL http://download.cms.gov/nppes/NPPES_Data_Dissemination_May_2016.zip -o /npi/NPPES_Data_Dissemination_May_2016.zip

COPY wiki_luhn.py /npi/
COPY refined_luhn.py /npi/
COPY crunch_npi.py /npi/
COPY CrunchNPI.java /npi/
COPY main_event.sh /npi/

RUN chmod +x /npi/main_event.sh


CMD ["/usr/local/bin/pypy"]