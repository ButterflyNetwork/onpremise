# Sentry On-Premise

Official bootstrap for running your own [Sentry](https://sentry.io/) with [Docker](https://www.docker.com/).

## Sentry On-Premise with Aptible

To run as an app on Aptible:

1. Provision a PostgreSQL database, either from the Aptible Dashboard or the Aptible CLI.

1. Provision a Redis database, either from the Aptible Dashboard or Aptible CLI.

1. Provision an Aptible app, either from the Aptible Dashboard or the Aptible CLI.

1. Configure the following (required and optional) environment variables for your Sentry app:

| Variable | Description | Required? | Default Value |
| -------- | ----------- | --------- | ------------- |
| `ADMIN_PASSWORD` | Admin password | Yes | - |
| `DATABASE_URL` | PostgreSQL database URL | Yes | - |
| `SENTRY_REDIS_HOST` | Redis host | Yes | - |
| `SENTRY_REDIS_PASSWORD` | Redis password | Yes | - |
| `SENTRY_REDIS_PORT` | Redis port | Yes | - |
| `SENTRY_URL_PREFIX` | Base URL for server | Yes | - |
| `ADMIN_USERNAME` | Admin username | No | Aptible |
| `AWS_ACCESS_KEY_ID` | AWS Access Key for S3 filestore | No | - |
| `AWS_SECRET_ACCESS_KEY` | AWS Secret Access Key for S3 filestore | No | - |
| `AWS_STORAGE_BUCKET_NAME` | AWS S3 bucket for S3 filestore | No | - |
| `AWS_S3_ENCRYPTION` | Use AES-256 encryption for S3 filetore | No | `True` |
| `GITHUB_APP_ID` | GitHub OAuth application ID (for GitHub integration) | No | - |
| `GITHUB_API_SECRET` | GitHub API secret | No | - |
| `MAILGUN_SERVER_NAME` | Your email domain (eg yourcompany.com) | No | - |
| `MAILGUN_ACCESS_KEY` | Mailgun API Key | No | - |
| `SENTRY_EMAIL_HOST` | SMTP hostname | No | - |
| `SENTRY_EMAIL_PASSWORD` | SMTP password | No | - |
| `SENTRY_EMAIL_PORT` | SMTP port | No | 25 |
| `SENTRY_EMAIL_USER` | SMTP user | No | - |
| `SENTRY_EMAIL_USE_TLS` | Use TLS for email? | No | `False` |
| `SENTRY_KEY` | Sentry key | No | (random) |
| `SENTRY_SECRET_KEY` | Secret key for [DSN clients](http://raven.readthedocs.org/en/latest/config/#the-sentry-dsn) sending events | No | (random) |
| `SSLIFY_DISABLE` | Disable forced HTTPS redirection? | No | `False` |
| `TEAM_NAME` | Team name | No | `Aptible` |


## Requirements

 * Docker 1.10.0+
 * Compose 1.6.0+ _(optional)_

## Up and Running

Assuming you've just cloned this repository, the following steps
will get you up and running in no time!

There may need to be modifications to the included `docker-compose.yml` file to accommodate your needs or your environment. These instructions are a guideline for what you should generally do.

1. `mkdir -p data/{sentry,postgres}` - Make our local database and sentry config directories.
    This directory is bind-mounted with postgres so you don't lose state!
2. `docker-compose run --rm web config generate-secret-key` - Generate a secret key.
    Add it to `docker-compose.yml` in `base` as `SENTRY_SECRET_KEY`.
3. `docker-compose run --rm web upgrade` - Build the database.
    Use the interactive prompts to create a user account.
4. `docker-compose up -d` - Lift all services (detached/background mode).
5. Access your instance at `localhost:9000`!

Note that as long as you have your database bind-mounted, you should
be fine stopping and removing the containers without worry.

## Securing Sentry with SSL/TLS

If you'd like to protect your Sentry install with SSL/TLS, there are
fantastic SSL/TLS proxies like [HAProxy](http://www.haproxy.org/)
and [Nginx](http://nginx.org/).

## Resources

 * [Documentation](https://docs.sentry.io/server/installation/docker/)
 * [Bug Tracker](https://github.com/getsentry/onpremise)
 * [Forums](https://forum.sentry.io/c/on-premise)
 * [IRC](irc://chat.freenode.net/sentry) (chat.freenode.net, #sentry)
