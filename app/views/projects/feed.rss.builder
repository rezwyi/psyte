xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title t(:title)
    xml.description t('common.description')
    xml.link projects_url
    xml.language('ru-ru')

    @projects.each do |project|
      xml.item do
        xml.title project.title
        xml.description project.description
        xml.pubDate project.created_at.to_s(:rfc822)
        xml.link project_url(project)
        xml.guid project_url(project)
      end
    end

  end
end

