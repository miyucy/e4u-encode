# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe E4U do
  it "encode"
  it "detect"
end

describe E4U do
  before :all do
    @utf8_str_ary = %w(本日は 晴天 なり)
    @sjis_str_ary = @utf8_str_ary.map { |e| NKF.nkf('-Wm0x --oc=CP932', e) }

    @webcode = "\x1B\x24\x47\x6A\x0F"

    @sun = E4U.google.find{ |e| e[:id] == '000' }
  end


  context 'when DoCoMo' do
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
