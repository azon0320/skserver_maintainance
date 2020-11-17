# PHP 7.2.22 CLI
docker image for PocketMine

No server core binary phar file preset, please upload by self

## Prepare your fastest Ubuntu APT Source `sources.list`
update source.list to `util/sources.list`, Dockerfile will copy it into /etc/apt/sources.list

Default sources.list is from aliyun.

## Start build
~~~
make
~~~

## Run image
Run image and print php installed modules
~~~
docker run --rm pmcli-7.2.22:latest php -m
~~~

Run image and execute core.phar
~~~
# Create server data directory
mkdir -p $(pwd)/data

docker run -v "$(pwd)/data:/home/data" -p '19132:19132/udp' pmcli-7.2.22:latest php core.phar
~~~

## Port exports
* `19132/udp` PocketMine server udp port

## Data Volume
* `/home/data` Server data directory, including `worlds,plugins,etc...`
