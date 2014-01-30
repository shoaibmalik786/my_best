#!/bin/bash

rake db:drop
rake db:create

rake db:structure:load
rake db:migrate
rake db:seed

RAILS_ENV=test rake db:structure:load
RAILS_ENV=test rake db:migrate
RAILS_ENV=test rake db:seed
