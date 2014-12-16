require 'spec_helper'

describe ::LogfmtMarshalling::Marshaller do
  it 'serializes an empty hash' do
    actual = marshal({})
    expect(actual).to eq('')
  end

  def marshal(data)
    described_class.new.marshal data
  end
end
