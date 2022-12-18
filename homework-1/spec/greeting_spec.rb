require 'rspec'
require './greeting'

RSpec.describe 'greeting.rb' do
  describe '#greeting' do
    subject { greeting }

    let(:firstname) { 'Testname' }
    let(:lastname) { 'Lastname' }
    let(:age) { 16 }
    let(:promt) do
      "What's your frist name? > "\
      "What's your last name? > "\
      'How old are you? > '
    end
    let(:msg) do
      "Hello, #{firstname} #{lastname}. You are younger than 18, but starting "\
      "to learn coding is never too early.\n"
    end

    before { allow_any_instance_of(Kernel).to receive(:gets).and_return(firstname, lastname, age) }

    it 'asks for input and if age < 18' do
      expect { subject }.to output(promt + msg).to_stdout
    end

    context 'if age >= 18' do
      let(:age) { 42 }
      let(:msg) do
        "Hello, #{firstname} #{lastname}. It's a great time to start coding!\n"
      end

      it 'asks for input and if age >= 18' do
        expect { subject }.to output(promt + msg).to_stdout
      end
    end
  end
end
