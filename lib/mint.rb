#!/usr/bin/env ruby

MINT_ROOT = File.expand_path('..', File.dirname(__FILE__))
Dir.chdir(MINT_ROOT)
$LOAD_PATH << MINT_ROOT

$KCODE = 'u'

require 'ostruct'
require 'yaml'
require 'optparse'
require 'pathname'

require 'rubygems'
require 'net/irc'

require 'lib/utils'
require 'lib/plugin'

module Mint
  DEFAULT_CONFIG_FILE_PATH = 'configs/environment.yaml'

  class Core < Net::IRC::Client
    def initialize
      @config  = load_configs
      @general = @config.general

      super(@general['host'], @general['port'], {
        :nick => @general['nick'],
        :user => @general['user'],
        :real => @general['real'],
        :pass => @general['pass']
      })
    end

    def load_configs
      config_file = DEFAULT_CONFIG_FILE_PATH

      ARGV.options do |o|
        o.on('-c', "--config-file CONFIG_FILE", " (default: #{config_file})") { |v| config_file = v }
        o.parse!
      end

      config = OpenStruct.new(File.open(config_file) { |f| YAML.load(f) })
    end

    def connect
      TCPSocket.open(@general['host'], @general['port'])
    end

    def boot 
      begin
        @socket = connect
        @socket.gets

        post(NICK, @opts.nick)
        post(USER, @opts.user, '0', '*', @opts.real)

        run_plugins
      rescue IOError => e
        @log.error 'IOError' + e.to_s
      ensure
        finish
      end
    end

    def run_plugins
      threads = []
      @plugins = load_plugins(@general['plugin_dir'], @config.plugins)
      @plugins.each do |plugin|
        threads.push(Thread.fork(plugin) { |p| p.run })
      end

      threads.each { |t| t.join }
    end

    def load_plugins(plugin_dir, plugin_configs)
      class_tables = {}

      Pathname.glob("#{plugin_dir}/*.rb") do |file|
        plugin = {}
        m = Module.new
        m.module_eval(file.read, file)
        m.constants.each do |name|

          const = m.const_get(name)
          if const.is_a? Class 
            plugin[name] = {
              :class   => const,
              :file    => file,
              :configs => plugin_configs[name]
            }
          end
        end
        class_tables.update(plugin)
      end

      plugins = instantiation(class_tables)
    end

    def instantiation(class_tables)
      plugins = []
      class_tables.each do |name, plugin|
        plugins << plugin[:class].new(plugin[:configs], @socket)
      end

      plugins
    end
  end
end

Mint::Core.new.boot