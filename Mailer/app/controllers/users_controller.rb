class UsersController < ApplicationController
  # POST /users
  # POST /users.json
  skip_before_action :verify_authenticity_token
  def create

    @user = User.create(
      name: params[:name],
      email: params[:email],
      login: params[:login]
    )

    respond_to do |format|
      if @user.save
        # Сказать UserMailer отослать приветственное письмо после сохранения
        UserMailer.with(user: @user).welcome_email.deliver_later

        format.html { redirect_to(@user, notice: 'User was successfully created.') }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
