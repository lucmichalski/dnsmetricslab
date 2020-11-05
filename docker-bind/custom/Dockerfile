#
# still in development - the goal is that it can do dnstap
#

ARG centos_version

# FROM centos:${centos_version}
FROM centos:7

ARG version
ARG build_timestamp

LABEL version=${version}
LABEL build_timestamp=${build_timestamp}
LABEL maintainer="lucas@benning.com.au"

RUN \
        useradd named -u 8510

COPY --chown=root:named etc/* /etc/
COPY --chown=root:root run.sh /

RUN \
        yum -y update \
        && yum -y install gcc make wget libxml2 libxml2-devel python-ply perl libcap libcap-devel vim patch file openssl-devel git autoconf automake libtool gcc-c++ \
        && mkdir /build \
        && cd /build \
        && wget -O bind-9.15.5.tar.gz https://ftp.isc.org/isc/bind9/9.15.5/bind-9.15.5.tar.gz 
RUN \
        cd /build \
        && tar zxvf bind-9.15.5.tar.gz \ 
        && cd bind-9.15.5 \
        && wget -O protobuf-cpp-3.13.0.tar.gz https://github.com/protocolbuffers/protobuf/releases/download/v3.13.0/protobuf-cpp-3.13.0.tar.gz \
        && tar zxvf protobuf-cpp-3.13.0.tar.gz \
        && cd protobuf-3.13.0 \
        && ./autogen.sh \
        && ./configure \
        && make \
        && make install \
        && ldconfig \
        && cd ..
        && wget -O protobuf-c-1.3.3.tar.gz https://github.com/protobuf-c/protobuf-c/releases/download/v1.3.3/protobuf-c-1.3.3.tar.gz
        && tar zxvf protobuf-c-1.3.3.tar.gz \
        && cd protobuf-c-1.3.3 \
        # more work required here - it cant see protobuf that was installed above - think i need to modify configur efor protbuf to go intot he correct location
        && ./configure \
        && make \
        && make install \
        && cd ..
        && git clone https://github.com/farsightsec/fstrm \
        && cd fstrm \
        && ./autogen.sh \
        && ./configure \
        && make \
        && make install \
        && cd .. \
        && ./configure CC="gcc -m64" --enable-threads --enable-dnstap --prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --libexecdir=/usr/libexec --sysconfdir=/etc --sharedstatedir=/var/lib --localstatedir=/var --libdir=/usr/lib64 --includedir=/usr/include --datadir=/usr/share --infodir=/usr/share/info --mandir=/usr/share/man --disable-static --enable-fixed-rrset --with-pic --with-docbook-xsl=/usr/share/sgml/docbook/xsl-stylesheets 'CFLAGS= -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic' 'CPPFLAGS= -DDIG_SIGCHASE' --enable-filter-aaaa --with-libxml2=yes --disable-chroot \
        && make \
        && make install \

RUN \
    yum clean all \
	&& chmod 700 /run.sh \
	&& chmod 640 /etc/named* \
	&& chmod 600 /etc/named.conf.tmpl 

EXPOSE 53
EXPOSE 53/udp

CMD [ "/run.sh" ]