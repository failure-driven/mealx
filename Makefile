PROJECT := mealx

default: usage
usage:
	bin/makefile/usage

rubocop_fix_all:
	bundle exec rubocop -a .

prettier_ruby:
	bin/makefile/prettier-ruby

.PHONY: build
build:
	bin/full-build

.PHONY: pg_init
pg_init:
	initdb tmp/postgres -E utf8

.PHONY: pg_start
pg_start:
	pg_ctl -D tmp/postgres -l tmp/postgres/logfile start

.PHONY: pg_stop
pg_stop:
	pg_ctl -D tmp/postgres stop -s -m fast

d.PHONY: deploy
deploy:
	RAILS_MASTER_KEY=`cat config/master.key` \
		HEROKU_APP_NAME=stg-mealx							 \
		bin/heroku-create
