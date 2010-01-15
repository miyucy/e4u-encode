# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe E4U do
  describe "encode" do
    before :all do
      @utf8_str_ary = %w(本日は 晴天 なり)
      @sjis_str_ary = @utf8_str_ary.map { |e| NKF.nkf("-Wsm0x --oc=CP932", e) }
      @sun = E4U.google.find{ |e| e[:id] == '000' }
      @eid = "[e:%03X]" % [@sun[:id].hex]
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

        it "UTF-8な絵文字IDに変換できること" do
          utf8 = @utf8_str_ary.join @eid
          E4U.encode(@str, :utf8, :docomo => :ketai).should == utf8
        end
      end
    end

    context "Google" do
      context "UTF-8な絵文字" do
        before :all do
          @str = @utf8_str_ary.join @sun.google_emoji.utf8
        end

        it "Unicode数値文字参照に変換できること" do
          unicode = @utf8_str_ary.join "&#x#{@sun.google_emoji.unicode};"
          E4U.encode(@str, :google, :utf8 => :unicode).should == unicode
        end

        it "UTF-8なDoCoMo絵文字に変換できること" do
          utf8 = @utf8_str_ary.join @sun.docomo_emoji.utf8
          E4U.encode(@str, :utf8, :google => :docomo).should == utf8
        end

        it "SJISなDoCoMo絵文字に変換できること" do
          sjis = @sjis_str_ary.join @sun.docomo_emoji.sjis
          E4U.encode(@str, :utf8 => :sjis, :google => :docomo).should == sjis
        end

        it "UTF-8なKDDI絵文字に変換できること" do
          utf8 = @utf8_str_ary.join @sun.kddi_emoji.utf8
          E4U.encode(@str, :utf8, :google => :kddi).should == utf8
        end

        it "SJISなKDDI絵文字に変換できること" do
          sjis = @sjis_str_ary.join @sun.kddi_emoji.sjis
          E4U.encode(@str, :utf8 => :sjis, :google => :kddi).should == sjis
        end

        it "UTF-8なSoftbank絵文字に変換できること" do
          utf8 = @utf8_str_ary.join @sun.softbank_emoji.utf8
          E4U.encode(@str, :utf8, :google => :softbank).should == utf8
        end

        it "SJISなSoftbank絵文字に変換できること" do
          sjis = @sjis_str_ary.join @sun.softbank_emoji.sjis
          E4U.encode(@str, :utf8 => :sjis, :google => :softbank).should == sjis
        end

        it "WebcodeなSoftbank絵文字に変換できること" do
          sjis = @sjis_str_ary.join "\x1B\x24\x47\x6A\x0F"
          E4U.encode(@str, :utf8 => :webcode, :google => :softbank).should == sjis
        end

        it "UTF-8な絵文字IDに変換できること" do
          utf8 = @utf8_str_ary.join @eid
          E4U.encode(@str, :utf8, :google => :ketai).should == utf8
        end
      end

      context "Unicode数値文字参照" do
        before :all do
          @str = @utf8_str_ary.join "&#x#{@sun.google_emoji.unicode};"
        end

        it "UTF-8なGoogle絵文字に変換できること" do
          utf8 = @utf8_str_ary.join @sun.google_emoji.utf8
          E4U.encode(@str, :google, :unicode => :utf8).should == utf8
        end
      end
    end

    context "DoCoMo <=> KDDI" do
      before :all do
        emoji = E4U.google.find{ |e| e[:docomo].nil? != e[:kddi].nil? }
        @docomo = "#{emoji[:name]} #{emoji.docomo_emoji.utf8}"
        @docomo.encode('UTF-8') if RUBY_VERSION >= '1.9.1'
        @kddi   = "#{emoji[:name]} #{emoji.kddi_emoji.utf8}"
        @kddi.encode('UTF-8') if RUBY_VERSION >= '1.9.1'
      end

      it "該当する絵文字がなければ、fallback_textを出力すること" do
        E4U.encode(@kddi, :utf8, :kddi => :docomo).should == @docomo
      end

      it "fallback_textは絵文字に変換しないこと" do
        E4U.encode(@docomo, :utf8, :docomo => :kddi).should_not == @kddi
      end
    end

    context "DoCoMo <=> Softbank" do
      before :all do
        emoji = E4U.google.find{ |e| e[:docomo].nil? != e[:softbank].nil? }
        @docomo = "#{emoji[:name]} #{emoji.docomo_emoji.utf8}"
        @docomo.encode('UTF-8') if RUBY_VERSION >= '1.9.1'
        @softbank = "#{emoji[:name]} #{emoji.softbank_emoji.utf8}"
        @softbank.encode('UTF-8') if RUBY_VERSION >= '1.9.1'
      end

      it "該当する絵文字がなければ、fallback_textを出力すること" do
        E4U.encode(@docomo, :utf8, :docomo => :softbank).should == @softbank
      end

      it "fallback_textは絵文字に変換しないこと" do
        E4U.encode(@softbank, :utf8, :softbank => :docomo).should_not == @docomo
      end
    end

    context "DoCoMoの複合絵文字" do
      it "KDDIに変換できること" do
        emoji = E4U.google.find{ |e| e[:docomo] =~ /\+/ && !e[:kddi].nil? }
        @docomo = "#{emoji[:name]} #{emoji.docomo_emoji.utf8}"
        @docomo.encode('UTF-8') if RUBY_VERSION >= '1.9.1'
        @kddi   = "#{emoji[:name]} #{emoji.kddi_emoji.utf8}"
        @kddi.encode('UTF-8') if RUBY_VERSION >= '1.9.1'

        E4U.encode(@docomo, :utf8, :docomo => :kddi).should == @kddi
        E4U.encode(@kddi, :utf8, :kddi => :docomo).should == @docomo
      end

      it "Softbankに変換できること" do
        emoji = E4U.google.find{ |e| e[:docomo] =~ /\+/ && !e[:softbank].nil? }
        @docomo   = "#{emoji[:name]} #{emoji.docomo_emoji.utf8}"
        @docomo.encode('UTF-8') if RUBY_VERSION >= '1.9.1'
        @softbank = "#{emoji[:name]} #{emoji.softbank_emoji.utf8}"
        @softbank.encode('UTF-8') if RUBY_VERSION >= '1.9.1'

        E4U.encode(@docomo, :utf8, :docomo => :softbank).should == @softbank
        E4U.encode(@softbank, :utf8, :softbank => :docomo).should == @docomo
      end
    end

    context "KDDIの複合絵文字" do
      it "DoCoMoに変換できること" do
        emoji = E4U.google.find{ |e| e[:kddi] =~ /\+/ && !e[:docomo].nil? }
        @kddi   = "#{emoji[:name]} #{emoji.kddi_emoji.utf8}"
        @kddi.encode('UTF-8') if RUBY_VERSION >= '1.9.1'
        @docomo = "#{emoji[:name]} #{emoji.docomo_emoji.utf8}"
        @docomo.encode('UTF-8') if RUBY_VERSION >= '1.9.1'

        E4U.encode(@kddi, :utf8, :kddi => :docomo).should == @docomo
        E4U.encode(@docomo, :utf8, :docomo => :kddi).should == @kddi
      end

      it "Softbankに変換できること" do
        emoji = E4U.google.find{ |e| e[:kddi] =~ /\+/ && !e[:softbank].nil? }
        @kddi     = "#{emoji[:name]} #{emoji.kddi_emoji.utf8}"
        @kddi.encode('UTF-8') if RUBY_VERSION >= '1.9.1'
        @softbank = "#{emoji[:name]} #{emoji.softbank_emoji.utf8}"
        @softbank.encode('UTF-8') if RUBY_VERSION >= '1.9.1'

        E4U.encode(@kddi, :utf8, :kddi => :softbank).should == @softbank
        E4U.encode(@softbank, :utf8, :softbank => :kddi).should == @kddi
      end
    end

    context "Softbankの複合絵文字" do
      it "DoCoMoに変換できること" do
        emoji = E4U.google.find{ |e| e[:softbank] =~ /\+/ && !e[:docomo].nil? }
        @softbank = "#{emoji[:name]} #{emoji.softbank_emoji.utf8}"
        @softbank.encode('UTF-8') if RUBY_VERSION >= '1.9.1'
        @docomo   = "#{emoji[:name]} #{emoji.docomo_emoji.utf8}"
        @docomo.encode('UTF-8') if RUBY_VERSION >= '1.9.1'

        E4U.encode(@softbank, :utf8, :softbank => :docomo).should == @docomo
        E4U.encode(@docomo, :utf8, :docomo => :softbank).should == @softbank
      end

      it "KDDIに変換できること" do
        emoji = E4U.google.find{ |e| e[:softbank] =~ /\+/ && !e[:kddi].nil? }
        @softbank = "#{emoji[:name]} #{emoji.softbank_emoji.utf8}"
        @softbank.encode('UTF-8') if RUBY_VERSION >= '1.9.1'
        @kddi     = "#{emoji[:name]} #{emoji.kddi_emoji.utf8}"
        @kddi.encode('UTF-8') if RUBY_VERSION >= '1.9.1'

        E4U.encode(@softbank, :utf8, :softbank => :kddi).should == @kddi
        E4U.encode(@kddi, :utf8, :kddi => :softbank).should == @softbank
      end
    end
  end

  it "detect"
end
