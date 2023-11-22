class ApplicationController < ActionController::Base
    include ActionController::Cookies

  rescue_from StandardError, with: :standard_error

    # store user id in session
    def save_user(id)
        session[:uid] = id
        session[:expiry] = 24.hours.from_now
    end
    # delete user id in session
    def remove_user
        session.delete(:uid)
        session[:expiry] = Time.now
    end

    # check for session expiry
    def session_expired?
        session[:expiry] ||= Time.now
        time_diff = (Time.parse(session[:expiry]) - Time.now).to_i
        unless time_diff > 0
        app_response(message: 'failed', status: 401, data: { info: 'Your session has expired. Please login again to continue' })
        end
    end

    # get logged in user
    def user
        User.find(@uid)
    end

    # save user's id
    def save_user_id(token)
        @uid = decode(token)[0]["data"]["uid"].to_i
    end

    # get logged in user (session)
    def user_session
        User.find(session[:uid].to_i)
    end

    # rescue all common errors
    def standard_error(exception)
        app_response(message: 'failed', data: { info: exception.message }, status: :unprocessable_entity)
    end

    # get logged in user
    def current_user
        @current_user = User.find_by(id: @uid)
    end

    private
    # rescue all common errors
    def standard_error(exception)
        app_response(message: 'failed', data: { info: exception.message }, status: :unprocessable_entity)
    end


    def authenticate_user!
        respond_to do |format|
            if !current_user
            format.html { redirect_to root_path, notice: "You aren't signed in or signed up" }
        end
    end
  end
end
