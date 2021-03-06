class SignupController < ApplicationController
  def create
    firebase = Firebase::Client.new(Rails.application.credentials.firebase_url, Rails.application.credentials.firebase_secret)
    user = User.new(user_params)

    if user.save
      payload = { user_id: user.id }
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
      tokens = session.login

      # Save session in browser's localstorage
      response.set_cookie(JWTSessions.access_cookie,
                          value: tokens[:access],
                          httponly: true,
                          secure: Rails.env.production?)

      # Save in firebase db
      firebase.push("users/#{user.id}", user)

      render json: { csrf: tokens[:csrf], user_id: user.id }
    else
      render json: { error: user.errors.full_messages.join(' ') }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:signup).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
