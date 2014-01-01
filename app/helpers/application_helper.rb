module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Project Tracker").join(" - ")
      end
    end
  end
end
