module ApplicationHelper

  def error_messages_for(object)
    render(:partial => 'shared/error_messages_for', :locals => {:object => object})
  end

end
