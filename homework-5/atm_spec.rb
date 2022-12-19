require 'rspec'
require './atm'

RSpec.describe Atm do
  subject { described_class.new }
  describe '#initialize' do
    it { expect(subject.account).to be > 0 }
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

# before do
#   allow(subject).to receive(:loop).and_yield
#   allow_any_instance_of(Kernel).to receive(:gets).and_return('q')
# end