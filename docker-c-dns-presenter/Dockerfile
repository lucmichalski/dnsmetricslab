#
# still in development 
#

FROM ubuntu:14.04

ARG version
ARG build_timestamp

LABEL version=${version}
LABEL build_timestamp=${build_timestamp}
LABEL maintainer="lucas@benning.com.au"


RUN echo deb http://cran.r-project.org/bin/linux/ubuntu trusty/ > /etc/apt/sources.list.d/r.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9


RUN gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
RUN gpg -a --export E084DAB9 | sudo apt-key add -

# Install base packages
# RUN DEBIAN_FRONTEND=noninteractive \
#     apt-get update && apt-get install -y \
#       r-base \
#       r-recommended \
#       r-base-dev \
#       imagemagick \
#       curl \
#       libcurl4-gnutls-dev && \
#     apt-get clean && apt-get autoclean


#         R CMD INSTALL Cairo_1.5-12.2.tar.gz \
#         && R CMD INSTALL brew_1.0-6.tar.gz \
#         && R CMD INSTALL jsonlite_1.7.1.tar.gz \
#         && R CMD INSTALL R.methodsS3_1.8.1.tar.gz \
#         && R CMD INSTALL R.oo_1.24.0.tar.gz \
#         && R CMD INSTALL googleVis_0.6.6.tar.gz \
#         && R CMD INSTALL R.utils_2.10.1.tar.gz \
#         && R CMD INSTALL yaml_2.2.1.tar.gz \
#         && R CMD INSTALL plyr_1.8.6.tar.gz 

# RUN > CRAN.R
# RUN echo 'install.packages("Rcpp", repos="http://cran.r-project.org")' >> CRAN.R
# RUN echo 'install.packages("Matrix", repos="http://cran.r-project.org")' >> CRAN.R
# RUN echo 'install.packages("RSpectra", repos="http://cran.r-project.org")' >> CRAN.R
# RUN echo 'install.packages("CORElearn", repos="http://cran.r-project.org")' >> CRAN.R
# RUN echo 'install.packages("AUC", repos="http://cran.r-project.org")' >> CRAN.R
# RUN echo 'install.packages("network", repos="http://cran.r-project.org")' >> CRAN.R
# RUN echo 'install.packages("sna", repos="http://cran.r-project.org")' >> CRAN.R
# RUN echo 'install.packages("ggplot2", repos="http://cran.r-project.org")' >> CRAN.R
# RUN echo 'install.packages("ggnetwork", repos="http://cran.r-project.org")' >> CRAN.R
# RUN echo 'install.packages("R2HTML", repos="http://cran.r-project.org")' >> CRAN.R

# RUN Rscript CRAN.R
# RUN rm CRAN.R


RUN \
        apt-get update -qq \
        && apt -y install software-properties-common gtk+2.0 build-essential \
        && add-apt-repository -y ppa:dns-stats/presenter \
        && add-apt-repository -y ppa:opencpu/rapache \
        && apt-get update -qq \
        && apt -y install hedgehog-data-manager hedgehog-gui

RUN \
        a2dissite 000-default.conf \
        && a2ensite hedgehog.conf \
        && rm -rf /var/log/apache2/access_log /var/log/apache2/error.log /var/log/apache2/other_vhosts_access.log \
        && ln -s /dev/stdout /var/log/apache2/access_log \
        && ln -s /dev/stderr /var/log/apache2/error.log \
        && ln -s /dev/stdout /var/log/apache2/other_vhosts_access.log 


# RUN \
#         curl -OL https://cran.ms.unimelb.edu.au/src/contrib/Cairo_1.5-12.2.tar.gz \
#         && curl -OL https://cran.ms.unimelb.edu.au/src/contrib/brew_1.0-6.tar.gz \
#         && curl -OL https://cran.ms.unimelb.edu.au/src/contrib/jsonlite_1.7.1.tar.gz \
#         && curl -OL https://cran.ms.unimelb.edu.au/src/contrib/R.oo_1.24.0.tar.gz \
#         && curl -OL https://cran.ms.unimelb.edu.au/src/contrib/R.methodsS3_1.8.1.tar.gz \
#         && curl -OL https://cran.ms.unimelb.edu.au/src/contrib/googleVis_0.6.6.tar.gz \
#         && curl -OL https://cran.ms.unimelb.edu.au/src/contrib/R.utils_2.10.1.tar.gz \
#         && curl -OL https://cran.ms.unimelb.edu.au/src/contrib/yaml_2.2.1.tar.gz \
#         && curl -OL https://cran.ms.unimelb.edu.au/src/contrib/plyr_1.8.6.tar.gz 

# RUN \ 
#         R CMD INSTALL Cairo_1.5-12.2.tar.gz \
#         && R CMD INSTALL brew_1.0-6.tar.gz \
#         && R CMD INSTALL jsonlite_1.7.1.tar.gz \
#         && R CMD INSTALL R.methodsS3_1.8.1.tar.gz \
#         && R CMD INSTALL R.oo_1.24.0.tar.gz \
#         && R CMD INSTALL googleVis_0.6.6.tar.gz \
#         && R CMD INSTALL R.utils_2.10.1.tar.gz \
#         && R CMD INSTALL yaml_2.2.1.tar.gz \
#         && R CMD INSTALL plyr_1.8.6.tar.gz 

COPY --chown=root:root run.sh /
COPY --chown=root:root apachectl /usr/sbin/
COPY --chown=root:root startup.R /usr/share/hedgehog/www/R/

RUN \
	chmod 700 /run.sh \
        && chmod 700 /usr/sbin/apachectl


ENTRYPOINT [ "/run.sh" ]