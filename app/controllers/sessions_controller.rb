class SessionsController < ApplicationController
  # GET /login
  def new
  end

  # POST /login
  def create
    client = AuthClient.new
    result = client.login(params[:email], params[:password])

    if result[:success]
      # Salva o token na sessão do navegador
      session[:jwt_token] = result[:data]['token']
      session[:user_id] = result[:data]['user']['id']
      session[:user_email] = result[:data]['user']['email']

      redirect_to root_path, notice: 'Login realizado com sucesso!'
    else
      flash.now[:alert] = result[:error]
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /logout
  def destroy
    session[:jwt_token] = nil
    session[:user_id] = nil
    redirect_to login_path, notice: 'Saiu com sucesso.'
  end
end