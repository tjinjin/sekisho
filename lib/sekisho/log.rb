module Sekisho
  module Log

    def log(level, message)
      message = "#{message}"
      message << '(dry-run)' if dry_run?
      logger.log(convert(level), colorize(level, message))
    end

    def convert(level)
      case level
      when :debug
        Logger::DEBUG
      when :info
        Logger::INFO
      when :warn
        Logger::WARN
      when :error
        Logger::ERROR
      when :fatal
        Logger::FATAL
      end
    end

    def colorize(level, message)
      case level
      when :debug
        message.cyan
      when :info
        message.green
      when :warn
        message.yellow
      when :error
        message.magenta
      when :fatal
        message.red
      end
    end
  end
end
