#!/bin/bash

##############################################################################
# NAME: configure.sh
# AUTHOR: Tim Krupinski
# EMAIL: tdkrupinski@gmail.com
# 
# DESCRIPTION: This is just a local script I run to set up all of the ruby environment 
# variables after pulling new code from the repository.  It updates the database.yml,
# production.rb,
##############################################################################

sed -i 's/^# \(.*'\''therubyracer'\''.*\)/\1/' Gemfile

#bundle install

if [ -f config/database.yml ] 
then
    mv config/database.yml config/database_backup.yml.bak
fi

# Read in password so we aren't storing it in a script
retry=True
while [[ $retry = "True" ]]; do
    read -s -p "Enter DB Password: " dbpassword
    echo ""
    read -s -p "Re-enter Password: " dbpassword2
    echo ""
    
    if [[ $dbpassword != $dbpassword2 ]]; then 
        echo "Passwords do not match!"
    else
        echo "Updating database configurations..."
        unset retry 
    fi
done


cat > config/database.yml << 'eof'
development:
  adapter: postgresql
  encoding: unicode
  database: conciage_development
  pool: 5
  username: konciage
eof
echo "  password: $dbpassword" >> config/database.yml
cat >> config/database.yml << 'eof'
  schema_search_path: "conciage"
  host: 72.2.115.126 
  port: 5433
production:
  adapter: postgresql
  encoding: unicode
  database: conciage_stage
  pool: 5
  username: konciage
eof
echo "  password: $dbpassword" >> config/database.yml
cat >> config/database.yml << 'eof'
  schema_search_path: "conciage"
  host: 72.2.115.126 
  port: 5433
test:
  adapter: postgresql
  encoding: unicode
  database: conciage_stage
  pool: 5
  username: konciage
eof
echo "  password: $dbpassword" >> config/database.yml
cat >> config/database.yml << 'eof'
  schema_search_path: "conciage"
  host: 72.2.115.126 
  port: 5433
eof

echo "Almost Done!\n"

sed -i 's/^end//'  config/environments/production.rb
cat >> config/environments/production.rb << 'eof'
  config.action_mailer.default_url_options = { :host => "rubyweb.conciage.net:8000" }
  
  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new
  config.action_mailer.delivery_method = :sendmail    
  config.action_mailer.perform_deliveries = true   
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_options = {from: 'noreply@conciage.net'}
end
eof

exit 0
