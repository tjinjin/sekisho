require 'octokit'
require 'date'

module Sekisho
  module Github
    class Milestone
      def initialize(api_key)
        @api_key = github_api_key(api_key)
        @client = Octokit::Client.new(access_token: @api_key)
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
          # Github supports iso8601 https://developer.github.com/v3/issues/milestones/#create-a-milestone
          :due_on =>target_day.to_time.iso8601
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

      private

      def github_api_key(api_key)
        @api_key ||=
          case
          when ENV['GITHUB_ACCESS_TOKEN']
            return ENV['GITHUB_ACCESS_TOKEN']
          when api_key
            return api_key
          else
            puts <<-MESSAGE
Can't find github access token.
Please set api key.
  - sekisho_config.yml api_key: xxxxxxxxxxxxxxxx
  - Enviroment variables export GITHUB_ACCESS_TOKEN=xxxxxxxxxxxxxxxx
            MESSAGE
            exit
          end
      end
    end
  end
end
