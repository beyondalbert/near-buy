class TradesController < ApplicationController
  before_action :find_item, only: [:create, :management]
  skip_before_action :require_login, only: [:create]

  def create
    @item = Item.find(params[:item_id])
    @trade = Trade.new(saler_id: @item.owner_id, item_id: @item.id, number: params[:number])
    @buyer = Buyer.new(buyer_params)

    if params[:vip]
      @buyer.member_id = current_user.id
      @default_address = current_user.default_address
      if @default_address
        @buyer.address = @default_address.content
        @buyer.address_detail = @default_address.detail
      end
    end

    @trade.buyer = @buyer

    if @trade.save
      @success = true

      # add phone notifiction
      ChinaSMS.use :smsbao, username: APP_CONFIG["sms_account"]["user"], password: APP_CONFIG["sms_account"]["password"]
      ChinaSMS.to @buyer.phone, "你购买了#{@item.subject}#{@trade.number}份，总价：#{@trade.number * @item.price}元，如有问题，请联系卖家： #{@item.owner.name}（#{@item.owner.phone}）。非本人操作请无视之。［身边买］"

      flash[:success] = "订单提交成功！订单信息已经发送到你手机上，请查收！"
    end
    respond_to do |format|
      format.js
    end
  end

  def management
    @flag = params[:flag]
    case @flag
    when "undo"
      @trades = @item.trades.select { |trade| trade.status == 1 }
    when "done"
      @trades = @item.trades.select { | trade| trade.done? }
    else
      @trades = @item.trades
    end

    @items = current_user.items
    @total_sales = @item.total_sales
    @sales_volume = @item.sales_volume
  end

  def done_trade
    @trade = Trade.find_by_id(params[:id])

    if @trade.done?
      @trade.status = 1
    else
      @trade.status = 2
    end
    @trade.save

    respond_to do |format|
      format.js
    end

  end

  private

  def buyer_params
    params.require(:buyer).permit(:name, :phone, :address, :address_detail, :sns_type, :sns_num)
  end

  def find_item
    @item = Item.find(params[:item_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
