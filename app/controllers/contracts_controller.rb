class ContractsController < ApplicationController
  def show
    @contract = Contract.includes(:calls, :plan).find(params[:id])
  end

  def edit
    @contract = Contract.find(params[:id])
  end

  def update
    @contract = Contract.find(params[:id])
    @contract.update!(update_params)

    redirect_to contract_path(params[:id])
  end

  private

  def update_params
    params.require(:contract).permit(:name, :users_quantity)
  end
end
