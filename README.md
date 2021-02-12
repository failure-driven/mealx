<h1 align="center">MealX</h1>

<div align="center">

[![CircleCI](https://circleci.com/gh/failure-driven/mealx.svg?style=svg)](https://circleci.com/gh/failure-driven/mealx)

</div>

MealX will multiply your dining out!

# TL;DR

```
asdf install
npm install -g https://yarnpkg.com/downloads/1.22.5/yarn-v1.22.5.tar.gz

bundle exec rails db:create && db:migrate

make build

rails server
open http://localhost:3000
```

give a user admin priveledges

```
rails runner 'User.find_by(email: ARGV).update!(user_actions: { "admin": { "can_administer": true }})' m@m.m
```

# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
