FROM postgres:9.6
MAINTAINER "Michael Rudd"

USER root
COPY temporal_tables/temporal_tables.so /opt/rh/rh-postgresql96/root/usr/lib64/pgsql/temporal_tables.so
COPY temporal_tables/temporal_tables.control /opt/rh/rh-postgresql96/root/usr/share/pgsql/extension/temporal_tables.control
COPY temporal_tables/temporal_tables--1.2.0.sql /opt/rh/rh-postgresql96/root/usr/share/pgsql/extension/temporal_tables--1.2.0.sql
USER postgres
