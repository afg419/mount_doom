class Admin::AvatarsController < Admin::BaseController
  def index
    @avatars = Avatar.admin_alpha
  end

  def new
    @avatar = Avatar.new
  end

  def create
    @skill_set = SkillSet.create(skill_set_params)
    @avatar = Avatar.new(avatar_params)
    if @avatar.save
      @avatar.skill_set = @skill_set
      @avatar.save
      flash[:notice] = "Successfully created Avatar"
      redirect_to admin_dashboard_index_path
    else
      flash.now[:error] = "A avatar must have a name"
      render :new
    end
  end

  def show
    @avatar = Avatar.find_by(slug: params[:id])
  end

  def edit
    @avatar = Avatar.find(params[:id])
  end

  def update
    @avatar = Avatar.find(params[:id])
    @avatar.skill_set.update(skill_set_params)
    if @avatar.update(avatar_params)
      flash[:notice] = "Successfully Edited Avatar"
      redirect_to admin_avatars_path
    else
      flash.now[:error] = "A avatar must have a name"
      render :edit
    end
  end

  def destroy
    @avatar = Avatar.find(params[:id])
    @avatar.destroy
    redirect_to admin_avatars_path
  end

  private
    def avatar_params
      params.require(:avatar).permit(:name, :category_id)
    end

    def skill_set_params
      params.require(:avatar).permit(:strength, :dexterity, :intelligence, :health, :speed, :money )
    end
end
