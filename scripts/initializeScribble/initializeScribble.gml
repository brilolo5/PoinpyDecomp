function initializeScribble()
{
    if (!variable_global_exists("__scribble_loaded"))
    {
        global.__scribble_loaded = true;
        scribble_glyph_set("sMSDF_Arabic", -3, UnknownEnum.Value_5, 12, true);
        scribble_font_collage_create("fontArabic");
        scribble_font_collage_glyph_copy_all("fontArabic", "sMSDF_Arabic", true);
        scribble_font_collage_glyph_copy("fontArabic", "sMSDF_fredokaOne", false, [33, 191]);
        scribble_font_rename("sMSDF_default", "default");
        scribble_font_rename("sMSDF_fredokaOne", "fredoka");
        scribble_font_rename("sMSDF_Japanese", "fontJapanese");
        scribble_font_rename("sMSDF_ChineseS", "fontChineseS");
        scribble_font_rename("sMSDF_ChineseT", "fontChineseT");
        scribble_font_rename("sMSDF_Korean", "fontKorean");
        scribble_font_rename("sMSDF_Russian", "fontRussian");
        scribble_font_rename("sMSDF_Thai", "fontThai");
        scribble_font_rename("sMSDF_Turkish", "fontTurkish");
        scribble_font_rename("sMSDF_Swedish", "fontSwedish");
        scribble_font_rename("sMSDF_Polish", "fontPolish");
        scribble_glyph_set("fontJapanese", " ", UnknownEnum.Value_3, -34, true);
        scribble_glyph_set("fontArabic", " ", UnknownEnum.Value_3, -16, true);
        scribble_font_scale("default", 0.5, 0.5);
        scribble_font_scale("fredoka", 0.5, 0.5);
        scribble_font_scale("fontJapanese", 0.5, 0.5);
        scribble_font_scale("fontChineseS", 0.5, 0.5);
        scribble_font_scale("fontChineseT", 0.5, 0.5);
        scribble_font_scale("fontKorean", 0.5, 0.5);
        scribble_font_scale("fontRussian", 0.5, 0.5);
        scribble_font_scale("fontArabic", 0.5, 0.5);
        scribble_font_scale("fontThai", 0.5, 0.5);
        var _nunitoBlackSize = 44;
        scribble_font_scale("fontTurkish", 22 / _nunitoBlackSize, 22 / _nunitoBlackSize);
        scribble_font_scale("fontSwedish", 22 / _nunitoBlackSize, 22 / _nunitoBlackSize);
        scribble_font_scale("fontPolish", 22 / _nunitoBlackSize, 22 / _nunitoBlackSize);
        scribble_glyph_set("default", "m", UnknownEnum.Value_6, 1, true);
        scribble_glyph_set("default", "v", UnknownEnum.Value_6, 2, true);
        scribble_glyph_set("default", "B", UnknownEnum.Value_6, 1, true);
        scribble_glyph_set("default", "P", UnknownEnum.Value_6, 2, true);
        scribble_glyph_set("default", "R", UnknownEnum.Value_6, 1, true);
        scribble_glyph_set("default", -3, UnknownEnum.Value_5, 3, true);
        scribble_glyph_set("fontThai", -3, UnknownEnum.Value_5, 3, true);
        scribble_font_set_default(locGetFontFromLanguage());
        global.defaultFont = locGetFontFromLanguage();
        global.resultsScoreFont = __scribble_font_add_sprite_ext(sResultsScoreText, "0123456789", true, 0);
    }
}
