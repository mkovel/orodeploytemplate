FROM mysql

RUN rm -rf /var/lib/apt/lists/*
RUN printf "[mysqld]\nmax_allowed_packet=64M\n" >> /etc/mysql/my.cnf