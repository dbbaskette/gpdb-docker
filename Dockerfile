#
#  Dockerfile for a GPDB SNE Sandbox GPCC Image
#

FROM pivotaldata/gpdb-base
MAINTAINER dcomingore@pivotal.io

#Load Files
COPY * /tmp/

#GPCC Prereqs
RUN echo -e "yes\n" | yum install vixie-cron

#GPCC Core Install
RUN unzip /tmp/greenplum-cc-web-2.0.0-build-32-RHEL5-x86_64.zip -d /tmp/ \
        && rm /tmp/greenplum-cc-web-2.0.0-build-32-RHEL5-x86_64.zip \
        && echo -e "yes\n\nyes\nyes\n" | /tmp/greenplum-cc-web-2.0.0-build-32-RHEL5-x86_64.bin

# GPCC Post-Core Install
RUN su gpadmin -l -c "source /usr/local/greenplum-cc-web/gpcc_path.sh" \
        && su gpadmin -l -c "source /usr/local/greenplum-db/greenplum_path.sh" \
        && service sshd start \
        && su gpadmin -l -c "/usr/local/greenplum-db/bin/gpstart -a" \
        && su gpadmin -l -c "psql -d gpadmin -c '''create database gpperfmon;'''" \
        && su gpadmin -l -c "echo -e 'pivotal\npivotal\n' | createuser -s -l -P gpmon" \

#Set up environmentals
EXPOSE 5432 22 28080
VOLUME /gpdata

# Set the default command to run when starting the container
CMD echo "127.0.0.1 $(cat ~/orig_hostname)" >> /etc/hosts \
        && service sshd start \
        && su gpadmin -l -c "/usr/local/bin/run.sh" \
        && su gpadmin -l -c "echo export GPPERFMONHOME=/usr/local/greenplum-cc-web-2.0.0-build-32 >> ~/.bashrc;source ~/.bashrc;psql -d gpadmin -c '''create database gpperfmon;''';echo -e 'pivotal\npivotal\n' | createuser -s -l -P gpmon;echo -e 'host all gpmon samenet trust' >> /gpdata/master/gpseg-1/pg_hba.conf;source /usr/local/greenplum-db/greenplum_path.sh;gpstop -u;/usr/local/greenplum-cc-web-2.0.0-build-32/bin/gpcmdr --setup --config_file /tmp/gpcmdr.conf;/usr/local/greenplum-cc-web-2.0.0-build-32/bin/gpcmdr --start gpdb_docker" \
        && /bin/bash
