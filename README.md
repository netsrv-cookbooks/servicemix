# servicemix-cookbook

Installs and configures Apache ServiceMix.

## Requirements
Java must be installed.  Although this cookbook does not install it for you, Berkshelf has been configured with the
[java cookbook](https://github.com/socrata-cookbooks/java) which should make adding it to your node's run list easier.

## Supported Platforms

This cookbook has been tested on:

* Ubuntu 14.04 Trusty Tahr
* Centos 6.5

## Attributes

* `[:smix][:dist_url]` - the distribution URL
  * Default: *http://www.mirrorservice.org/sites/ftp.apache.org/servicemix/servicemix-5/5.1.0/apache-servicemix-5.1.0.zip*
* `[:smix][:install_dir]`
  * Default: */usr/local/smix*
* `[:smix][:version]`
  * Default: *5.1.0*
* `[:smix][:user]`
  * Default: smix
  * Local account created if not present and configured with /sbin/nologin shell

## Usage

### servicemix::default
Downloads the zipball from a configurable URL, and extracts it to /usr/local/smix/apache-servicemix-x.x.x by default.

A symlink at /usr/local/smix/current is created referencing it, easing upgrades.  However as no mechanism
currently exists for moving over installed jars and bundles, care should be taken.

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Colin Woodcock (cwoodcock@netsrv-consulting.com)
    
Copyright (C) 2014 NetSrv Consulting Ltd.
    
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
    
http://www.apache.org/licenses/LICENSE-2.0
    
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
