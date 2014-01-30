# Conciage

- Ruby 2.0
- Rails 4
- pg

## Setup

### Clone the project

    git@github.com:bemall/conciage.git

### Fetch/Checkout to 'develop'/Create feature branch

    git fetch
    git checkout --track -b develop origin/develop
    git checkout -b your_feature

### Install gems

    bundle

### Setup development secrets

In your bash_rc/bash_profile/zhrc setup an env variable for devise secret:

    export DEVISE_SECRET_KEY='secret_key'

Also we need a secret_key for the app, you can setup using an env variable:

    export SECRET_TOKEN='secret_key'

Or using a file config/secret_token.yml:

    development:
      token: "secret_token"
    test:
      toke: "secret_token"

### Setup config/database.yml

    cp config/database.yml.example config/database.yml

Setup your username/password and DO NOT remove this line:

    schema_search_path: "conciage"

We use schemas for tables, if you change this line the entire database setup will fail.

    ./recreate_database.sh

### Run the project

    rackup config.ru -p 3000

Access in your browser:

    http://localhost:3000

![](http://screencloud.net/img/screenshots/5227736aea6ddfea07118d69a02925f3.png)

### Tests

You can use guard to watch the tests:

    guard

Or run it manually:

    rspec

Once you have configured the database with ./recreate_database.sh tests should work out of the box.

### Image size guidelines

For image sizing we generally need a large size to be uploaded so that the image can be re-sized appropriately to fit all devices.
We also need a general maximum upload size of say 6 MB such that at any one time we never have an image that is larger than 6MB.
We will need a good image resizing function that will re size and optimize for web rendering.
The maximum file size to be uploaded for any image is 5MB
To accommodate all devices, the recommended upload size is 500 x 500 px,
In user activity feed, comments and other areas where the profile picture appears, it will be re sized to 48 x 48 px or 24 x 24 px.
Thumbnails at 205 by 205
Container at 578 by 578 and max size at 510 by 510

