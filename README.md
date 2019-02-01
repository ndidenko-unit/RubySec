# Rubysec
This Rails-based application parses the data from https://rubysec.com/advisories every 10 minutes, saves it in a database, and notifies the registered users once new information has been added. 

## Installation and usage

Install and start Redis server.

```
redis-server
```

Clone repository and run following commands:
```
cd rubysec
bundle install
rake db:migrate
rails s
```

Start Sidekiq in new terminal window.
```
cd rubysec
bundle exec sidekiq
```

You can try app here: http://0.0.0.0:3000/

What I used:
```
Nokogiri
Sidekiq
Device
Action Mailer
Active Jobs
Bootstrap
```
