require 'e4u/encode/encoding'
require 'e4u/encode/docomo'
require 'e4u/encode/google'
require 'e4u/encode/kddi'
require 'e4u/encode/softbank'

module E4U
  def self.encode str, *args
    Encode.convert str, *args
  end

  module Encode
    def self.convert str, *args
      return nil unless str
      return str if args.size == 0
      raise ArgumentError if args.size > 2
      from, to = parse_options(*args)
      convert_(str, from, to)
    end

    private

    CARRIERS = [:docomo, :kddi, :softbank, :google,].freeze
    ENCODINGS = [:sjis, :utf8, :unicode, :webcode].freeze

    def self.parse_options *args
      raise ArgumentError unless (1..2).include? args.size

      option = args.first
      if args.size > 1
        lonely_option = option.is_a?(::Hash) ? args.pop : args.shift
        option = args.first.update(lonely_option => lonely_option)
      end

      from, to = {}, {}

      option.each do |k, v|
        if CARRIERS.include?(k)
          from[:carrier] = k
          to[:carrier] = v
          next
        end
        if ENCODINGS.include?(k)
          from[:encoding] = k
          to[:encoding] = v
          next
        end
        raise ArgumentError
      end

      [from, to]
    end

    def self.convert_ str, from, to
      return str if from == to
      str = str.dup
      case from[:carrier]
      when :docomo
        str = DoCoMo.encode(str, from, to)
      when :google
        str = Google.encode(str, from, to)
      when :kddi
        str = KDDI.encode(str, from, to)
      when :softbank
        str = Softbank.encode(str, from, to)
      else
        raise
      end
      convert_(str, from, to)
    end
  end
end
