ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  errors = Array(instance.error_message).join(',')

  html = case html_tag
  when /label/ then html_tag
  else
    <<-HTML
      <div class="error">
        #{html_tag}
        <label class="explain">#{errors}</label>
      </div>
    HTML
  end

  html.html_safe
end