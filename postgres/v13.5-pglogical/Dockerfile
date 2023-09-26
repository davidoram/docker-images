FROM postgres:13.5
COPY postgresql.conf.sample /usr/share/postgresql/postgresql.conf.sample
RUN curl https://techsupport.enterprisedb.com/api/repository/dl/default/release/deb | bash
RUN apt install -y postgresql-common
ENV YES yes
RUN /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
RUN apt-get install -y postgresql-13-pglogical