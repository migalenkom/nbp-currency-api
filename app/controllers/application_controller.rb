class ApplicationController < ActionController::Base
  rescue_from Date::Error do |e|
    render json: { error: "#{e.message}" }, status: :unprocessable_entity
  end
end
