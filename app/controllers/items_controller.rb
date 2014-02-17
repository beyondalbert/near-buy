class ItemsController < ApplicationController
  before_action :find_item, only: [:edit, :update, :show, :destroy]

  def index
    @items = current_user.items
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @picture = Picture.create(:file => params[:picture])
    @item.picture = @picture
    @item.owner_id = current_user.id
    if @item.save
      redirect_to items_path, flash: { success: "物品创建成功！" }
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id), flash: { success: "物品更新成功！" }
    else
      render "edit"
    end
  end

  def show
    @items = @item.owner.items.select { |i| i.id != @item.id }
    @trade = Trade.new
  end

  def destroy
    @item.destroy
    redirect_to items_path, flash: { success: "删除成功！" } 
  end

  private

  def item_params
    params.require(:item).permit(:subject, :description, :price)
  end

  def find_item
    @item = Item.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
