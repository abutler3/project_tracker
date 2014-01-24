# This could double as an eventual homepage for the admin namespace
# and as a class other controllers in the admin namespace can
# inherit from
class Admin::BaseController < ApplicationController
  before_action :authorize_admin!
end
