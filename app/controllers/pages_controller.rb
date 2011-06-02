class PagesController < ApplicationController
  def about
    render :layout => true, :file => "/static/about-#{I18n.locale}.html"
  end
end
