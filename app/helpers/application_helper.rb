module ApplicationHelper
  def title(title)
    [title, t(:title)].join(' - ').html_safe
  end

  def copyright_years(from = 2011, to = Date.current.year)
    from != to ? "#{from}-#{to}".html_safe : from.to_s.html_safe
  end

  def current_class(page)
    " class='current'".html_safe if current_page?(page)
  end

  def last_tweet(tweet)
    return unless tweet
    text = tweet['text'].length > 59 ? "#{tweet['text'][0,60]}..." : tweet['text']
    html = content_tag(:div, :class => 'last-tweet') do
      link_to(text, "http://twitter.com/rezwyi/status/#{tweet['id_str']}",
                    :target => 'blank')
    end
    html
  end
end
