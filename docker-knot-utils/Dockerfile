#
# still in development 
#

# ARG centos_version

# FROM centos:${centos_version}
FROM centos

ARG version
ARG build_timestamp

LABEL version=${version}
LABEL build_timestamp=${build_timestamp}
LABEL maintainer="lucas@benning.com.au"

RUN \
        yum -y install epel-release \
        && yum -y install knot-utils

COPY --chown=root:root run.sh /

RUN \
	chmod 700 /run.sh


ENTRYPOINT [ "/run.sh" ]