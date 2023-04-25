# frozen_string_literal: true

module ApplicationHelper

  def back_with_anchor(anchor: '')
    "#{request.referrer}##{anchor}"
  end
end
