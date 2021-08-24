# jmeter
#
# @summary Main class for jmeter module
#
# @example Declaring the class
#   class { 'jmeter': }
#
# @example Configuring to install plugins
#   class { 'jmeter':
#     jmeter_version         => '3.2',
#     plugin_manager_install => true,
#     plugins                => {
#       'foo' => { ensure => present },
#       'bar' => { ensure => present },
#     }
#    }
#
# @example Enabling server (and jmeter service)
#   class { 'jmeter':
#     enable_server => true,
#     bind_ip       => 10.3.3.6,
#   }
#
# @param bind_ip IP address to bind to. Defaults to '0.0.0.0' (all interfaces). Replaces `jmeter::server::server_ip`
# @param bind_port Port for server to use.
# @param cmdrunner_version Version of cmdrunner to use. This should generally be left as default.
# @param download_url Download URL for Jmeter.
# @param enable_server Whether to enable the server. Replaces the previous method of declaring `class { 'jmeter::server': }`
# @param java_version Java version to install.
# @param jdk_pkg Name for the jdk package.
# @param jmeter_version Sets version of jmeter to install. Note that 3.x requires Java v8.
# @param manage_java Whether to ensure that java is installed.
# @param jmeter_user User to run jmeter under
# @param jmeter_group Group to run jmeter under
# @param plugin_manager_install Whether or not to install the plugin manager.
# @param plugin_manager_url Download URL for both the plugin manager and command runner. Note, this redirects, and part of the path has the
#  package name appended and is built dynamically in jmeter::install.
# @param plugin_manager_version Sets the version of the plugin manager to install.
# @param plugins An optional hash of plugins to install via the plugin manager.
class jmeter (
  Boolean $enable_server              = false,
  Stdlib::Compat::Ip_address $bind_ip = '0.0.0.0',
  Integer[0,65535] $bind_port         = 1099,
  String $jmeter_version              = $jmeter::params::jmeter_version,
  String $jmeter_user                 = 'jmeter',
  String $jmeter_group                = 'jmeter',
  Boolean $plugin_manager_install     = false,
  String $plugin_manager_version      = '1.6',
  String $cmdrunner_version           = '2.2',
  Optional[Hash] $plugins             = undef,
  Stdlib::HTTPUrl $download_url       = 'http://archive.apache.org/dist/jmeter/binaries/',
  Stdlib::HTTPUrl $plugin_manager_url = 'http://search.maven.org/remotecontent?filepath=kg/apc/',
  String $java_version                = $jmeter::params::java_version,
  Boolean $manage_java                = true,
  String $jdk_pkg                     = $jmeter::params::jdk_pkg
) inherits jmeter::params {

  Exec { path => '/bin:/usr/bin:/usr/sbin' }

  contain jmeter::install

  if $enable_server {
    contain jmeter::server
    contain jmeter::service

    Class['jmeter::install']
    -> Class['jmeter::server']
    ~> Class['jmeter::service']
  }

}
