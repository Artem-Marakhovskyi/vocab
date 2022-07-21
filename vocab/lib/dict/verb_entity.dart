class WordEntity {
  String de;
  String en;
  String partOfSpeech;
  List<String> synonyms;
  WordEntity(this.de, this.en, this.partOfSpeech, this.synonyms);

  @override
  String toString() {
    return '$de - $en';
  }
}
