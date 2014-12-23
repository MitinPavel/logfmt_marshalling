require 'spec_helper'

describe ::LogfmtMarshalling::Marshaller do
  it 'serializes an empty hash' do
    actual = marshal({})
    expect(actual).to eq('')
  end

  it 'drops true value' do
    actual = marshal 'key' => true
    expect(actual).to eq('key')
  end

  it 'serializes multiple single keys' do
    actual = marshal 'key1' => true, 'key2' => true
    expect(actual).to eq('key1 key2')
  end

  it 'serializes an unquoted value' do
    actual = marshal 'key' => 'value'
    expect(actual).to eq('key=value')
  end

  it 'preserves order in serialized pairs' do
    actual = marshal 'key1' => 'value1', 'key2' => 'value2'
    expect(actual).to eq('key1=value1 key2=value2')
  end

  it 'serializes mixed single/non-single pairs' do
    actual = marshal 'key1' => 'value1', 'key2' => true
    expect(actual).to eq('key1=value1 key2')
  end

  it 'serializes mixed pairs whatever the order' do
    actual = marshal 'key1' => true, 'key2' => 'value2'
    expect(actual).to eq('key1 key2=value2')
  end

  it 'quotes values with whitespaces' do
    actual = marshal 'key' => 'a value'
    expect(actual).to eq('key="a value"')
  end

  it 'serializes escaped quote value ' do
    actual = marshal 'key' => 'quoted \" value', 'r' => 'esc\\t'
    expect(actual).to eq('key="quoted \" value" r="esc\t"')
  end

  it 'serializes mixed pairs' do
    actual = marshal 'key1' => 'quoted \" value', 'key2' => true, 'key3' => 'value3'
    expect(actual).to eq('key1="quoted \" value" key2 key3=value3')
  end

  it 'serializes mixed characters pairs' do
    actual = marshal 'foo' => 'bar',
                     'a' => 14,
                     'baz' => 'hello kitty',
                     'ƒ' => '2h3s',
                     'cool%story' => 'bro',
                     'f' => true,
                     '%^asdf' => true
    expect(actual).to eq('foo=bar a=14 baz="hello kitty" ƒ=2h3s cool%story=bro f %^asdf')
  end

  it 'serializes an empty string' do
    actual = marshal 'key' => ''
    expect(actual).to eq('key=""')
  end

  it 'serializes a whitespace string' do
    actual = marshal 'key' => ' '
    expect(actual).to eq('key=" "')
  end

  it "serializes false value" do
    actual = marshal 'key' => false
    expect(actual).to eq('key=false')
  end

  def marshal(data)
    described_class.new.marshal data
  end
end
