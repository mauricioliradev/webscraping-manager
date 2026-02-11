class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :destroy]

  # Listar
  def index
    @tasks = Task.where(user_id: current_user_id).order(created_at: :desc)
  end


  def show
  end

  def new
    @task = Task.new
  end

  # Criar e Disparar Job
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user_id
    @task.status = :pending

    if @task.save
      # Dispara o worker
      ScrapingJob.perform_later(@task.id)
      
      redirect_to tasks_path, notice: 'Tarefa criada! O robô já está processando.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Excluir tarefa
  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Tarefa removida com sucesso.'
  end

  private

  def set_task
    # usuário só acessa ou apaga suas próprias tarefas
    @task = Task.find_by(id: params[:id], user_id: current_user_id)
    redirect_to tasks_path, alert: "Tarefa não encontrada." unless @task
  end

  def task_params
    params.require(:task).permit(:title, :url, :description)
  end
end