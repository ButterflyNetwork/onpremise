#!/bin/bash
set -eu



# STEP 1. Create Resources

# create postgres
aptible db:create --type=postgresql --environment=$APTIBLE_ENV $APP_NAME-pg
create redis
aptible db:create --type=redis --environment=$APTIBLE_ENV $APP_NAME-redis
# create App
aptible apps:create --environment=$APTIBLE_ENV $APP_NAME



# STEP 2. Add configuration variables

# Secret key for [DSN clients](http://raven.readthedocs.org/en/latest/config/#the-sentry-dsn) sending events
aptible config:set --app=$APP_NAME SENTRY_SECRET_KEY=$SENTRY_SECRET_KEY
# postgres url (created in step 1)
aptible config:set --app=$APP_NAME SENTRY_DATABASE_URL=$SENTRY_DATABASE_URL
# redis url (created in step one)
aptible config:set --app=$APP_NAME SENTRY_REDIS_URL=$SENTRY_REDIS_URL
# email configuration
aptible config:set --app=$APP_NAME SENTRY_EMAIL_HOST=$SENTRY_EMAIL_HOST
aptible config:set --app=$APP_NAME SENTRY_EMAIL_PASSWORD=$SENTRY_EMAIL_PASSWORD
aptible config:set --app=$APP_NAME SENTRY_EMAIL_PORT=$SENTRY_EMAIL_PORT
aptible config:set --app=$APP_NAME SENTRY_EMAIL_USER=$SENTRY_EMAIL_USER
aptible config:set --app=$APP_NAME SENTRY_EMAIL_USE_TLS=$SENTRY_EMAIL_USE_TLS
# email sender address
aptible config:set --app=$APP_NAME SENTRY_SERVER_EMAIL=$SENTRY_SERVER_EMAIL
# Admin Password
aptible config:set --app=$APP_NAME ADMIN_PASSWORD=$ADMIN_PASSWORD
# Admin Username
aptible config:set --app=$APP_NAME ADMIN_USERNAME=$ADMIN_USERNAME
# Team name
aptible config:set --app=$APP_NAME TEAM_NAME=$TEAM_NAME
# Instruct Sentry that this install intends to be run by a single organization
# and thus various UI optimizations should be enabled.
aptible config:set --app=$APP_NAME SENTRY_SINGLE_ORGANIZATION=$SENTRY_SINGLE_ORGANIZATION



# STEP 3. Deploy

git remote rm aptible
git remote add aptible git@beta.aptible.com:$APTIBLE_ENV/$APP_NAME.git
git push aptible master
