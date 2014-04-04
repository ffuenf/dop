Description
===========

This framework provides a common structure for projects and applications which may be developed locally and deployed remotely on a server.
It provides flexible components which can be mixed and matched to only contain the specific services needed.

This repository is intended as blueprint for a project based on the dop framework.
Ultimately this is the repository which holds all components of your project including:
* vagrant configuration to spin up local development VMs
* chef cookbooks which holds configuration of all system services (ensuring that local VMs have the exact same configuration of your production machine)
* all sensitive information like passwords using encrypted databags (the data_bag_key is the only item which NEVER EVER should be added to version control!)
* application code linked in as git submodules (this is where you will develop your application (e.g. magento, wordpress) in the end)

Directory structure
---------
```
├── .git
├── .gitignore
├── .gitmodules
├── appname1/ # git submodule
│   ├── .git
│   ├── .gitignore
│   ├── public/ # document root (exposed to public)
│   ├── shared/ # shared resources
│   └── sql/ # sql dumps
├── appname2/ # git submodule
│   ├── .git
│   ├── .gitignore
│   ├── public/ # document root (exposed to public)
│   ├── shared/ # shared resources
│   └── sql/ # sql dumps
├── tools/
│   ├── chef/
│   │   ├── .chef/
│   │   │   ├── knife.rb
│   │   │   └── data_bag_key # DO NOT EVER CHECK-IN THIS INTO VERSION CONTROL!
│   │   ├── .data_bags/ # unencrypted data_bag source files fur use with knife-solo_data_bag
│   │   ├── .site-cookbooks/
│   │   │   ├── appname1/
│   │   │   │   ├── attributes/
│   │   │   │   ├── files/
│   │   │   │   ├── recipes/
│   │   │   │   ├── templates/
│   │   │   │   ├── CHANGELOG.md
│   │   │   │   ├── metadata.rb
│   │   │   │   └── README.md
│   │   │   └── appname2/
│   │   │       ├── attributes/
│   │   │       ├── files/
│   │   │       ├── recipes/
│   │   │       ├── templates/
│   │   │       ├── CHANGELOG.md
│   │   │       ├── metadata.rb
│   │   │       └── README.md
│   │   ├── data_bags/
│   │   ├── environments/
│   │   ├── nodes/
│   │   ├── roles/
│   │   │   ├── local.rb # configuration for local machine
│   │   │   └── remote.rb # configuration for remote machine
│   │   └── create_data_bags.sh # shortcut script to generate all data_bags
│   └── vagrant/
│       ├── .librarian/
│       │   └── chef
│       │       └── config
│       ├── boxes/
│       │   └── .gitignore # ignore packaged boxes
│       ├── Cheffile
│       ├── Cheffile.lock # locked cookbook versions
│       └── Vagrantfile
├──.ruby-gemset # rvm config
├──.ruby-version # rvm config
├── Gemfile # ruby dependencies 
└── Gemfile.lock # locked ruby dependencies

````

Usage
=====

To start a new dop project you may clone this repository and move on frome here.
Do not fork this project as it is not intended to be used this way!

To set the configurations to your preferences, edit the role files at tools/chef/roles accordingly. 
To include your application code you may add git submodules at the root of this repository.

Requirements
============

Applications
---------

* [vagrant](http://vagrantup.com)
* [virtualbox](https://www.virtualbox.org/)
* [chef](http://www.opscode.com/chef/) (we do not use chef-server!)
* [git](http://git-scm.com/)


Platform
--------

The following platforms are supported and tested:

* OSX 10.8.2
* OSX 10.9.1

License and Author
==================

- Author:: Achim Rosenhagen (<a.rosenhagen@ffuenf.de>)

- Copyright:: 2013-2014, ffuenf

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
