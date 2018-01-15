require 'octokit'
require 'date'

module Sekisho
  module Github
    class Milestone
      def initialize
        @client = Octokit::Client.new(:access_token => ENV['GITHUB_ACCESS_TOKEN'])
        @client.auto_paginate = true
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

      def close_milestone(repo, milestone_number)
        options = {
          state: 'closed'
        }
        @client.update_milestone(repo, milestone_number, options)
      end

      def list_issues(repo, milestone_number)
        options = {
          state: 'open',
          milestone: milestone_number
        }
        @client.list_issues(repo, options)
      end

      def open_issues?(repo, milestone_number)
        list_issues(repo, milestone_number).blank?
      end
    end
  end
end
