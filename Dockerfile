FROM postgres:9.6
LABEL maintainer="Michael.Rudd@nih.gov"

# Add basic utilities
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils
RUN DEBIAN_FRONTEND=noninteractive apt-get autoclean -y

# Add JDK
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y default-jdk

WORKDIR /opt

# Install liquibase
ADD https://github.com/liquibase/liquibase/releases/download/liquibase-parent-3.8.0/liquibase-3.8.0-bin.tar.gz /tmp
RUN set -e ;\
    mkdir -p liquibase/ ;\
    tar -xzf /tmp/liquibase-3.8.0-bin.tar.gz -C liquibase ;\
    chmod +x liquibase/liquibase ;\
    ln -s liquibase/liquibase /usr/local/bin/ ;\
    rm -f /tmp/*.tar.gz

# Install JDBC Driver
ADD https://jdbc.postgresql.org/download/postgresql-42.2.8.jar /tmp
RUN set -e ;\
    mkdir -p jdbc ;\
    mv -f /tmp/postgresql-42.2.8.jar jdbc ;\
    chmod 644 jdbc/*.jar ;\
    ln -s jdbc/postgresql-42.2.8.jar /usr/local/bin/

# Install Database migration scripts
#COPY database database/
#RUN set -e ;\
#    chmod +x database/*.sh ;\
#    chmod -R a+r database/ ;\
#    (find database -type d -exec chmod a+rx {} \;)

ENTRYPOINT ["/bin/bash"]
