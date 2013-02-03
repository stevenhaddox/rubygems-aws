#
# Cookbook Name:: rubygems
# Recipe:: database
#

secrets = data_bag_item("secrets", "rubygems")
rubygems_settings = secrets["application"][node["application"]["rails_env"]]
rails_postgresql_user     = rubygems_settings["rails_postgresql_user"]
rails_postgresql_password = rubygems_settings["rails_postgresql_password"]
rails_postgresql_db = rubygems_settings["rails_postgresql_db"]

# create a DB user
pg_user rails_postgresql_user do
  privileges superuser: false, createdb: false, login: true
  password rails_postgresql_password
end

# create a database
pg_database rails_postgresql_db do
  owner rails_postgresql_user
  encoding "utf8"
  template "template0"
  locale "en_US.UTF8"
end