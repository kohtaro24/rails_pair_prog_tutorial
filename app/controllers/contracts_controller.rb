class ContractsController < ApplicationController
  def show
    @contract = Contract.includes(:calls, :plan).find(params[:id])
  end

  def edit
  end

  def update
  end
end
