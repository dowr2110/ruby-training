class ProvidersController < ApplicationController
  def index
    @providers = Provider.all
    render json: @providers
  end

  def show
    @provider = Provider.find(params[:id])
    render json: @provider
  end

  def create
    @provider = Provider.create(
      provider_name: params[:provider_name],
      phone_number: params[:phone_number]
    )
    render json: @provider
  end

  def update
    @provider = Provider.find(params[:id])
    @provider.update(
      provider_name: params[:provider_name],
      phone_number: params[:phone_number]
    )
    render json: @provider
  end

  def destroy
    @providers = Provider.all
    @provider = Provider.find(params[:id])
    @provider.destroy
    render json: @providers
  end
end
