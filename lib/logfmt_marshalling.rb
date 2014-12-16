require "logfmt_marshalling/version"
require "logfmt_marshalling/marshaller"

module LogfmtMarshalling
  def self.marshal(hash)
    marshaller = ::LogfmtMarshalling::Marshaller.new

    marshaller.marshal hash
  end
end
