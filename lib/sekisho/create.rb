module Sekisho
  class Create < Base
    attr_reader :github

    def initialize(options)
      super(options)
    end

    def get_next_week(day, base_wday)
      if day.wday < base_wday
        day.next_day(base_wday - day.wday)
      elsif day.wday == base_wday
        day
      else
        day.next_day(7 - (day.wday - base_wday))
      end
    end

    def create_milestones_list(base_day, cycle, base_wday, count)
      tmp_list = []
      (0..count).each do |num|
        tmp_list << get_next_week(base_day.next_day(num * cycle * 7), base_wday)
      end
      return tmp_list
    end

    def run
      base_wday = options[:week]
      count = options[:count] - 1
      base_day = Date.strptime(options[:from], '%Y-%m-%d')
      dry_run = options[:dry_run]
      cycle = options[:interval]

      target_milestones = create_milestones_list(base_day, cycle, base_wday, count)

      @repositories.each do |repo|
        exist_milestones = []
        %w(open closed).each do |state|
          github.list_milestones(repo, state).each do |mile|
            begin
              exist_milestones << Date.strptime(mile[:title])
            rescue
              next
            end
          end
        end

        log(:warn, "No Changed: repo: [#{repo}]") if (target_milestones - exist_milestones).blank?
        (target_milestones - exist_milestones).each do |mile|
          msg = "repo: [#{repo}] -> #{mile.strftime('%Y-%m-%d')}"
          log(:debug, msg)
          github.create_milestone(repo, mile) unless dry_run?
          log(:info, "Created: #{msg}.") unless dry_run?
        end
      end
    end
  end
end
