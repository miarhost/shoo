require 'trello'

class ShoosController < ApplicationController


 def edit
  @config = Shoo::Config.instance
 end

 def update
  Shoo::Config.instance.webhook_url = params[:shoo_config][:webhook_url]
  redirect_to :home
 end 

 def create
  @issue_trello_board_id = params[:issue][:trello_board_id]
  @issue.trello_list_mapping = params[:trello_list_mapping].to_json
  @issue.save!
  token = Trello::Token.find( Setting.plugin_redmine_trello_card_sync['TRELLO_MEMBER_TOKEN'] )
  trello_board_info = "'#{Trello::Board.find( @issue.trello_board_id ).name}' (#{@issue.trello_board_id})"
 end

end