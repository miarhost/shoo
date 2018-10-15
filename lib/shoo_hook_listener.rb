require 'net/http'

class ShooHookListener < Redmine::Hook::Listener

include Trello

 def shoo(context={})
  Rails.logger_info "::Shoo::"

  controller = context[:request][:controller]
  action = context[:request][:action]
  Rails.logger_info "Tracking #{controller}/ #{action}"

  url = URI.parse(Shoo::Config.instance.webhook_url)
  res = Net:HTTP.post_form(url, 'data' => collect_data(from: comtext).to_json)
  Rails.logger_info "Sending event data to #{url}..."
  Rails.logger_info res.code
  Rails.logger_info res.body

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
 issue = Issue.find(context[:controller].params[:id])
   @card = Trello::List.card.create( card_id )
 end
 
 def character_count(string)
  string.split('').size
 end

 def word_count(string)
  string.split(/[\s,.-]/).size
 end

 def most_used_character(string)
   characters = string.split('') - [' ', ',', '.', '-']

   freqs = characters.inject({}) do |freqs, char|
 	freqs.merge({char => characters.count(char)})
   end
   freqs.max_by { |char,times_used| times_used }.first
 end

end