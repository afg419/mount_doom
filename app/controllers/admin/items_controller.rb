class Admin::ItemsController < Admin::BaseController
  def index
    @items = Item.admin_alpha
  end

  def new
    @item = Item.new
    unless @item.itemable = Store.find_by(id: params[:store_id])
      flash[:error] = "Please select a store's inventory to edit."
      redirect_to admin_stores_path
    end
  end

  def create
    @store = Store.find_by(id: params[:store_id])
    @skill_set = SkillSet.new(skill_set_params)
    if @store && @skill_set.save
      @item = Item.new(item_params)
      @item.skill_set = @skill_set
      @item.itemable = @store
      @item.category_id = params[:category_id]
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

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.skill_set.update(skill_set_params)
      if @item.update(item_params)
        flash[:notice] = "Successfully Edited Item"
        redirect_to edit_admin_store_path(id: params[:store_id])
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
    redirect_to edit_admin_store_path(id: params[:store_id])
  end

  private
    def item_params
      params.require(:item).permit(:name)
    end

    def skill_set_params
      params.require(:item).permit(:strength, :dexterity, :intelligence, :health, :speed, :money )
    end
end
