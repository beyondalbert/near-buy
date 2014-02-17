class AddressesController < ApplicationController
  before_action :find_address, only: [:destroy, :set_default]
  def create
    @address = Address.new(address_params)

    if @address.save
      @addresses = current_user.addresses
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @address.destroy
    @addresses = current_user.addresses
    respond_to do |format|
      format.js
    end
  end

  def set_default
    @addresses = current_user.addresses
    @addresses.each do |address|
      if address.id == @address.id
        address.default = true
      else
        address.default = false
      end
      address.save
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def find_address
    @address = Address.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def address_params
    params.require(:address).permit(:content, :detail, :user_id)
  end
end
