require 'rails_helper'

RSpec.describe Plan, type: :model do
  describe '.suggest_plan_id' do
    let(:contract) { nil }
    subject { described_class.suggest_plan_id(contract) }

    context 'if contract users_quantity == 5' do
      let(:contract) { FactoryBot.build(:contract, :free, users_quantity: 5) }

      it { is_expected.to eq Plan::FREE_PLAN_ID }
    end

    context 'if contract users_quantity > 5' do
      let(:contract) { FactoryBot.build(:contract, :free, users_quantity: 6) }

      it { is_expected.to eq Plan::BASIC_PLAN_ID }
    end
  end

  describe '#free?' do
    let(:plan) { nil }
    subject { plan.free? }

    context 'if plan is free' do
      let(:plan) { FactoryBot.create(:free_plan) }

      it { is_expected.to be_truthy }
    end

    context 'if plan is basic' do
      let(:plan) { FactoryBot.create(:basic_plan) }

      it { is_expected.to be_falsey }
    end
  end
end
