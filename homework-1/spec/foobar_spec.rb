require 'rspec'
require './foobar'

RSpec.describe 'foobar.rb' do
  describe '#foobar' do
    subject { foobar(num1, num2) }
    let(:num1) { 2 }
    let(:num2) { 20 }
    let(:result) { 2 }

    it 'checks if one of the integers is 20, returns the other if yes' do
      expect(subject).to eq result
    end

    context 'values variation 2' do
      let(:num1) { 20 }
      let(:num2) { 4 }
      let(:result) { 4 }

      it { is_expected.to eq result }
    end

    context 'values variation 3' do
      let(:num1) { 11 }
      let(:num2) { 7 }
      let(:result) { 11 + 7 }

      it { is_expected.to eq result }
    end
  end
end
