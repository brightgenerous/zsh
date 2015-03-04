#
# Cookbook Name:: chsh
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

include_recipe 'zsh'

(node['zsh']['users'] || []).each do |user|
  bash "Set #{user}'s shell to zsh" do
    code <<-EOT
      chsh -s /bin/zsh #{user}
    EOT
    not_if <<-EOT
      test "/bin/zsh" = "$(grep #{user} /etc/passwd | cut -d: -f7)"
    EOT
  end
end
