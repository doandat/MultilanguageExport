
class Language {
  final String? no;

  final String? module;
  final String? key;
  final bool format;
  final bool android;
  final bool iOS;
  final String vietnamese;
  final String english;
  final String chinese;
  final String korean;
  final String japanese;
  final String german;
  final String french;

  Language(this.no, this.module, this.key, this.format, this.android, this.iOS,
      this.vietnamese, this.english, this.chinese, this.korean, this.japanese, this.german, this.french);

  String getValue(String code){
    switch(code){
      case languageVietnamese: {
        return vietnamese;
      }

      case languageEnglish: {
        return english;
      }

      case languageChinese: {
        return chinese;
      }

      case languageKorean: {
        return korean;
      }

      case languageJapanese: {
        return japanese;
      }

      case languageGerman: {
        return german;
      }

      case languageFrench: {
        return french;
      }

      default: return "";
    }
  }

  static const languageVietnamese = "vi";
  static const languageEnglish = "en";
  static const languageChinese = "zh";
  static const languageKorean = "ko";
  static const languageJapanese = "ja";
  static const languageGerman = "de";
  static const languageFrench = "fr";
}
