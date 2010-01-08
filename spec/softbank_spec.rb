# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe E4U::Encode::Softbank do

  describe "encode" do
    before :all do
      @from, @to = {}, {}
    end

    it "from[:carrier]が:softbank以外ならば例外が起こる" do
      @from.update :carrier => :not_softbank
      lambda {
        E4U::Encode::Softbank.encode('', @from, @to)
      }.should raise_error
    end

    context "to[:carrier]が:softbank以外の時" do
      before :all do
        @to.update :carrier => :not_softbank
      end

      before :each do
        @from.update :carrier => :softbank
      end

      it "from[:encoding]が:utf8なら :unicodeに変換される" do
        @from.update :encoding => :utf8
        lambda {
          E4U::Encode::Softbank.encode('', @from, @to)
        }.should change { @from[:encoding] }.from(:utf8).to(:unicode)
      end

      it "from[:encoding]が:sjisなら :unicodeに変換される" do
        @from.update :encoding => :sjis
        lambda {
          E4U::Encode::Softbank.encode('', @from, @to)
        }.should change { @from[:encoding] }.from(:sjis).to(:unicode)
      end

      it "from[:encoding]が:unicodeなら from[:carrier]が:googleに変換される" do
        @from.update :encoding => :unicode
        lambda {
          E4U::Encode::Softbank.encode('', @from, @to)
        }.should change { @from[:carrier] }.from(:softbank).to(:google)
      end
    end

    context "to[:carrier]が:softbankの時" do
      before :all do
        @to.update :carrier => :softbank
      end

      before :each do
        @from.update :carrier => :softbank
      end

      it "from[:encoding]が:sjisならば、:unicodeに変換される" do
        @from.update :encoding => :sjis
        lambda {
          E4U::Encode::Softbank.encode('', @from, @to)
        }.should change { @from[:encoding] }.from(:sjis).to(:unicode)
      end

      it "from[:encoding]が:utf8ならば、:unicodeに変換される" do
        @from.update :encoding => :utf8
        lambda {
          E4U::Encode::Softbank.encode('', @from, @to)
        }.should change { @from[:encoding] }.from(:utf8).to(:unicode)
      end

      context "from[:encoding]が:unicodeの時" do
        before :each do
          @from.update :encoding => :unicode
        end

        it "to[:encoding]が:sjisならば、from[:encoding]も:sjisになる" do
          @to.update :encoding => :sjis
          lambda {
            E4U::Encode::Softbank.encode('', @from, @to)
          }.should change { @from[:encoding] }.from(:unicode).to(:sjis)
        end

        it "to[:encoding]が:utf8ならば、from[:encoding]も:utf8になる" do
          @to.update :encoding => :utf8
          lambda {
            E4U::Encode::Softbank.encode('', @from, @to)
          }.should change { @from[:encoding] }.from(:unicode).to(:utf8)
        end

        it "to[:encoding]が:webcodeならば、from[:encoding]も:webcodeになる" do
          @to.update :encoding => :webcode
          lambda {
            E4U::Encode::Softbank.encode('', @from, @to)
          }.should change { @from[:encoding] }.from(:unicode).to(:webcode)
        end

        it "to[:encoding]が:sjis、:utf8、:webcode以外ならば、例外が起こる" do
          @to.update :encoding => :other_encoding
          lambda {
            E4U::Encode::Softbank.encode('', @from, @to)
          }.should raise_error
        end

        it "to[:encoding]が:sjisならば、CP932な文字列が返ってくる" do
          pending "only RUBY_VERSION >= '1.9.1'" unless RUBY_VERSION >= '1.9.1'
          str = "とある文字列の符号化方式＜エンコーディング＞"
          @to.update :encoding => :sjis
          lambda {
            E4U::Encode::Softbank.encode(str, @from, @to)
          }.should change(str, :encoding).from('UTF-8').to('CP932')
        end

        it "to[:encoding]が:webcodeならば、CP932な文字列が返ってくる" do
          pending "only RUBY_VERSION >= '1.9.1'" unless RUBY_VERSION >= '1.9.1'
          str = "とある文字列の符号化方式＜エンコーディング＞"
          @to.update :encoding => :sjis
          lambda {
            E4U::Encode::Softbank.encode(str, @from, @to)
          }.should change(str, :encoding).from('UTF-8').to('CP932')
        end

        it "to[:encoding]が:utf8ならば、UTF-8な文字列が返ってくる" do
          pending "only RUBY_VERSION >= '1.9.1'" unless RUBY_VERSION >= '1.9.1'
          str = "とある文字列の符号化方式＜エンコーディング＞"
          @to.update :encoding => :utf8
          lambda {
            E4U::Encode::Softbank.encode(str, @from, @to)
          }.should change(str, :encoding).from('UTF-8').to('UTF-8')
        end

        it "to[:encoding]が:unicodeならば、UTF-8な文字列が返ってくる" do
          pending "only RUBY_VERSION >= '1.9.1'" unless RUBY_VERSION >= '1.9.1'
          str = "とある文字列の符号化方式＜エンコーディング＞"
          @to.update :encoding => :utf8
          lambda {
            E4U::Encode::Softbank.encode(str, @from, @to)
          }.should change(str, :encoding).from('UTF-8').to('UTF-8')
        end
      end
    end
  end
end
