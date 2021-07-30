require 'rails_helper'

RSpec.describe "Contracts", type: :request do
  describe "GET /contracts/:id" do
    let(:params) { {} }
    subject { get contract_url(params) }

    context 'when contract exists' do
      let!(:contract) { FactoryBot.create(:contract, :free, users_quantity: 5) }
      let(:params) { { id: contract.id } }
      before { subject }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response.body).to include(contract.name) }
    end

    context 'when contract not exists' do
      let(:params) { { id: 0 } }

      it { expect { subject }.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe "GET /contracts/:id/edit" do
    let(:params) { {} }
    subject { get edit_contract_url(params) }

    context 'when contract exists' do
      let!(:contract) { FactoryBot.create(:contract, :free, users_quantity: 5) }
      let(:params) { { id: contract.id } }
      before { subject }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response.body).to include(contract.name) }
    end

    context 'when contract not exists' do
      let(:params) { { id: 0 } }

      it { expect { subject }.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe "PUT /contracts/:id" do
    let(:params) { {} }
    let!(:free_plan) { FactoryBot.create(:free_plan) }
    let!(:basic_plan) { FactoryBot.create(:basic_plan) }

    let!(:contract) { FactoryBot.create(:contract, :free, users_quantity: 5) }
    subject { put contract_url(contract), params: params }

    context 'when params valid' do
      let(:params) { { contract: { name: 'ボンバーマン', users_quantity: 6 } } }

      it do
        subject
        expect(response).to redirect_to contract_url(contract)
      end

      it do
        expect { subject }.to change { Contract.find(contract.id).attributes.slice('name', 'users_quantity') }
          .from(contract.attributes.slice('name', 'users_quantity'))
          .to(params[:contract].transform_keys(&:to_s))
      end

      it do
        expect { subject }.to change { Contract.find(contract.id).plan_id }
          .from(free_plan.id)
          .to(basic_plan.id)
      end
    end

    context 'when params invalid' do
      let(:params) { { contract: { name: nil, users_quantity: 4 } } }

      it { expect { subject }.to raise_error ActiveRecord::NotNullViolation }
    end
  end
end
