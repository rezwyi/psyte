module ApplicationHelper
  def title(title)
    [title, t(:title)].join(' - ').html_safe
  end

  def copyright_years(from = 2011, to = Date.current.year)
    from != to ? "#{from}-#{to}".html_safe : from.to_s.html_safe
  end

  def current_class(page)
    " class='current'".html_safe if request.path.starts_with?(page)
  end
end
