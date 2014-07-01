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

require 'spec_helper'

describe 'servicemix::default' do

  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  context 'Installation' do

    it 'download the servicemix distribution' do
      expect(chef_run).to create_remote_file_if_missing("#{Chef::Config[:file_cache_path]}/servicemix.zip")
    end

    it 'extract the servicemix distribution to a configurable location' do
      expect(chef_run).to install_package('unzip')
      expect(chef_run).to create_directory('/usr/local/smix')
      expect(chef_run).to run_execute('unzip /var/chef/cache/servicemix.zip -d /usr/local/smix')
    end

    it 'creates a link to the extracted distribution' do
      expect(chef_run).to create_link('/usr/local/smix/current')
    end

  end

  context 'Service setup' do
    it 'creates a user for the service' do
      expect(chef_run).to create_user('smix').with(shell: '/sbin/nologin')
      expect(chef_run).to run_execute('chown -R smix.smix /usr/local/smix/apache-servicemix-5.1.0')
    end

    it 'daemonises servicemix' do
      expect(chef_run).to create_template('/etc/init.d/servicemix')
      expect(chef_run).to run_execute('/etc/init.d/servicemix start')
    end

  end

end
