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
  final String de;
  final List<String> engs;
  final String mark;
  Meaning(this.de, this.engs, this.mark);

  @override
  String toString() => '$de ($mark) - ${engs.join(', ')}';
}
