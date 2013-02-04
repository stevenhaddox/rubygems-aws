#
# Cookbook Name:: rubygems
# Recipe:: default
#

include_recipe "rubygems::users"

app = node['application']
app_secrets = data_bag_item("secrets", "rubygems")
node.run_state[:app] = app.to_hash
node.run_state[:app_secrets] = app_secrets.to_hash
