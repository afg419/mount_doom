class Admin::StoresController < Admin::BaseController
  def index
    @stores = Store.admin_alpha
  end

  def edit
    @store = Store.find(params[:id])
    @store_items = @store.items
  end

  def update
    @store = Store.find(params[:id])
    if @store.skill_set.update(skill_set_params)
      if @store.update(store_params)
        flash[:notice] = "Successfully Edited Store"
        redirect_to admin_stores_path
      else
        flash.now[:error] = "A store must have a name"
        render :edit
      end
    else
      flash.now[:error] = "Invalid store attributes"
      render :edit
    end
  end

  private
    def store_params
      params.require(:store).permit(:name, :image_url)
    end

    def skill_set_params
      params.require(:store).permit(:strength, :dexterity, :intelligence, :health, :speed, :money )
    end
end
