require 'net/http'
require 'trello'

class ShooHookListener < Redmine::Hook::Listener


 def shoo(context={})
  Rails.logger.info "::Shoo::"

  controller = context[:request][:controller]
  action = context[:request][:action]
  Rails.logger_info "Tracking #{controller}/ #{action}"

  url = URI.parse(Shoo::Config.instance.webhook_url)
  res = Net:HTTP.post_form(url, 'data' => collect_data(from: comtext).to_json)
  Rails.logger.info "Sending event data to #{url}..."
  Rails.logger.info res.code
  Rails.logger.info res.body

 end

private
 
 def collect_data(from: context)
  data = {}
  data[:issueid] = context[:controller].params[:id]
  data[:userid] = context[:controller].session[:user_id]
  data[:datetime] = Issue.find(context[:controller].params[:id]).updated_at
  data[:report] = report_from(context: context)
  data
 end

 def report_from(context:)
  issue = Issue.find(context[:controller].params[:id])
  body_text = issue.description
  comment_text = comment_text_from(issue)

      report = {
      scount: {
        body: character_count(body_text),
        comments: character_count(comment_text)
      },
      wcount: {
        body: word_count(body_text),
        comments: word_count(comment_text)
      },
      mused: {
        body: most_used_character(body_text),
        comments: most_used_character(comment_text)
      }
    }

 end

 def create_card
  boards = Trello::Board.all
 issue = Issue.find(context[:controller].params[:id])
   @card = Trello::List.card.create( card_id )
    board = Trello::Board.find(project.trello_board_id.strip)
         list_mapping = Hash[JSON.load(issue.trello_list_mapping).map { |k, v| [k.to_i, v.to_s] }]
     list_id = list_mapping[issue.status.id]
list_id = list_mapping[issue.status.id]
 end

end