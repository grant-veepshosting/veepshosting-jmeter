# Puppet JMeter

Forked from
- "source": "https://github.com/dduvnjak/puppet-jmeter",
- "project_page": "https://github.com/dduvnjak/puppet-jmeter",
- "issues_url": "https://github.com/dduvnjak/puppet-jmeter/issues",

This class installs JMeter from apache.org. If you set the `enable_server` parameter, a service will be configured and enabled, and JMeter will be started in server mode listening on the default port.

`jmeter` can optionally install the plugin manager, which allows you to install additional plugins.

The init script is based on the one available at https://gist.github.com/2830209.

Note: If you are using 3.x, you will need to have at least Java 8 installed. If the version is not set, the module will try to choose an appropriate version for you.

Requirements
------------

This module requires Puppet 4.7.1 or higher, as well as the stdlib and puppet-archive modules. On systems that use systemd,
(Ubuntu >= 16.04, CentOS >= 7), [camptocamp/systemd](https://forge.puppet.com/camptocamp/systemd) is a soft dependency.

Basic usage
-----------

Install JMeter:

    class { 'jmeter': }

Install JMeter v3.x, plugin manager ([JMeterPlugins](http://jmeter-plugins.org/), and enable the most recent version of plugins 'foo' and 'bar'.

    class { 'jmeter':
      jmeter_version         => '3.3',
      plugin_manager_install => true,
      plugins                => {
        'foo' => { ensure => present },
        'bar' => { ensure => present },
      }
    }

Install JMeter server using the default host-only IP address 0.0.0.0:

    class { 'jmeter':
      enable_server => true,
    }

Install JMeter server using a custom host-only IP address:

    class { 'jmeter':
      enable_server => true,
      bind_ip       => '10.33.33.42',
    }

Install a plugin (if not using the `jmeter::plugins` example above):

    jmeter_plugin { 'foo':
      ensure => present,
    }
