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

      it "from[:encoding]が:utf8なら :unicodeに変換される" do
        @from.update :encoding => :utf8
        lambda {
          E4U::Encode::DoCoMo.encode('', @from, @to)
        }.should change { @from[:encoding] }.from(:utf8).to(:unicode)
      end

      it "from[:encoding]が:sjisなら :unicodeに変換される" do
        @from.update :encoding => :sjis
        lambda {
          E4U::Encode::DoCoMo.encode('', @from, @to)
        }.should change { @from[:encoding] }.from(:sjis).to(:unicode)
      end

      it "from[:encoding]が:unicodeなら from[:carrier]が:googleに変換される" do
        @from.update :encoding => :unicode
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

      it "from[:encoding]が:sjisならば、:unicodeに変換される" do
        @from.update :encoding => :sjis
        lambda {
          E4U::Encode::DoCoMo.encode('', @from, @to)
        }.should change { @from[:encoding] }.from(:sjis).to(:unicode)
      end

      it "from[:encoding]が:utf8ならば、:unicodeに変換される" do
        @from.update :encoding => :utf8
        lambda {
          E4U::Encode::DoCoMo.encode('', @from, @to)
        }.should change { @from[:encoding] }.from(:utf8).to(:unicode)
      end

      context "from[:encoding]が:unicodeの時" do
        before :each do
          @from.update :encoding => :unicode
        end

        it "to[:encoding]が:sjisならば、from[:encoding]も:sjisになる" do
          @to.update :encoding => :sjis
          lambda {
            E4U::Encode::DoCoMo.encode('', @from, @to)
          }.should change { @from[:encoding] }.from(:unicode).to(:sjis)
        end

        it "to[:encoding]が:utf8ならば、from[:encoding]も:utf8になる" do
          @to.update :encoding => :utf8
          lambda {
            E4U::Encode::DoCoMo.encode('', @from, @to)
          }.should change { @from[:encoding] }.from(:unicode).to(:utf8)
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
          lambda {
            E4U::Encode::DoCoMo.encode(str, @from, @to)
          }.should change(str, :encoding).from('UTF-8').to('CP932')
        end

        it "to[:encoding]が:utf8ならば、UTF-8な文字列が返ってくる" do
          pending "only RUBY_VERSION >= '1.9.1'" unless RUBY_VERSION >= '1.9.1'
          str = "とある文字列の符号化方式＜エンコーディング＞"
          @to.update :encoding => :utf8
          lambda {
            E4U::Encode::DoCoMo.encode(str, @from, @to)
          }.should change(str, :encoding).from('UTF-8').to('UTF-8')
        end

        it "to[:encoding]が:unicodeならば、UTF-8な文字列が返ってくる" do
          pending "only RUBY_VERSION >= '1.9.1'" unless RUBY_VERSION >= '1.9.1'
          str = "とある文字列の符号化方式＜エンコーディング＞"
          @to.update :encoding => :utf8
          lambda {
            E4U::Encode::DoCoMo.encode(str, @from, @to)
          }.should change(str, :encoding).from('UTF-8').to('UTF-8')
        end
      end
    end
  end
end


describe E4U do
describe E4U::Encode do

describe E4U::Encode::DoCoMo do
  before :all do
    @utf8_str_ary = %w(本日は 晴天 なり)
    @sjis_str_ary = @utf8_str_ary.map { |e| NKF.nkf('-Wm0x --oc=CP932', e) }

    @webcode = "\x1B\x24\x47\x6A\x0F"

    @sun = E4U.google.find{ |e| e[:id] == '000' }
  end

  it "SJISなDoCoMo絵文字を、UTF-8なDoCoMo絵文字に変換できること" do
    sjis = @sjis_str_ary.join @sun.docomo_emoji.sjis
    utf8 = @utf8_str_ary.join @sun.docomo_emoji.utf8

    got = E4U.encode(sjis, :docomo, :sjis => :utf8)
    got.should == utf8
  end

  it "SJISなDoCoMo絵文字を、UTF-8な数値文字参照に変換できること" do
    sjis = @sjis_str_ary.join @sun.docomo_emoji.sjis
    utf8 = @utf8_str_ary.join "&#x#{@sun.docomo_emoji.unicode};"

    got = E4U.encode(sjis, :docomo, :sjis => :unicode)
    got.should == utf8
  end

  it "UTF-8なDoCoMo絵文字を、SJISなDoCoMo絵文字に変換できること" do
    sjis = @sjis_str_ary.join @sun.docomo_emoji.sjis
    utf8 = @utf8_str_ary.join @sun.docomo_emoji.utf8

    got = E4U.encode(utf8, :docomo, :utf8 => :sjis)
    got.should == sjis
  end

  it "SJISなDoCoMo絵文字を、UTF-8なKDDI絵文字に変換できること" do
    sjis = @sjis_str_ary.join @sun.docomo_emoji.sjis
    utf8 = @utf8_str_ary.join @sun.kddi_emoji.utf8

    got = E4U.encode(sjis, :docomo => :kddi, :sjis => :utf8)
    got.should == utf8
  end

  it "SJISなDoCoMo絵文字を、SJISなKDDI絵文字に変換できること" do
    sjis = @sjis_str_ary.join @sun.docomo_emoji.sjis
    kddi = @sjis_str_ary.join @sun.kddi_emoji.sjis

    got = E4U.encode(sjis, :sjis, :docomo => :kddi)
    got.should == kddi
  end

  it "SJISなDoCoMo絵文字を、SJISなSoftbank絵文字に変換できること" do
    sjis = @sjis_str_ary.join @sun.docomo_emoji.sjis
    softbank = @sjis_str_ary.join @sun.softbank_emoji.sjis

    got = E4U.encode(sjis, :sjis, :docomo => :softbank)
    got.should == softbank
  end

  it "SJISなDoCoMo絵文字を、WebcodeなSoftbank絵文字に変換できること" do
    sjis = @sjis_str_ary.join @sun.docomo_emoji.sjis
    softbank = @sjis_str_ary.join @webcode

    got = E4U.encode(sjis, :sjis => :webcode, :docomo => :softbank)
    got.should == softbank
  end

  it "SJISなDoCoMo絵文字を、UTF-8なSoftbank絵文字に変換できること" do
    sjis = @sjis_str_ary.join @sun.docomo_emoji.sjis
    softbank = @utf8_str_ary.join @sun.softbank_emoji.utf8

    got = E4U.encode(sjis, :sjis => :utf8, :docomo => :softbank)
    got.should == softbank
  end

  it "SJISなDoCoMo絵文字を、UTF-8なGoogle絵文字に変換できること" do
    sjis = @sjis_str_ary.join @sun.docomo_emoji.sjis
    google = @utf8_str_ary.join @sun.google_emoji.utf8

    got = E4U.encode(sjis, :sjis => :utf8, :docomo => :google)
    got.should == google
  end

  it "UTF-8なDoCoMo絵文字を、UTF-8なGoogle絵文字に変換できること" do
    utf8 = @utf8_str_ary.join @sun.docomo_emoji.utf8
    google = @utf8_str_ary.join @sun.google_emoji.utf8

    got = E4U.encode(utf8, :utf8, :docomo => :google)
    got.should == google
  end
end
end
end
