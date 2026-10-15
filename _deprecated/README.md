# Deprecated Docker Images

These images are **End of Life (EOL)** or no longer worth rebuilding, and are excluded from the weekly rebuild.

## Why are these here?

Images in this directory have been deprecated because:
- The underlying software has reached End of Life
- Security updates are no longer provided by upstream maintainers
- Modern alternatives exist

The build tooling (`_tools/sorting.sh`, `_tools/graph-gen.sh`) ignores this directory, so these images are not built, tested, pushed or shown in the dependency graph.

## Can I still use these images?

**Yes.** The images remain available on Docker Hub for existing projects:
- `nfqlt/php71-*`, `nfqlt/php72-*`, `nfqlt/php73-*`, `nfqlt/php74-*`, `nfqlt/php80-*`
- `nfqlt/node16`, `node18`, `node20`, `node21` and the matching `nfqlt/nodeserver*`
- `nfqlt/cypress9`, `nfqlt/cypress12`
- `nfqlt/mysql55`, `mysql56`, `mysql57` (and their `-data` images)
- `nfqlt/elasticsearch56`, `68`, `72`, `75`, `77`, `79`, `710`, `716` (and their `-data` images)
- `nfqlt/redis60`, `nfqlt/rabbitmq38`
- `nfqlt/phantomjs19`, `phantomjs21`, `nfqlt/thrift093`, `thrift0110`
- `nfqlt/wkhtmltopdf125`, `wkhtmltopdf125-broken`, `wkhtmltopdf126-broken`, `wkhtmltopdf126`
- `nfqlt/linker18ce`, `nfqlt/mailhog`

However, they will **not receive updates**. We strongly recommend migrating to supported versions.

## Migration Guide

| Deprecated | Migrate To | Notes |
|------------|------------|-------|
| PHP 7.1 – 7.3 | PHP 8.3+ | [PHP Migration Guide](https://www.php.net/manual/en/migration83.php) |
| PHP 7.4 | PHP 8.3+ | [PHP Migration Guide](https://www.php.net/manual/en/migration80.php) |
| PHP 8.0 | PHP 8.3+ | [PHP Migration Guide](https://www.php.net/manual/en/migration83.php) |
| Node 16 / 18 / 20 / 21 | Node 24 | [Node Upgrade Guide](https://nodejs.org/en/blog/migrations) |
| MySQL 5.5 / 5.6 / 5.7 | MySQL 8.0+ | [MySQL Upgrade Guide](https://dev.mysql.com/doc/refman/8.4/en/upgrading.html) |
| Elasticsearch 5.6 – 7.16 | Elasticsearch 8.0+ | [ES Upgrade Guide](https://www.elastic.co/guide/en/elasticsearch/reference/current/setup-upgrade.html) |
| Redis 6.0 | Redis 7.0 | [Redis Upgrade Guide](https://redis.io/docs/latest/operate/rc/databases/version-management/upgrade-version/) |
| RabbitMQ 3.8 | RabbitMQ 4.x | [RabbitMQ Upgrade Guide](https://www.rabbitmq.com/docs/upgrade) |
| MailHog | MailPit | Pull MailPit image for SMTP testing instead of MailHog  |
| linker18ce | Not needed | Use `xdebug-config` with Docker socket |


## linker18ce Replacement

The `linker18ce` container is no longer needed. The `xdebug-config` tool now uses Docker API directly.

**Old docker-compose.yml:**
```yaml
services:
  php:
    image: nfqlt/php83-fpm
  linker:
    image: nfqlt/linker18ce
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```

**New docker-compose.yml:**
```yaml
services:
  php:
    image: nfqlt/php83-fpm
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock  # For xdebug-config
```

## EOL Dates

| Software | EOL Date |
|----------|----------|
| PHP 7.1 | December 2019 |
| PHP 7.2 | November 2020 |
| PHP 7.3 | December 2021 |
| PHP 7.4 | November 2022 |
| PHP 8.0 | November 2023 |
| MySQL 5.5 | December 2018 |
| MySQL 5.6 | February 2021 |
| MySQL 5.7 | October 2023 |
| Node 16 | September 2023 |
| Node 21 | June 2024 |
| Node 18 | April 2025 |
| Node 20 | April 2026 |
| Elasticsearch 5.6 | March 2019 |
| Elasticsearch 6 | February 2022 |
| Elasticsearch 6 | January 2026 |
| Debian buster | June 2024 (apt repos moved to archive.debian.org) |
| Debian bullseye | August 2026 |


## Restoring for Emergency

If you need to rebuild these images for an emergency fix:

```bash
# Move image back temporarily
mv _deprecated/php73-cli ./

# Build
cd php73-cli && make all

# Move back when done
mv ../php73-cli ../_deprecated/
```
