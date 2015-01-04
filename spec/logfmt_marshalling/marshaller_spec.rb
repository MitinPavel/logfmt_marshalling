require 'spec_helper'

describe ::LogfmtMarshalling::Marshaller do
  it 'serializes an empty hash' do
    actual = marshal({})
    expect(actual).to eq('')
  end

  it 'serializes an empty string' do
    actual = marshal 'key' => ''
    expect(actual).to eq('key=""')
  end

  it 'serializes a whitespace string' do
    actual = marshal 'key' => ' '
    expect(actual).to eq('key=" "')
  end

  it 'drops the TrueClass instance value' do
    actual = marshal 'key' => true
    expect(actual).to eq('key')
  end

  it "serializes the FalseClass instance value" do
    actual = marshal 'key' => false
    expect(actual).to eq('key=false')
  end

  it 'serializes a quoted true as a string' do
    actual = marshal 'key' => 'true'
    expect(actual).to eq('key="true"')
  end

  it 'serializes a quoted false as a string' do
    actual = marshal 'key' => 'false'
    expect(actual).to eq('key="false"')
  end

  it 'serializes a single key-value pair' do
    actual = marshal 'key' => 'value'
    expect(actual).to eq('key=value')
  end

  it 'serializes multiple key-value pairs' do
    actual = marshal 'key1' => true, 'key2' => true
    expect(actual).to eq('key1 key2')
  end

  it 'preserves order of serialized pairs' do
    actual = marshal 'key1' => 'value1', 'key2' => 'value2'
    expect(actual).to eq('key1=value1 key2=value2')
  end

  it 'serializes mixed single/non-single pairs' do
    actual = marshal 'key1' => 'value1', 'key2' => true
    expect(actual).to eq('key1=value1 key2')
  end

  it 'preserves order of  mixed single/non-single pairs' do
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

  it 'serializes a positive integer' do
    actual = marshal 'key' => 234
    expect(actual).to eq('key=234')
  end

  it 'serializes a negative integer' do
    actual = marshal 'key' => -3428
    expect(actual).to eq('key=-3428')
  end

  it 'serializes a bignum' do
    bignum = 9999999999999999999
    expect(bignum).to be_a(Bignum)

    actual = marshal 'key' => bignum

    expect(actual).to eq('key=9999999999999999999')
  end

  it 'serializes a positive float' do
    actual = marshal 'key' => 3.14
    expect(actual).to eq('key=3.14')
  end

  it 'serializes a negative float' do
    actual = marshal 'key' => -0.9934
    expect(actual).to eq('key=-0.9934')
  end

  it 'serializes an exponential float' do
    actual = marshal 'key' => 2.342342342342344e+18
    expect(actual).to eq('key=2.342342342342344e+18')
  end

  %w(
      0
      1
      -1
      123.4
      -3.14
      1.0e6
      1.2e-3
      4E20
      4e+20
  ).each do |quoted_float|
    it %{serializes a quoted number ("#{quoted_float}") as a string} do
      actual = marshal 'key' => quoted_float
      expect(actual).to eq(%{key="#{quoted_float}"})
    end
  end

  def marshal(data)
    described_class.new.marshal data
  end
end
