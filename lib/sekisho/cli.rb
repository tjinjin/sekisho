require 'sekisho'
require 'yaml'
require 'date'
require 'thor'
require 'logger'

module Sekisho
  class CLI < Thor

    desc 'create milestone', 'create milestone.'
    option :week, aliases: 'w', type: :numeric, required: true, desc: 'day of week. [0 => Sun, 1=> Mon, ..., 7 => Sun]'
    option :count, aliases: 'c', type: :numeric, default: 4, desc: 'number of milestone to create'
    option :from, aliases: 'f', default: Date.today.strftime("%Y-%m-%d"), desc: 'from when to create'
    option :interval, aliases: 'i', type: :numeric, default: 1, desc: 'milestone cycle. once a week -> 1, twice a week -> 2, and so on'
    option :dry_run, aliases: 'n', type: :boolean, default: false, desc: 'dry-run option'

    def create
      Sekisho::Create.new(options).run
    end
  end
end
