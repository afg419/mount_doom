class Admin::ItemsController < Admin::BaseController
  def index
    @items = Item.admin_alpha
  end

  def new
    @item = Item.new
    @item.itemable = Store.find(params[:store_id])
  end

  def create
    @store = Store.find(params[:store_id])
    @skill_set = SkillSet.new(skill_set_params)
    if @store && @skill_set.save
      @item = Item.new(item_params)
      @item.skill_set = @skill_set
      @item.itemable = @store
      if @item.save
        flash[:notice] = "Successfully created Item"
        redirect_to edit_admin_store_path(@store.id)
      else
        flash.now[:error] = "A item must have a name"
        render :new
      end
    else
      flash.now[:error] = "Your attributes are off"
      render :new
    end
  end

  # def show
  #   @item = Item.find_by(slug: params[:id])
  # end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.skill_set.update(skill_set_params)
      if @item.update(item_params)
        flash[:notice] = "Successfully Edited Item"
        redirect_to admin_items_path
      else
        flash.now[:error] = "A item must have a name"
        render :edit
      end
    else
      flash.now[:error] = "Your attributes are off"
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
