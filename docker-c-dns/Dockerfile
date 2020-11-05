#
# still in development 
#

# ARG centos_version

# FROM centos:${centos_version}
FROM ubuntu:xenial

ARG version
ARG build_timestamp

LABEL version=${version}
LABEL build_timestamp=${build_timestamp}
LABEL maintainer="lucas@benning.com.au"

RUN \
        apt -y update \
        && apt -y install software-properties-common
RUN \
        add-apt-repository ppa:dns-stats/compactor \
        && apt -y update \
        && apt -y install dns-stats-compactor



COPY --chown=root:root run.sh /

RUN \
	chmod 700 /run.sh


ENTRYPOINT [ "/run.sh" ]