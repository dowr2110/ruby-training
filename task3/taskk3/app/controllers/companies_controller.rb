class CompaniesController < ApplicationController
  def index
    @companies = Company.all
    render json: @companies
  end

  def show
    @company = Company.find(params[:id])
    render json: @company
  end

  def create
    @company = Company.create(
      company_name: params[:company_name]
    )
    render json: @company
  end

  def update
    @company = Company.find(params[:id])
    @company.update(
      company_name: params[:company_name]
    )
    render json: @company
  end

  def destroy
    @companies = Company.all
    @company = Company.find(params[:id])
    @company.destroy
    render json: @companies
  end
end
