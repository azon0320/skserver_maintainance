FROM ubuntu:18.04
COPY sources.list /etc/apt/sources.list
COPY phpbrew.phar /root/phpbrew.phar

ARG TARGET_PHP_VER=7.2.22

RUN export PHPBREW_PHP=php-${TARGET_PHP_VER} && \
    export PHPBREW_HOME=/root/.phpbrew && \
    export PHPBREW_ROOT=/root/.phpbrew && \
    export PHPBREW_PATH=${PHPBREW_ROOT}/php/${PHPBREW_PHP}/bin && \
    export PATH=$PATH:${PHPBREW_PATH} && \
    # Non-interactive apt
    export DEBIAN_FRONTEND=noninteractive && \
    # change directory
    cd ~ && \
    # APT update source
    apt update && \
    # APT install dep
    apt install --yes \
    php-cli \
    php-bz2 \
    php-xml \
    libxml2-dev \
    libssl-dev \
    libbz2-dev \
    libcurl4-gnutls-dev \
    libreadline-dev \
    libxslt-dev \
    libyaml-dev \
    autoconf \
    curl && \
    # Get phpbrew
    # cp /home/util/phpbrew.phar ~/phpbrew.phar
    chmod a+x ./phpbrew.phar && \
    mkdir -p ~/.phpbrew/distfiles && \
    # Download PHP Package ( from faster mirror )
    curl -L -o ${PHPBREW_ROOT}/distfiles/${PHPBREW_PHP}.tar.bz2 http://ftp.ntu.edu.tw/php/distributions/${PHPBREW_PHP}.tar.bz2 && \
    # Install for using package
    ./phpbrew.phar install ${TARGET_PHP_VER} +zts +default +openssl && \
    # Install extensions PocketMine required
    ./phpbrew.phar extension install https://github.com/azon0320/pthreads && \
    ./phpbrew.phar extension install yaml && \
    ./phpbrew.phar extension install sqlite3 && \
    # Delete unused deps
    apt remove --yes php-cli php-bz2 autoconf && \
    apt autoremove --yes && \
    # Move to HOME
    # mv ~/.phpbrew/php/php-${TARGET_PHP_VER} /home/php && \
    rm -rf ~/.phpbrew/build && \
    rm -rf ~/.phpbrew/distfiles
    # rm phpbrew.phar

ENV PATH="${PATH}:/root/.phpbrew/php/php-7.2.22/bin"

WORKDIR	/home/data

CMD ["php", "-v"]

