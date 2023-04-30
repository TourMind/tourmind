# frozen_string_literal: true

module ApplicationHelper
  def format_date(date)
    date.in_time_zone('Taipei').strftime('%Y/%m/%d')
  end
end
