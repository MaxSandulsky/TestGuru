class Admin::TestsController < Admin::BaseController
  before_action :set_tests, only: %i[index update_inline]
  before_action :set_test, only: %i[show new edit update destroy start update_inline]

  rescue_from ActiveRecord::RecordInvalid, with: :rescue_with_test_invalid

  def index; end

  def show; end

  def new; end

  def create
    @test = current_user.tests.build(test_params)
    if @test.save
      redirect_to admin_test_path(@test)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @test.update(test_params)
      redirect_to admin_test_path(@test)
    else
      render :edit
    end
  end

  def update_inline
    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render :index
    end
  end

  def destroy
    @test.destroy

    redirect_to admin_tests_path
  end

  private

  def set_tests
    @tests = Test.all
  end

  def set_test
    @test = Test.find_or_initialize_by(id: params[:id])
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :timer)
  end

  def test_passage(test)
    @test_passage = current_user.uncomplete_test_passage(test)

    @test_passage ||= current_user.tests_passed.push(test).find(test.id).test_passages.by_uncomplete.find_by(user_id: current_user.id)
  end

  def rescue_with_test_invalid(exemption)
    render plain: exemption
  end
end
