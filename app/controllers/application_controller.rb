require 'bcrypt'
include BCrypt

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_is_admin
  before_filter :verify_admin, :except => [:index, :show]
  
  protected
  
  def set_is_admin
    
    # Consider the visitor an admin if the request comes from one of the author's two ip addresses
    # Note: I'm only encryption here so I don't have to check in my ip address. I'm not sure why. ;)
    
    @is_admin = true if Password.new("$2a$10$DyppL0e6Gr2GLk9whAkjSexRiNsULTEfr2SixCyPz9yy94cWRMw0y") == request.remote_ip
    @is_admin = true if Password.new("$2a$10$cBUOPXSPlwH2av1N6vgEm.6DQShzskQGm1QjSPhzNar4vvHIhTyo.") == request.remote_ip
    # @is_admin = false
  end
  
  def verify_admin

    render :inline => "No Access" unless @is_admin
  end
end
