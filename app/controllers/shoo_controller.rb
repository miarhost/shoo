class ShooController < ApplicationController


def edit
 @config = Shoo::Config.instance
end

def update
 Shoo::Config.instance.webhook_url = params[:eventracker_config][:webhook_url]
 redirect_to :home
end 