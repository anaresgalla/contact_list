module ApplicationHelper
  def bootstrap_alert_class(type)
    case type.to_sym
    when :notice then "success"
    when :alert then "danger"
    else type.to_s
    end
  end
end
