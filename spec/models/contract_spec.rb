require 'rails_helper'

RSpec.describe Contract, type: :model do
  describe 'before_validation' do
    describe '#replan' do
      let!(:plan) { FactoryBot.create(:free_plan) }
      let(:contract) { FactoryBot.build(:contract, users_quantity: 1) }

      before do
        allow(Plan).to receive(:suggest_plan_id).and_return(plan.id)
      end

      subject { contract.save! }

      it { expect { subject }.to change { contract.id }.from(nil).to(plan.id) }
    end
  end

  describe '#usage_price' do
    let(:contract) { nil }
    before do
      allow_any_instance_of(Contract).to receive(:base_price).and_return(100)
      allow_any_instance_of(Contract).to receive(:call_price).and_return(10)
    end
    subject { contract.usage_price }

    context 'if plan is free' do
      let(:contract) { FactoryBot.create(:contract, :free, users_quantity: 5) }

      it { is_expected.to eq 0 }
    end

    context 'if plan is basic' do
      let(:contract) { FactoryBot.create(:contract, :basic, users_quantity: 6) }

      it { is_expected.to eq 110 }
    end
  end

  describe '#base_price' do
    let(:contract) { nil }

    subject { contract.send(:base_price) }

    context 'if plan is free and users_quantity = 5' do
      let(:contract) { FactoryBot.create(:contract, :free, users_quantity: 5) }

      it { is_expected.to eq 0 }
    end

    context 'if plan is basic and users_quantity = 10' do
      let(:contract) { FactoryBot.create(:contract, :basic, users_quantity: 10) }

      it { is_expected.to eq 48000 }
    end
  end

  describe '#call_price' do
    let!(:calls) { [] }

    let(:contract) { FactoryBot.create(:contract, :basic, calls: calls, users_quantity: 10) }
    subject { contract.send(:call_price) }

    context 'when calls empty' do
      it { is_expected.to eq 0 }
    end

    context 'when calls exists' do
      let!(:calls) do
        [
          FactoryBot.build(:call, duration: 60),
          FactoryBot.build(:call, duration: 120),
          FactoryBot.build(:call, duration: 1),
        ]
      end

      it { is_expected.to eq 4 }
    end
  end
end
