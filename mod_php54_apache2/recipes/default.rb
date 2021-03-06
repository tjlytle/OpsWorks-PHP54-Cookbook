include_recipe 'apache2'

# add repository for PHP 5.4
apt_repository "php54" do
  uri "http://ppa.launchpad.net/ondrej/php5-oldstable/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "E5267A6C"
end
 
# update apt info
execute "apt-get update" do
  command "apt-get update"
  ignore_failure true
end
 
# update PHP to version 5.4 and add necessary packages
%w{php5-common php5-intl php-apc php5-mysqlnd php5-curl}.each do |pkg|
  package pkg do
    action :upgrade
  end
end

include_recipe 'apache2::mod_php5'
