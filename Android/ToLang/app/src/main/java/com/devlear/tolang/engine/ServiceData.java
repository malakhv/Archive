package com.devlear.tolang.engine;

public class ServiceData {
    private String mOriginal = null;
    private String mTranslation = null;
    private String mLangTo = null;
    private String mLangFrom = null;

    public ServiceData() {

    }

    public String getOriginalText() {
        return mOriginal;
    }

    public void setOriginalText(String text) {
        mOriginal = text;
    }

    public String getTranslation() {
        return mTranslation;
    }

    public void setTranslation(String text) {
        mTranslation = text;
    }

    public String getLangFrom() {
        return mLangFrom;
    }

    public void setLangFrom(String lang) {
        mLangFrom = lang;
    }

    public String getLangTo() {
        return mLangTo;
    }

    public void setLangTo(String lang) {
        mLangTo = lang;
    }

    public void obtain(ServiceData origin) {
        if (origin == null) return;
        mOriginal = origin.mOriginal;
        mTranslation = origin.mTranslation;
        mLangFrom = origin.mLangFrom;
        mLangTo = origin.mLangTo;
    }


    public void clear() {}


}
