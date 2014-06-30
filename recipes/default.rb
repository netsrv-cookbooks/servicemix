#
# Copyright (C) 2014 NetSrv Consulting Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

remote_file "#{Chef::Config[:file_cache_path]}/servicemix.zip" do
  action :create_if_missing
  source node[:smix][:dist_url]
end

directory node[:smix][:install_dir] do
  action :create
end

package 'unzip' do
  action :install
end

smix_dir = ::File.join(node[:smix][:install_dir], "apache-servicemix-#{node[:smix][:version]}")

execute "unzip #{Chef::Config[:file_cache_path]}/servicemix.zip -d #{node[:smix][:install_dir]}" do
  not_if { ::File.directory?(smix_dir) }
end

link ::File.join(node[:smix][:install_dir], 'current') do
  to smix_dir
end

user node[:smix][:user] do
  action :create
  shell '/sbin/nologin'
  home '/home/smix'
end

execute "chown -R #{node[:smix][:user]}.#{node[:smix][:user]} #{smix_dir}"

template '/etc/init.d/servicemix' do
  source 'sysv.init.erb'
  mode 0755
  variables(
    :home => smix_dir,
    :user => node[:smix][:user]
  )
end

execute '/etc/init.d/servicemix start'
