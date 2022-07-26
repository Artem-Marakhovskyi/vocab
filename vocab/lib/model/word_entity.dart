class WordEntity {
  final String de;
  final List<Meaning> meanings;
  WordEntity(this.de, this.meanings);

  @override
  String toString() {
    return '$de - \n\t${meanings.map((e) => e.toString()).join('\n\t')}';
  }
}

class Meaning {
  final String src;
  final List<String> dests;
  final String mark;
  Meaning(this.src, this.dests, this.mark);

  @override
  String toString() => '$src ($mark) - ${dests.join(', ')}';
}
