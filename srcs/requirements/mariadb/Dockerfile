FROM alpine:3.21

RUN apk update && apk upgrade && \
    apk add mariadb mariadb-client mariadb-openrc

COPY conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY ./tools/entrypoint.sh ./

RUN chmod +x ./entrypoint.sh

# ENTRYPOINT ["./entrypoint.sh"]

# # srcs/requirements/mariadb/Dockerfile
# FROM alpine:3.21

# # 1) Installer MariaDB + outils utiles
# RUN apk update && apk upgrade && \
#     apk add --no-cache mariadb mariadb-client tzdata tini

# # 2) Préparer les répertoires et permissions
# RUN mkdir -p /run/mysqld /etc/my.cnf.d && \
#     chown -R mysql:mysql /run/mysqld /var/lib/mysql

# # 3) Initialiser le datadir (tables système)
# RUN mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql > /dev/null

# # 4) Copier la configuration serveur
# #    (Assure-toi d'avoir ce fichier dans: srcs/requirements/mariadb/conf/mariadb-server.cnf)
# COPY conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

# # 5) Entrypoint: script d'init (crée DB/USER si 1er run) puis lance mysqld en foreground
# COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
# RUN chmod +x /usr/local/bin/entrypoint.sh

# EXPOSE 3306
# ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]

# Base des donnees

# database.db -> SQL; 
# NoSQL 
# { 
#     "user" : rabalaz, 
#     "password" : 123,
# } -> JSON



# database.db -> Accessibilite, securite

# Server -> Activer le network, securite.

# mariadb - client -> CLI pour se connecter au server et gerer la database (db)

