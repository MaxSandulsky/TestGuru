class Admin::QuestionsController < Admin::BaseController
  before_action :authenticate_user!
  before_action :find_test, only: %i[new create]
  before_action :find_question, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_record_not_found

  def show; end

  def new
    set_question
  end

  def create
    @question = @test.questions.build(question_params)
    if @question.save
      redirect_to edit_admin_test_path(@test)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @question.update(question_params)
      redirect_to admin_test_path(@question.test)
    else
      render :edit
    end
  end

  def destroy
    @question.destroy

    redirect_to edit_admin_test_path(@question.test)
  end

  private

  def set_test
    @test = @question.test
  end

  def find_test
    @test = Test.find(params[:test_id])
  end

  def set_question
    @question = @test.questions.new
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body)
  end

  def rescue_with_record_not_found
    render plain: 'Record not found'
  end
end