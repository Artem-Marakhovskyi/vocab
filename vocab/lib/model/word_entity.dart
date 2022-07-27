class WordEntity {
  final String de;
  final List<Meaning> meanings;
  WordEntity(String de, this.meanings) : de = de.toLowerCase() {}

  @override
  String toString() {
    return '$de - \n\t${meanings.map((e) => e.toString()).join('\n\t')}';
  }
}

class Meaning {
  final String src;
  final List<String> dests;
  final String mark;
  Meaning(String src, List<String> dests, String mark)
      : src = src.toLowerCase(),
        dests = dests.map((e) => e.toLowerCase()).toList(),
        mark = mark.toLowerCase() {}

  @override
  String toString() => '$src ($mark) - ${dests.join(', ')}';
}
