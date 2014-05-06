module ApplicationHelper

  def error_messages_for(object)
    render 'layouts/error_messages_for', object: object
  end

  def selectify(arr)
    res=[]
    for i in 0...arr.size
      res << [arr[i],i]
    end
    res
  end

  def link_to_back
  link_to(fa_icon("angle-left")+' Назад',:back, class: 'btn btn-default')
  end

end
