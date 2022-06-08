module ApplicationHelper
  def full_title(page_name = "")
    base_title = "ReservationApp"
    if page_name.empty?
      base_title
    else
      page_name + " | " + base_title
    end
  end

  def store_name(store_id)
    Store.all.find(store_id).name
  end
end
