require 'rspec'
require './atm'

RSpec.describe Atm do
  subject { described_class.new }

  describe '#initialize' do
    let(:acc) { File.read(BALANCE).to_f if File.exist?(BALANCE) }

    it 'passes when account balance is loaded and is a non-negative Float' do
      expect(subject.account).to be >= 0
      expect(subject.account).to be_instance_of(Float)
      expect(subject.account).to eq(DEFAULT_BALANCE).or eq(acc)
    end
  end

  describe '#balance' do
    it 'messages in console and returns account value' do
      expect { subject.balance }.to output(
        /Current balance is #{subject.account} golden units/
      ).to_stdout
      expect(subject.balance).to eq subject.account
    end
  end

  describe '.input_float' do
    let(:input) { '100.75' }

    before { allow_any_instance_of(Kernel).to receive(:gets).and_return(input) }

    it 'asks to input float, validates value and returns float' do
      # https://tips.tutorialhorizon.com/2016/08/11/how-to-test-a-private-method-in-rspec
      expect(subject.send(:input_float)).to equal 100.75
    end

    context 'when input is negative' do
      let(:input) { '-7.25' }

      it 'throws message to console and returns 0' do
        expect { subject.send(:input_float) }.to output(
          /ERROR! Amount should be a POSITIVE number!/
        ).to_stdout
        expect(subject.send(:input_float)).to equal 0
      end
    end

    context 'when input is not a Float (or int)' do
      let(:input) { 'foo' }

      it 'rescues ArgumentError, throws message to console and returns 0' do
        expect { subject.send(:input_float) }.to output(
          /ERROR! Amount should be a NUMBER! Floating point is allowed./
        ).to_stdout
        expect(subject.send(:input_float)).to equal 0
      end
    end
  end

  # describe '#deposit' do
  #   let(:input) { '100' }

  #   before { allow_any_instance_of(Kernel).to receive(:gets).and_return(input) }

  # end
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

# use for loop in init
# allow(subject).to receive(:loop).and_yield
