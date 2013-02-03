# Rubygems AWS Infrastructure Configuration

Chef cookbooks and bootstrap scripts to configure and manage Rubygems.org AWS infrastructure

**Note: This repository requires Ruby 1.9.x.**

## Hacking

    $ bundle install
    $ librarian-chef install
    $ vagrant up
You will need to populate a chef databag for the application parameters, `chef/data_bags/secrets/rubygems.json`:

    {
      "id": "rubygems",
      "application": {
        "vagrant": {
          "rails_postgresql_host" : "33.33.33.12",
          "rails_postgresql_db": "gemcutter_vagrant",
          "rails_postgresql_user": "postgres",
          "rails_postgresql_password": "totally insecure",
          "s3_key": "",
          "s3_secret": "",
          "secret_token" : "",
          "bundler_token": "",
          "bundler_api_url" : "",
          "new_relic_license_key" : "",
          "new_relic_app_name" : ""
        }
      }
    }    
After the file is populated, run:

    $ cap chef

### Hacking on EC2

Add your user to the "users" databag (`chef/data_bags/users`).
  You can look at the other users for the schema.
  You can generate an encrypted password using `mkpasswd -m sha-512`.

Boot EC2 instances and get hostnames

    $ export RUBYGEMS_EC2_APP=ec2-*.amazonaws.com
    $ export RUBYGEMS_EC2_LB1=ec2-*.amazonaws.com
    $ export RUBYGEMS_EC2_DB1=ec2-*.amazonaws.com
    $ cap ec2 bootstrap
    $ cap ec2 chef


## AMI's

All AMI's use instance root storage and are 64 bit.

* "ap-northeast-1": "ami-70a91271"
* "ap-southeast-1": "ami-15226047"
* "eu-west-1": "ami-3a0f034e"
* "sa-east-1": "ami-6beb3376"
* "us-east-1": "ami-d726abbe"
* "us-west-1": "ami-827252c7"
* "ap-southeast-2": "ami-7f7ee945"
* "us-west-2": "ami-ca2ca4fa"


## Knife bootstrap template

There's a bootstrap template for knife bootstrap or knife ec2 (which
leverages bootstrap). It is WIP.

Use it with `-d chef-full-solo` passed to `knife bootstrap` or
`knife ec2 server create`.

## Knife configuration

If you wish to modify the knife configuration, e.g. AWS options for
`knife ec2` or Chef Server URL/keys, put them in
`.chef/knife.local.rb` and it will be loaded automatically.

    # Chef Server example
    node_name                "your-user-name"
    client_key               "/Users/your-user-name/.chef/your-usern-name.pem"
    validation_client_name   "your-organization-name-validator"
    validation_key           "/Users/jtimberman/.chef/your-organization-name-validator.pem"
    chef_server_url          "https://api.opscode.com/organizations/your-organization-name"
    # EC2 example (add the env variables)
    knife[:aws_access_key_id]      = ENV['AWS_ACCESS_KEY_ID']
    knife[:aws_secret_access_key]  = ENV['AWS_SECRET_ACCESS_KEY']

## Private keys

Any private keys you see in this repo are "trash keys" that are not used in production, they are for *testing only*.


## License

`rubygems-aws` uses the MIT license. Please check the [LICENSE.md](LICENSE.md) file for more details.
