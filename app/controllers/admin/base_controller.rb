class Admin::BaseController < ApplicationController
  http_basic_authenticate_with name: Rails.configuration.admin_login[:username], password: Rails.configuration.admin_login[:password]
end
