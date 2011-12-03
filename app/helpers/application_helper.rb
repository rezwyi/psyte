module ApplicationHelper
  def title(title)
    [title, t(:title)].join(' - ')
  end
end
