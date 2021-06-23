FROM cheppers/phpenv:7.3

COPY files/ /

RUN unzip /build/instantclient-basic-linux.x64-12.2.0.1.0.zip -d /usr/local/ && \
    unzip /build/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip -d /usr/local/ && \
    unzip /build/instantclient-sdk-linux.x64-12.2.0.1.0.zip -d /usr/local/ && \
    ln -s /usr/local/instantclient_12_2 /usr/local/instantclient && \
    ln -s /usr/local/instantclient/libclntsh.so.12.1 /usr/local/instantclient/libclntsh.so && \
    ln -s /usr/local/instantclient/sqlplus /usr/bin/sqlplus && \
    rm -rf /build && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated libaio-dev php7.3-dev php-pear && \
    echo 'instantclient,/usr/local/instantclient' | pecl install oci8-2.2.0 && \
    echo 'extension=oci8.so' > /etc/php/7.3/mods-available/oci8.ini && \
    phpenmod oci8 && \
    apt-get autoclean

