module ApplicationHelper
  def copyright_years(from = 2011, to = Date.current.year)
    from != to ? "#{from}-#{to}".html_safe : from.to_s.html_safe
  end

  def current_class(page)
    'current' if request.path.starts_with?(page)
  end

  def render_markdown(markdown)
  	Rails.application.config.md_renderer.render(markdown).html_safe
  end

  def format_project_url(url)
    url.strip.gsub /\Ahttps?:\/\//, ''
  end
end
