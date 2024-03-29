class Admin::BadgesController < Admin::BaseController
  def index
    @user_badges = current_user.badges
    @badges = Badge.all
  end

  def new
    @badge = Badge.new
  end

  def create
    @badge = Badge.new(badge_params)
    if @badge.save
      redirect_to admin_badges_path
    else
      render :new
    end
  end

  private

  def badge_params
    params.require(:badge).permit(:title, :description, :rule, :rule_value, :pic_url)
  end
end
