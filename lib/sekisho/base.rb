module Sekisho
  class Base
    include Sekisho::Log

    attr_reader :logger
    attr_accessor :options

    def initialize(option)
      @logger = Logger.new(STDOUT)
      @options = option

      yaml = load_config(option[:config])
      @repositories = yaml['repositories']
      api_key = yaml['api_key'] if yaml.has_key?('api_key')

      @github = Sekisho::Github::Milestone.new(api_key)
    end

    def load_config(file)
      log(:fatal, "config file don't find. file: #{file}") unless File.exists?(file)
      YAML.load_file(file)
    end

    def dry_run?
      dry_run ||= options[:dry_run]
    end
  end
end
