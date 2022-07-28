import 'package:args/args.dart';

abstract class Args {}

class ExitArgs extends Args {}

class DoctorArgs extends Args {
  DoctorArgs();
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
  TrainingWordsCountArgs(this.wordscount, this.direction);
}
