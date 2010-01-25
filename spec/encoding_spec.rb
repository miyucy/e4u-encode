# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe E4U::Encode::Encoding do
  context "to_utf8" do
    if RUBY_VERSION < '1.9.1'
      it "SJIS文字列がUTF-8に変換されること" do
        utf8 = "とある文字列の符号化方式＜エンコーディング＞"
        sjis = NKF.nkf('-m0sW --ic=UTF-8 --oc=CP932', utf8)
        NKF.should_receive(:nkf).once.with('-m0Sw --ic=CP932 --oc=UTF-8', sjis).and_return(utf8)
        E4U::Encode::Encoding.to_utf8(sjis)
      end
    else
      it "SJIS文字列がUTF-8に変換されること" do
        sjis = "とある文字列の符号化方式＜エンコーディング＞".encode('SJIS')
        utf8 = sjis.dup.encode('UTF-8')
        sjis.should_receive(:encode).once.with('UTF-8').and_return(utf8)
        E4U::Encode::Encoding.to_utf8(sjis)
      end

      it "CP932文字列がUTF-8に変換されること" do
        sjis = "とある文字列の符号化方式＜エンコーディング＞".encode('CP932')
        utf8 = sjis.dup.encode('UTF-8')
        sjis.should_receive(:encode).once.with('UTF-8').and_return(utf8)
        E4U::Encode::Encoding.to_utf8(sjis)
      end
    end
  end

  context "to_cp932" do
    if RUBY_VERSION < '1.9.1'
      it "UTF-8文字列がSJISに変換されること" do
        utf8 = "とある文字列の符号化方式＜エンコーディング＞"
        sjis = NKF.nkf('-m0sW --ic=UTF-8 --oc=CP932', utf8)
        NKF.should_receive(:nkf).once.with('-m0sW --ic=UTF-8 --oc=CP932', utf8).and_return(sjis)
        E4U::Encode::Encoding.to_cp932(utf8)
      end
    else
      it "UTF-8文字列がCP932に変換されること" do
        utf8 = "とある文字列の符号化方式＜エンコーディング＞"
        sjis = utf8.dup.encode('CP932')
        utf8.should_receive(:encode).once.with('CP932').and_return(sjis)
        E4U::Encode::Encoding.to_cp932(utf8)
      end
    end
  end
end
