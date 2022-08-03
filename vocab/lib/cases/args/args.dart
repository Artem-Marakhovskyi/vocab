import 'package:args/args.dart';

abstract class Args {}

class ExitArgs extends Args {}

class DoctorArgs extends Args {
  DoctorArgs();
}

class DoctorForceArgs extends Args {
  DoctorForceArgs();
}

class ListArgs extends Args {
  final bool listBest;
  final bool listWorst;
  final int count;
  ListArgs(this.listBest, this.listWorst, this.count);
}

class DoctorSpecificArgs extends Args {
  final String word;
  DoctorSpecificArgs(this.word);
}

class IncorrectArgs extends Args {
  final ArgResults results;
  final String usage;
  IncorrectArgs(this.results, this.usage);
}

class AddInteractiveArgs extends Args {
  final String word;
  AddInteractiveArgs(this.word);
}

class AddFilepathArgs extends Args {
  final String filepath;
  AddFilepathArgs(this.filepath);
}

class AddKeyValueFilepathArgs extends Args {
  final String filepath;
  AddKeyValueFilepathArgs(this.filepath);
}

class QueryWordArgs extends Args {
  final String word;
  QueryWordArgs(this.word);
}

class QueryWordsArgs extends Args {
  final List<String> words;
  QueryWordsArgs(this.words);
}

class TrainingWordsCountArgs extends Args {
  final String direction;
  final int wordscount;
  final bool takeWorst;
  TrainingWordsCountArgs(this.wordscount, this.direction, this.takeWorst);
}
