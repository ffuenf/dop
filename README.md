Description
===========

This framework provides a common structure for projects and applications which may be developed locally and deployed remotely on a server.
It provides flexible components which can be mixed and matched to only contain the specific services needed.

This repository is intended as blueprint for a project based on the dop framework.
Ultimately this is the repository which holds all components of your project including:
* definition of base operating system (use [veewee](https://github.com/jedi4ever/veewee) or [packer](http://www.packer.io) to build base-boxes for virtualbox)
* vagrant configuration to spin up local development/testing VMs
* chef cookbooks which holds configuration of all system services (ensuring that local VMs have the exact same configuration of your production machine)
* all sensitive information like passwords using encrypted databags (the data_bag_key is the only item which NEVER EVER should be added to version control!)
* application code linked in as git submodules (this is where you will develop your application (e.g. magento) in the end)

Directory structure
---------
```
├── .git
├── .gitignore
├── .gitmodules
├── appname1/ # git submodule
│   ├── .git
│   ├── .gitignore
│   ├── deploy/
│   ├── public/ # document root
│   └── shared/ # shared resources
├── appname2/ # git submodule
│   ├── .git
│   ├── .gitignore
│   ├── deploy/
│   ├── public/ # document root
│   └── shared/ # shared resources
└── tools/
    │── baseboxes/
    │   ├── .git # submodule ffuenf/vagrant-boxes
    │   ├── packer/
    │   |   ├── debian-6.0.7-amd64/
    │   |   ├── debian-7.0.0-amd64/
    │   |   └── debian-7.1.0-amd64/
    │   └── veewee/
    │       ├── debian-6.0.7-amd64/
    │       ├── debian-7.0.0-amd64/
    │       └── debian-7.1.0-amd64/
    ├── chef/
    │   ├── .chef/
    │   ├── .site-cookbooks/
    │   ├── .data_bags/ # unencrypted data_bag source files fur use with knife-solo_data_bag
    │   │   ├── dop_base/ # base setup of dop framework
    │   │   │   ├── attributes/
    │   │   │   ├── files/
    │   │   │   ├── recipes/
    │   │   │   └── templates/
    │   │   ├── dop_main/ # wrapper cookbook for multi-application installations
    │   │   │   ├── attributes/
    │   │   │   ├── files/
    │   │   │   ├── recipes/
    │   │   │   └── templates/
    │   │   ├── appname1/
    │   │   │   ├── attributes/
    │   │   │   ├── files/
    │   │   │   ├── recipes/
    │   │   │   └── templates/
    │   │   └── appname2/
    │   │       ├── attributes/
    │   │       ├── files/
    │   │       ├── recipes/
    │   │       └── templates/
    │   ├── cookbooks/
    │   ├── data_bags/
    │   ├── nodes/
    │   ├── roles/
    │   └── data_bag_key # DO NOT EVER CHECK-IN THIS INTO VERSION CONTROL!
    └── vagrant/
        ├── .librarian/
        ├── boxes/
        |   ├── debian-6.0.7-amd64.box
        |   └── debian-7.0.0-amd64.box
        ├── Cheffile
        ├── Cheffile.lock # locked cookbook versions
        └── Vagrantfile
````

Usage
=====

To start a new dop project you may clone this repository and move on frome here.
Do not fork this project as it is not intended to be used this way!

To set the configurations to your preferences, you have to clone [dop_base](https://github.com/ffuenf/dop_base) into the tools/chef/.site-cookbooks/ directory and add an entry to your Cheffile (see comments). 
From there on you can adjust the dop_base cookbook. Before you provision your local VM or a remote machine you have to tell librarian to cache the site-cookbook to the cookbooks/ directory (use `librarian-chef install` or `librarian-chef update` in the tools/vagrant directory).
To include your application code you may add git submodules at the root of this repository (stay tuned for a complete magento example).

Requirements
============

Applications
---------

* [veewee](https://github.com/jedi4ever/veewee)
* [packer](http://www.packer.io)
* [vagrant](http://vagrantup.com)
* vagrant-vbguest plugin (`vagrant plugin install vagrant-vbguest`)
* [virtualbox](https://www.virtualbox.org/)
* [chef](http://www.opscode.com/chef/) (we do not use chef-server!)
* [git](http://git-scm.com/)


Platform
--------

The following platforms are supported and tested:

* OSX 10.8.2

License and Author
==================

- Author:: Achim Rosenhagen (<a.rosenhagen@ffuenf.de>)

- Copyright:: 2013, ffuenf

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.