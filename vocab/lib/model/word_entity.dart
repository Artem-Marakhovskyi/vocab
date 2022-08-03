class WordEntity {
  final String de;
  final List<Meaning> meanings;
  final DateTime added;

  DateTime lastAttempt;
  int success;
  int totalAttempts;

  WordEntity.neverTrained(String de, List<Meaning> meanings)
      : this(de, meanings, DateTime.fromMicrosecondsSinceEpoch(0), 0, 0,
            DateTime.now());

  WordEntity(String de, this.meanings, this.lastAttempt, this.success,
      this.totalAttempts, this.added)
      : de = de.toLowerCase();

  @override
  String toString() {
    return '$de (ratio: ${getRatio()})- \n\t${meanings.map((e) => e.toString()).join('\n\t')}';
  }

  void attempt(bool isSuccess) {
    totalAttempts++;
    if (isSuccess) {
      success++;
    }
  }

  void cleanup() {
    for (var m in meanings) {
      m.dests.removeWhere(
          (e) => e.trim() == '' || e.trim() == ';' || e.trim() == ':');
    }

    meanings.removeWhere((element) => element.dests.isEmpty);
  }

  List<String> dests() => meanings.expand((e) => e.dests).toList();

  double getRatio() {
    if (totalAttempts == 0) {
      return 0;
    }

    return success.toDouble() / totalAttempts.toDouble();
  }
}

class Meaning {
  final String src;
  final List<String> dests;
  final String mark;
  Meaning(String src, List<String> dests, String mark)
      : src = src.toLowerCase(),
        dests = dests.map((e) => e.toLowerCase()).toList(),
        mark = mark.toLowerCase();

  bool get isNoun => mark.isNotEmpty && mark[0] == 'n';

  String get nounArticle {
    var article = '';
    if (mark.isNotEmpty && mark.length > 1 && mark[0] == 'n') {
      if (mark[1] == 'f') article = 'die';
      if (mark[1] == 'm') article = 'der';
      if (mark[1] == 'n') article = 'das';
    }

    return article;
  }

  @override
  String toString() {
    var article = '';
    if (isNoun) article = '$nounArticle ';
    return '$article$src ($mark) - ${dests.join(', ')}';
  }
}
