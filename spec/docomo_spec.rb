# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe E4U::Encode::DoCoMo do

  describe "encode" do
    before :all do
      @from, @to = {}, {}
    end

    it "from[:carrier]が:docomo以外ならば例外が起こる" do
      @from.update :carrier => :not_docomo
      lambda {
        E4U::Encode::DoCoMo.encode('', @from, @to)
      }.should raise_error
    end

    context "to[:carrier]が:docomo以外の時" do
      before :all do
        @to.update :carrier => :not_docomo
      end

      before :each do
        @from.update :carrier => :docomo
      end

      it "from[:encoding]が:utf8なら :ncrに変換される" do
        @from.update :encoding => :utf8
        lambda {
          E4U::Encode::DoCoMo.encode('', @from, @to)
        }.should change { @from[:encoding] }.from(:utf8).to(:ncr)
      end

      it "from[:encoding]が:sjisなら :ncrに変換される" do
        @from.update :encoding => :sjis
        lambda {
          E4U::Encode::DoCoMo.encode('', @from, @to)
        }.should change { @from[:encoding] }.from(:sjis).to(:ncr)
      end

      it "from[:encoding]が:ncrなら from[:carrier]が:googleに変換される" do
        @from.update :encoding => :ncr
        lambda {
          E4U::Encode::DoCoMo.encode('', @from, @to)
        }.should change { @from[:carrier] }.from(:docomo).to(:google)
      end
    end

    context "to[:carrier]が:docomoの時" do
      before :all do
        @to.update :carrier => :docomo
      end

      before :each do
        @from.update :carrier => :docomo
      end

      it "from[:encoding]が:sjisならば、:ncrに変換される" do
        @from.update :encoding => :sjis
        lambda {
          E4U::Encode::DoCoMo.encode('', @from, @to)
        }.should change { @from[:encoding] }.from(:sjis).to(:ncr)
      end

      it "from[:encoding]が:utf8ならば、:ncrに変換される" do
        @from.update :encoding => :utf8
        lambda {
          E4U::Encode::DoCoMo.encode('', @from, @to)
        }.should change { @from[:encoding] }.from(:utf8).to(:ncr)
      end

      context "from[:encoding]が:ncrの時" do
        before :each do
          @from.update :encoding => :ncr
        end

        it "to[:encoding]が:sjisならば、from[:encoding]も:sjisになる" do
          @to.update :encoding => :sjis
          lambda {
            E4U::Encode::DoCoMo.encode('', @from, @to)
          }.should change { @from[:encoding] }.from(:ncr).to(:sjis)
        end

        it "to[:encoding]が:utf8ならば、from[:encoding]も:utf8になる" do
          @to.update :encoding => :utf8
          lambda {
            E4U::Encode::DoCoMo.encode('', @from, @to)
          }.should change { @from[:encoding] }.from(:ncr).to(:utf8)
        end

        it "to[:encoding]が:sjis、:utf8以外ならば、例外が起こる" do
          @to.update :encoding => :other_encoding
          lambda {
            E4U::Encode::DoCoMo.encode('', @from, @to)
          }.should raise_error
        end

        it "to[:encoding]が:sjisならば、CP932な文字列が返ってくる" do
          pending "only RUBY_VERSION >= '1.9.1'" unless RUBY_VERSION >= '1.9.1'
          str = "とある文字列の符号化方式＜エンコーディング＞"
          @to.update :encoding => :sjis
          E4U::Encode::DoCoMo.encode(str, @from, @to).encoding.should == Encoding::Windows_31J
          # うまく動かない…
          # lambda {
          #   E4U::Encode::DoCoMo.encode(str, @from, @to)
          # }.should change(str, :encoding).from(Encoding::UTF_8).to(Encoding::Windows_31J)
        end

        it "to[:encoding]が:utf8ならば、UTF-8な文字列が返ってくる" do
          pending "only RUBY_VERSION >= '1.9.1'" unless RUBY_VERSION >= '1.9.1'
          str = "とある文字列の符号化方式＜エンコーディング＞"
          @to.update :encoding => :utf8
          E4U::Encode::DoCoMo.encode(str, @from, @to).encoding.should == Encoding::UTF_8
          # lambda {
          #   E4U::Encode::DoCoMo.encode(str, @from, @to)
          # }.should change(str, :encoding).from(Encoding::UTF_8).to(Encoding::UTF_8)
          # # => encoding should have been changed to #<Encoding:UTF-8>, but is now #<Encoding:UTF-8>
        end

        it "to[:encoding]が:ncrならば、UTF-8な文字列が返ってくる" do
          pending "only RUBY_VERSION >= '1.9.1'" unless RUBY_VERSION >= '1.9.1'
          str = "とある文字列の符号化方式＜エンコーディング＞"
          @to.update :encoding => :utf8
          E4U::Encode::DoCoMo.encode(str, @from, @to).encoding.should == Encoding::UTF_8
          # lambda {
          #   E4U::Encode::DoCoMo.encode(str, @from, @to)
          # }.should change(str, :encoding).from(Encoding::UTF_8).to(Encoding::UTF_8)
          # # => encoding should have been changed to #<Encoding:UTF-8>, but is now #<Encoding:UTF-8>
        end
      end
    end
  end
end
