class Admin::ItemsController < Admin::BaseController
  def index
    @items = Item.admin_alpha
  end

  def new
    @item = Item.new
  end

  def create
    @skill_set = SkillSet.create(skill_set_params)
    @item = Item.new(item_params)
    if @item.save
      @item.skill_set = @skill_set
      @item.save
      flash[:notice] = "Successfully created Item"
      redirect_to admin_dashboard_index_path
    else
      flash.now[:error] = "A item must have a name"
      render :new
    end
  end

  def show
    @item = Item.find_by(slug: params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.skill_set.update(skill_set_params)
    if @item.update(item_params)
      flash[:notice] = "Successfully Edited Item"
      redirect_to admin_items_path
    else
      flash.now[:error] = "A item must have a name"
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to admin_items_path
  end

  private
    def item_params
      params.require(:item).permit(:name, :category_id)
    end

    def skill_set_params
      params.require(:item).permit(:strength, :dexterity, :intelligence, :health, :speed, :money )
    end
end
