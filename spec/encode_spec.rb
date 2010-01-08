# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe E4U::Encode do
  context "convert" do
    it "引数なしの場合は文字列がそのまま返る" do
      str = ''
      E4U::Encode.convert(str).should eql(str)
    end

    it "nilを渡したらnilが返る" do
      E4U::Encode.convert(nil).should be_nil
    end

    it "引数が多い場合はArgumentErrorが発生する" do
      lambda{
        E4U::Encode.convert('', :docomo, :sjis => :sjis)
      }.should_not raise_error

      lambda{
        E4U::Encode.convert('', :docomo, {:sjis => :sjis}, 'arg3')
      }.should raise_error ArgumentError
    end

    it "キャリアとエンコーディングが明示されないとArgumentErrorが発生する" do
      lambda{
        E4U::Encode.convert('', :docomo => :google)
      }.should raise_error ArgumentError

      lambda{
        E4U::Encode.convert('', :sjis => :utf8)
      }.should raise_error ArgumentError
    end

    it "NoMethodErrorではなくArgumentErrorが発生すること" do
      lambda{
        E4U::Encode.convert('', :docomo)
      }.should_not raise_error NoMethodError

      lambda{
        E4U::Encode.convert('', :docomo)
      }.should raise_error ArgumentError

      lambda{
        E4U::Encode.convert('', :sjis)
      }.should_not raise_error NoMethodError

      lambda{
        E4U::Encode.convert('', :sjis)
      }.should raise_error ArgumentError
    end

    it "非対応なキャリアを渡すとArgumentErrorが発生する" do
      lambda{
        E4U::Encode.convert('', :emobile, :sjis => :sjis)
      }.should raise_error ArgumentError
    end

    it "非対応なエンコーディングを渡すとArgumentErrorが発生する" do
      lambda{
        E4U::Encode.convert('', :euc_jp, :docomo => :docomo)
      }.should raise_error ArgumentError
    end

    it "存在しないキャリアとエンコーディングの組み合わせを渡してもArgumentErrorは発生しない" do
      lambda{
        # google-sjisは存在しない
        E4U::Encode.convert('', :docomo => :google, :utf8 => :sjis)
      }.should_not raise_error ArgumentError

      # 変換できないのでRuntimeErrorは起こる
      lambda{
        E4U::Encode.convert('', :docomo => :google, :utf8 => :sjis)
      }.should raise_error RuntimeError
    end

  end
end
