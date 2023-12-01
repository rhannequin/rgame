# frozen_string_literal: true

module FlashHelper
  def color_for_alert_type(type)
    case type
    when "notice" then "border-green-400 text-green-700"
    when "info" then "border-blue-400 text-blue-700"
    when "warning" then "border-orange-400 text-orange-700"
    when "error" then "border-red-400 text-red-700"
    else "border-blue-400 text-blue-700"
    end
  end
end
