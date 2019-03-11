require 'slack-notifier'

module Sekisho
  class Notify
    def initialize
      @notifier = Slack::Notifier.new "#{ENV['SLACK_WEBHOOK_URL']}" do
        defaults channel: "#{ENV['SLACK_CHANNEL']}",
                 username: "#{ENV['SLACK_USERNAME']}"
      end
    end

    def build_attachments(milestone_number, milestone,repo)
      {
        "color": "warning",
        "title": "Open issue associated. [#{repo}] #{milestone}",
        "title_link": "https://github.com/#{repo}/milestone/#{milestone_number}",
        "footer": "sekisho",
        "footer_icon": "https://platform.slack-edge.com/img/default_application_icon.png",
        "fields":[
          {
            "title": "milestone",
            "value": "#{milestone.strftime('%Y-%m-%d')}",
            "short": false
          },
          {
            "title": "repository",
            "value": "#{repo}",
            "short": false
          }
        ]
      }
    end

    def post(params)
      attachments = build_attachments(params[:milestone_number], params[:milestone], params[:repo])
      @notifier.post text: "", attachments: attachments
    end
  end
end
