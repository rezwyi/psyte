class Admin::ApplicationController < ActionController::Base
  include Controllers::Authenticable
  include Controllers::Resourceable
  
  layout 'admin'
  
  before_action :login_required
  
  respond_to :html

  def index
    @resources = resource_class.order('id desc').page(params[:page])
    respond_with @resources
  end

  def new
    respond_with @resource
  end

  def create
    if @resource.save
      flash[:notice] = I18n.t("messages.#{resource_class.name.downcase}_created")
    end
    respond_with @resource, location: after_create_path
  end

  def edit
    respond_with @resource
  end

  def update
    if @resource.save
      flash[:notice] = I18n.t("messages.#{resource_class.name.downcase}_updated")
    end
    respond_with @resource, location: after_update_path
  end

  def destroy
    if @resource.destroy
      flash[:notice] = I18n.t("messages.#{resource_class.name.downcase}_deleted")
    end
    respond_with @resource, location: after_destroy_path
  end

  protected

  def after_create_path
    url_for [:admin, controller_name]
  end

  def after_update_path
    after_create_path
  end

  def after_destroy_path
    after_create_path
  end
end