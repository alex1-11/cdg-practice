require 'rspec'
require './atm'

RSpec.describe 'atm.rb' do
  subject { Atm.new }
  describe '#initialize' do
    before { allow_any_instance_of(Kernel).to recieve(:gets).and_return('q') }
    it { is_expected.to be positive }
  end

  # describe '.input_float' do
  #   it 'asks user to input float' do
  #     expect(atm.input_float).to eq Float
  #   end

  #   context 'when user input in not float or int' do
  #     let(:input) { 'float' }

  #     it { expect { subject }.to raise_error(ArgumentError) }
  #   end


  #   desribe '#deposit' do
  #   end
  # end
end
