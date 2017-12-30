module Sekisho
  class Base
    include Sekisho::Log

    attr_reader :logger
    attr_accessor :options

    def initialize(option)
      yaml = YAML.load_file('sekisho_config.yml')
      @repositories = yaml['repositories']
      @logger = Logger.new(STDOUT)
      @options = option
    end

    def dry_run?
      dry_run ||= options[:dry_run]
    end
  end
end
