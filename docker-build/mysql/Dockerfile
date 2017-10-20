FROM mysql:latest

RUN rm -rf /var/lib/apt/lists/*
RUN printf "[mysqld]\nmax_allowed_packet=64M\n" >> /etc/mysql/my.cnf
RUN printf "log_error=/var/log/mysql/mysql_error.log\n" >> /etc/mysql/my.cnf
#collation-server     = utf8mb4_general_ci # Replaces utf8_general_ci
#character-set-server = utf8mb4            # Replaces utf8