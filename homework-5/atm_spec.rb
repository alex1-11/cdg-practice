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

  describe '#deposit' do
    let(:amount) { '50.75' }

    before { allow_any_instance_of(Kernel).to receive(:gets).and_return(amount) }

    it 'increaces @account by the input amount' do
      expect { subject.deposit }.to change { subject.account }.by 50.75
    end
  end

  describe '#withdraw' do
    let(:amount) { '100.25' }

    # Handle user input
    before do
      allow_any_instance_of(Kernel).to receive(:gets).and_return(amount)
    end

    it 'decreaces @account by the input amount, returns changed @account' do
      # Add money to acc for happy path if the BALANCE File value is not enough
      subject.deposit if subject.account < amount.to_f
      # Run example
      # Don't combine these two types of matchers in single expectation
      # Or implement `supports_block_expectations` https://github.com/rspec/rspec-expectations/issues/536#issuecomment-248032716
      expect { subject.withdraw }.to change { subject.account }.by(-amount.to_f)
      expect(subject.withdraw).to eq(subject.account)
    end

    context 'when balance insufficient' do
      # Make sure to put amount greater than account balance in BALANCE File
      let(:amount) { (subject.account + 9000.5).to_s }
      it 'throws message, returns unchanged @account' do
        expect { subject.withdraw }.to output(
          /ERROR! Balance insufficient!/
        ).to_stdout
          .and change(subject, :account).by 0
        expect(subject.withdraw).to eq(subject.account)
      end
    end
  end

  describe '#quit' do
    it 'saves @account value to BALANCE File' do
      # Mock the interaction with File https://www.rubyguides.com/2018/10/rspec-mocks/
      expect(File).to receive(:write).with(BALANCE, subject.account)
      subject.quit
      expect(subject.account).to eq(File.read(BALANCE).to_f)
    end
  end
end


# # Use this for stopping the loop in Atm.init:
# allow(subject).to receive(:loop).and_yield

# # Snippet for integration test of #quit
# describe '#quit' do
#   before do
#     allow_any_instance_of(Kernel).to receive(:gets).and_return('0.7777')
#   end
#   it 'saves @account value to BALANCE File' do
#     allow(File).to receive(:write).with(BALANCE, subject.account + 0.7777)
#     subject.deposit
#     subject.quit
#     expect(subject.account).to eq(File.read(BALANCE).to_f + 0.7777)
#   end
# end