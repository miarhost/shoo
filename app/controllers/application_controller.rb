class ApplicationController < ActionController::Base

 include Trello

 include Redmine::Hook::Helper
 include ShooHookListener

end
