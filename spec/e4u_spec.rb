# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe E4U do
  describe "encode" do
    before :all do
      @utf8_str_ary = %w(本日は 晴天 なり)
      @sjis_str_ary = @utf8_str_ary.map { |e| NKF.nkf('-Wm0x --oc=CP932', e) }
      @sun = E4U.google.find{ |e| e[:id] == '000' }
    end

    context "DoCoMo" do
      context "SJISな絵文字" do
        before :all do
          @str = @sjis_str_ary.join @sun.docomo_emoji.sjis
        end

        it "UTF-8な絵文字に変換できること" do
          utf8 = @utf8_str_ary.join @sun.docomo_emoji.utf8
          E4U.encode(@str, :docomo, :sjis => :utf8).should == utf8
        end

        it "Unicode数値文字参照に変換できること" do
          utf8 = @utf8_str_ary.join "&#x#{@sun.docomo_emoji.unicode};"
          E4U.encode(@str, :docomo, :sjis => :unicode).should == utf8
        end
      end

      context "UTF-8な絵文字" do
        before :all do
          @str = @utf8_str_ary.join @sun.docomo_emoji.utf8
        end

        it "SJISな絵文字に変換できること" do
          sjis = @sjis_str_ary.join @sun.docomo_emoji.sjis
          E4U.encode(@str, :docomo, :utf8 => :sjis).should == sjis
        end

        it "Unicode数値文字参照に変換できること" do
          unicode = @utf8_str_ary.join "&#x#{@sun.docomo_emoji.unicode};"
          E4U.encode(@str, :docomo, :utf8 => :unicode).should == unicode
        end

        it "UTF-8なKDDI絵文字に変換できること" do
          utf8 = @utf8_str_ary.join @sun.kddi_emoji.utf8
          E4U.encode(@str, :utf8, :docomo => :kddi).should == utf8
        end

        it "SJISなKDDI絵文字に変換できること" do
          sjis = @sjis_str_ary.join @sun.kddi_emoji.sjis
          E4U.encode(@str, :utf8 => :sjis, :docomo => :kddi).should == sjis
        end

        it "UTF-8なSoftbank絵文字に変換できること" do
          utf8 = @utf8_str_ary.join @sun.softbank_emoji.utf8
          E4U.encode(@str, :utf8, :docomo => :softbank).should == utf8
        end

        it "SJISなSoftbank絵文字に変換できること" do
          sjis = @sjis_str_ary.join @sun.softbank_emoji.sjis
          E4U.encode(@str, :utf8 => :sjis, :docomo => :softbank).should == sjis
        end

        it "WebcodeなSoftbank絵文字に変換できること" do
          sjis = @sjis_str_ary.join "\x1B\x24\x47\x6A\x0F"
          E4U.encode(@str, :utf8 => :webcode, :docomo => :softbank).should == sjis
        end

        it "UTF-8なGoogle絵文字に変換できること" do
          utf8 = @utf8_str_ary.join @sun.google_emoji.utf8
          E4U.encode(@str, :utf8, :docomo => :google).should == utf8
        end
      end
    end

    context "Google" do
      context "UTF-8な絵文字" do
        it "Unicode数値文字参照に変換できること"

        it "UTF-8なDoCoMo絵文字に変換できること"
        it "SJISなDoCoMo絵文字に変換できること"

        it "UTF-8なKDDI絵文字に変換できること"
        it "SJISなKDDI絵文字に変換できること"

        it "UTF-8なSoftbank絵文字に変換できること"
        it "SJISなSoftbank絵文字に変換できること"
        it "WebcodeなSoftbank絵文字に変換できること"
      end

      context "Unicode数値文字参照" do
        it "UTF-8なGoogle絵文字に変換できること"
      end
    end
  end

  it "detect"
end
