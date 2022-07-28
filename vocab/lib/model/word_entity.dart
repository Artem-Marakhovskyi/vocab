class WordEntity {
  final String de;
  final List<Meaning> meanings;
  WordEntity(String de, this.meanings) : de = de.toLowerCase() {}

  @override
  String toString() {
    return '$de - \n\t${meanings.map((e) => e.toString()).join('\n\t')}';
  }

  List<String> dests() => meanings.expand((e) => e.dests).toList();
}

class Meaning {
  final String src;
  final List<String> dests;
  final String mark;
  Meaning(String src, List<String> dests, String mark)
      : src = src.toLowerCase(),
        dests = dests.map((e) => e.toLowerCase()).toList(),
        mark = mark.toLowerCase() {}

  bool get isNoun => mark.isNotEmpty && mark[0] == 'n';

  String get nounArticle {
    var article = '';
    if (mark[0] == 'n') {
      if (mark[1] == 'f') article = 'die';
      if (mark[1] == 'm') article = 'der';
      if (mark[1] == 'n') article = 'das';
    }

    return article;
  }

  @override
  String toString() {
    var article = '';
    if (isNoun) article = '${nounArticle} ';
    return '$article$src ($mark) - ${dests.join(', ')}';
  }
}
