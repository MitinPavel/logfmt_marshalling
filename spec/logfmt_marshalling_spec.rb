require 'spec_helper'

describe ::LogfmtMarshalling do
  describe '.marshal' do
    it 'delegates work to LogfmtMarshalling::Marshaller' do
      expect_any_instance_of(::LogfmtMarshalling::Marshaller).to receive(:marshal).with 'k' => 'v'

      described_class.marshal 'k' => 'v'
    end
  end
end
