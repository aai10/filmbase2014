module ApplicationHelper

  def error_messages_for(object)
    render 'layouts/error_messages_for', object: object
  end

end
