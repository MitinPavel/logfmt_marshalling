module LogfmtMarshalling
  class Marshaller
    def marshal(hash)
      hash.inject([]) do |acc, (key, value)|
        case value
          when TrueClass then acc << marshal_key(key)
          else                acc << [marshal_key(key), marshal_value(value)].join('=')
        end
        acc
      end.join ' '
    end

    private

    def marshal_key(key)
      key.to_s
    end

    def marshal_value(value)
      case value
        when String then marshal_string_value value
        else             value.to_s
      end
    end

    def marshal_string_value(value)
      wrap_in_quotes escapes_double_quotes(value)
    end

    def escapes_double_quotes(value)
      value.gsub '[^\]"', '\"'
    end

    def wrap_in_quotes(value)
      if value.match(/\\|\s/) || value == ''
        %{"#{value}"}
      else
        value
      end
    end
  end
end
