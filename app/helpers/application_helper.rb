module ApplicationHelper
  def nice_date(date)
    if date then
      date.strftime("%B %d, %Y")
    else
      nil
    end
  end
end
