module Shoo
 extend ActiveSupport::Concern

 included do
  after_action if: -> { should_be_tracked? request } do
   call_hook(:shoo, context)
  end
 end

 private

 def should_be_tracked?(request)

  tracked_actions = {
    welcome: :index,
    issues: :update,
    attachments: :create,
    attachments: :destroy,
    comments: :create,
    comments: :destroy
  }
 
  tracked_actions[request.params["controller"].to_sym] == request.params["action"].to_sym
 end

 def context
  {shoo_var: :some_value}
 end 

end