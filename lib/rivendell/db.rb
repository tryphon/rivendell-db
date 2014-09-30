require "rivendell/db/version"

require 'dm-core'
require 'dm-mysql-adapter'
require 'dm-serializer'
require 'dm-types'
require 'dm-validations'

module Rivendell
  # DataMapper::Logger.new(STDOUT, :debug)
  # DataMapper::Model.raise_on_save_failure = true

  module DB

    def self.mysql_conf
      @mysql_conf ||= IniFile.load("/etc/rd.conf")['mySQL'] if File.exists?("/etc/rc.conf")
    end

    def self.default_url
      if mysql_conf
        # If we can, pull the config from Rivendell's own configuration.
        "mysql://#{mysql_conf['Loginname']}:#{mysql_conf['Password']}@#{mysql_conf['Hostname']}/#{mysql_conf['Database']}?reconnect=true"
      else
        'mysql://rduser:letmein@localhost/Rivendell?reconnect=true'
      end
    end

    def self.establish_connection(url = default_url)
      # Rivendell's default for most setups
      DataMapper.setup :default, url

      DataMapper.repository(:default).adapter.field_naming_convention = 
        DataMapper::NamingConventions::Field::Underscored 

      true
    end
  end

end

# require 'rivendell/log_item'
# require 'rivendell/log'
require 'rivendell/db/cut'
require 'rivendell/db/cart'
require 'rivendell/db/dropbox'
require 'rivendell/db/group'
# require 'rivendell/task'
# require 'rivendell/tools'

DataMapper.finalize
