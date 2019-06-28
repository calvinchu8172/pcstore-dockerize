module ApplicationHelper

  def flash_filter key
    case key
    when 'notice'
      key = 'info'
    when 'alert'
      key = 'warning'
    else
      key
    end
    key
  end

end
