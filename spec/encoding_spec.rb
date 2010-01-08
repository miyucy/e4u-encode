# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe E4U::Encode::Encoding do
  context "to_utf8" do
    it "SJIS文字列がUTF-8に変換されること" do
      utf8 = 'SJISな文字列'
      if RUBY_VERSION < '1.9.1'
        str = NKF.nkf('-Wsm0x', utf8)
        #NKF.should_receive(:nkf).once.with('-Swm0x', string)
      else
        str = mock.should_receive(:encoding).once.with('UTF-8')
      end
      E4U::Encode::Encoding.to_utf8(str).should == utf8
    end
  end

  context "to_cp932" do
    if RUBY_VERSION < '1.9.1'
      it "UTF-8文字列がSJISに変換されること" do
        utf8 = 'UTF-8な文字列'
        sjis = NKF.nkf('-Wsm0x', utf8)
        E4U::Encode::Encoding.to_cp932(utf8).should == sjis
      end
    else
      it "UTF-8文字列がCP932に変換されること" do
        str = mock.should_receive(:encoding).once.with('CP932')
        E4U::Encode::Encoding.to_utf8(str)
      end
    end
  end
end
