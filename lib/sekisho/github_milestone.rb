require 'octokit'
require 'date'

module Sekisho
  module Github
    class Milestone
      def initialize
        @client = Octokit::Client.new(:access_token => ENV['GITHUB_ACCESS_TOKEN'])
      end

      def list_milestones(repo, state)
        @client.list_milestones(repo, options = {
          state: state
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
end
