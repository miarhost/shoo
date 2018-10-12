class ShooController < ApplicationController

include Trello

def edit
 @config = Shoo::Config.instance
end

def update
 Shoo::Config.instance.webhook_url = params[:eventracker_config][:webhook_url]
 redirect_to :home
 list = Trello::List.new
 @card = list.card.create( card_id )
end 