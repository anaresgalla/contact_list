class SessionsController < ApplicationController
  def new
    redirect_to user__contacts_path(current_user) if user_signed_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user_contacts_path(current_user)
    else
      flash.now[:danger] = "Email ou senha inválidos"
      render "new"
    end
  end

  def destroy
    sign_out
    flash[:warning] = "Deslogado com sucesso"
    redirect_to entrar_path
  end
end
