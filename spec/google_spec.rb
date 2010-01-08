# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe E4U::Encode::Google do
  context "encode" do
    before :all do
      @from, @to = {}, {}
    end

    it "from[:carrier]が:google以外なら 例外が起こる" do
      @from.update :carrier => :not_google
      lambda {
        E4U::Encode::Google.encode('', @from, @to)
      }.should raise_error
    end

    it "from[:encoding]が:utf8、:unicode以外なら 例外が起こる" do
      @from.update :carrier => :google, :encoding => :euc_jp
      lambda {
        E4U::Encode::Google.encode('', @from, @to)
      }.should raise_error
    end

    it "from[:encoding]が:utf8なら :unicodeに変換される" do
      @from.update :carrier => :google, :encoding => :utf8
      lambda {
        E4U::Encode::Google.encode('', @from, @to)
      }.should change{ @from[:encoding] }.from(:utf8).to(:unicode)
    end

    context "from[:encoding]が:unicodeの時" do
      before :all do
        @from.update :encoding => :unicode
      end

      before :each do
        @from.update :carrier => :google
      end

      it "to[:carrier]が:docomoならば、from[:carrier]も:docomoになる" do
        @to.update :carrier => :docomo
        lambda {
          E4U::Encode::Google.encode('', @from, @to)
        }.should change{ @from[:carrier] }.from(:google).to(:docomo)
      end

      it "to[:carrier]が:kddiならば、from[:carrier]も:kddiになる" do
        @to.update :carrier => :kddi
        lambda {
          E4U::Encode::Google.encode('', @from, @to)
        }.should change{ @from[:carrier] }.from(:google).to(:kddi)
      end

      it "to[:carrier]が:softbankならば、from[:carrier]も:softbankになる" do
        @to.update :carrier => :softbank
        lambda {
          E4U::Encode::Google.encode('', @from, @to)
        }.should change{ @from[:carrier] }.from(:google).to(:softbank)
      end

      context "to[:carrier]が:googleの時" do
        before :all do
          @to.update :carrier => :google
        end

        before :each do
          @from.update :encoding => :unicode
        end

        it "to[:encoding]が:utf8ならば、from[:encoding]も:utf8になる" do
          @to.update :encoding => :utf8
          lambda {
            E4U::Encode::Google.encode('', @from, @to)
          }.should change{ @from[:encoding] }.from(:unicode).to(:utf8)
        end

        it "to[:encoding]が:utf8以外ならば例外が起こる" do
          @to.update :carrier => :unicode
          lambda {
            E4U::Encode::Google.encode('', @from, @to)
          }.should raise_error
        end
      end
    end
  end
end
