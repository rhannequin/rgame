# frozen_string_literal: true

module FlashHelper
  def color_for_alert_type(type)
    case type
    when "notice" then :green
    when "info" then :blue
    when "warning" then :orange
    when "error" then :red
    else :blue
    end
  end
end
