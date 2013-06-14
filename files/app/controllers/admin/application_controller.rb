class Admin::ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html
  before_filter :authenticate_user!
  responders :flash
  layout 'admin'
end
