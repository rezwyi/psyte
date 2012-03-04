module ApplicationHelper
  def title(title)
    [title, t(:title)].join(' - ')
  end

  def copyright_years(from = 2011, to = Date.current.year)
    from != to ? "#{from}-#{to}".html_safe : from.to_s
  end
end
