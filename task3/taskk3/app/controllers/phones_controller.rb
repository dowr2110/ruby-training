class PhonesController < ApplicationController
  def index
    @phones = Phone.all
    render json: @phones
  end

  def show
    @phone = Phone.find(params[:id])
    render json: @phone
  end

  def create
    @phone = Phone.create(
      phone_name: params[:phone_name],
      price: params[:price],
      provider_id: params[:provider_id],
      company_id: params[:company_id]
    )
    render json: @phone
  end

  def update
    @phone = Phone.find(params[:id])
    @phone.update(
      phone_name: params[:phone_name],
      price: params[:price],
      provider_id: params[:provider_id],
      company_id: params[:company_id]
    )
    render json: @phone
  end

  def destroy
    @phones = Phone.all
    @phone = Phone.find(params[:id])
    @phone.destroy
    render json: @phones
  end
end
