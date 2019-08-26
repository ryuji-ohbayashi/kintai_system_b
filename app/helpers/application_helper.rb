module ApplicationHelper
  
  def full_title(page_name = "") # ← 2.9 3~10
    base_title = "AttendanceApp"
    if page_name.empty?
      base_title
    else
      page_name + " | " + base_title
    end
  end
end
