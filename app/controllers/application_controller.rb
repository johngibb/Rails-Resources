require 'bcrypt'
include BCrypt

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_is_admin
  before_filter :verify_admin, :except => [:index, :show]
  
  protected
  
  def set_is_admin
    
    # Consider the visitor an admin if the request comes from the author's ip address
    
    @is_admin = true if "24.130.120.37" == request.remote_ip
    # @is_admin = false
  end
  
  def verify_admin

    render :inline => "No Access" unless @is_admin
  end
end
