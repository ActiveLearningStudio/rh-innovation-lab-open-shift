FROM dpage/pgadmin4 as pgadmin4

USER root
RUN chown 1001:root /pgadmin4 && \
    sed -i 's/5050/1001/g' /etc/passwd && \
    sed -i 's/5050/1001/g' /etc/group && \
    find /pgadmin4 -user 5050 -exec chown 1001 {} \; && \
    find /pgadmin4 -group 5050 -exec chown :0 {} \; && \
    chown 1001:0 /pgadmin4 && chmod 777 /pgadmin4 && \
    chown 1001:0 /var/lib/pgadmin && chmod 777 /var/lib/pgadmin

USER 1001

VOLUME /var/lib/pgadmin
EXPOSE 80 443

ENTRYPOINT ["/entrypoint.sh"]