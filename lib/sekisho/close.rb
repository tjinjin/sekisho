module Sekisho
  class Close < Base
    attr_reader :github

    def initialize(options)
      @slack = Sekisho::Notify.new if options[:notify]
      super(options)
    end

    def find_milestone_number(list, milestone)
      list.each do |lst|
        return lst[:number] if lst[:title] == milestone.strftime(format = '%Y-%m-%d')
      end
    end

    def run
      dry_run = options[:dry_run]
      base_day = options[:to]

      @repositories.each do |repo|
        open_milestones = []
        milestones_data = []
        github.list_milestones(repo, 'open').each do |mile|
          begin
            open_milestones << Date.strptime(mile[:title])
            milestones_data << mile
          rescue
            next
          end
        end

        if open_milestones.blank?
          log(:info, "Nothing target milestones: [#{repo}] base_day: [#{base_day}]")
          next
        end

        target_milestones = []
        open_milestones.sort!
        open_milestones.each do |mile|
          if mile < Date.strptime(base_day)
            target_milestones << mile
          else
            break
          end
        end

        if target_milestones.blank?
          log(:info, "Nothing target milestones: [#{repo}] base_day: [#{base_day}]")
          next
        end

        target_milestones.each do |mile|
          log(:debug, "Target milestone: [#{repo}] milestone: [#{mile.strftime('%Y-%m-%d')}]")

          milestone_number = find_milestone_number(milestones_data, mile)
          if github.open_issues?(repo, milestone_number)
            github.close_milestone(repo, milestone_number) unless dry_run?
            log(:info, "Closed milestone: [#{repo}] milestone: [#{mile.strftime('%Y-%m-%d')}]")
          else
            log(:warn, "Not closed: open issues associated. repo: [#{repo}] milestone: [#{mile.strftime('%Y-%m-%d')}]")
            @slack.post({repo:repo, milestone:mile, milestone_number:milestone_number, mode:"close"}) unless @slack.nil?
          end
        end
      end
    end
  end
end
