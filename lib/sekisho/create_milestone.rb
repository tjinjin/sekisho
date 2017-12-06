require 'octokit'
require 'date'

module Sekisho
  class Milestone
    def initialize
      @client = Octokit::Client.new(:access_token => ENV['GITHUB_ACCESS_TOKEN'])
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

    def list_milestones(repo)
      @client.list_milestones(repo, options = {
        state: 'open'
      })
    end

    def create_milestone(repo, target_day)
      options = {
        :state => "open",
        :description => "#{target_day.strftime(format = '%Y-%m-%d')}",
        :due_on =>target_day

      }
      resp = @client.create_milestone(repo, target_day.strftime(format = '%Y-%m-%d'), options)
    end
  end
end
