# Deprecated Docker Images

These images are **End of Life (EOL)** and no longer actively maintained.

## Why are these here?

Images in this directory have been deprecated because:
- The underlying software has reached End of Life
- Security updates are no longer provided by upstream maintainers
- Modern alternatives exist

## Can I still use these images?

**Yes.** The images remain available on Docker Hub for existing projects:
- `nfqlt/php71-*`
- `nfqlt/php72-*`
- `nfqlt/php73-*`
- `nfqlt/mysql55`
- `nfqlt/mysql56`
- `nfqlt/elasticsearch56`
- `nfqlt/linker18ce`

However, they will **not receive updates**. We strongly recommend migrating to supported versions.

## Migration Guide

| Deprecated | Migrate To | Notes |
|------------|------------|-------|
| PHP 7.1 | PHP 8.1+ | [PHP Migration Guide](https://www.php.net/manual/en/migration81.php) |
| PHP 7.2 | PHP 8.1+ | [PHP Migration Guide](https://www.php.net/manual/en/migration81.php) |
| PHP 7.3 | PHP 8.1+ | [PHP Migration Guide](https://www.php.net/manual/en/migration81.php) |
| MySQL 5.5 | MySQL 8.0+ | [MySQL Upgrade Guide](https://dev.mysql.com/doc/refman/8.0/en/upgrading.html) |
| MySQL 5.6 | MySQL 8.0+ | [MySQL Upgrade Guide](https://dev.mysql.com/doc/refman/8.0/en/upgrading.html) |
| Elasticsearch 5.6 | Elasticsearch 8.x | [ES Upgrade Guide](https://www.elastic.co/guide/en/elasticsearch/reference/current/setup-upgrade.html) |
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
| MySQL 5.5 | December 2018 |
| MySQL 5.6 | February 2021 |
| Elasticsearch 5.6 | March 2019 |

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
