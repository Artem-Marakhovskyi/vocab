import 'package:colorize/colorize.dart';
import 'package:vocab/cases/args/args_parser.dart';
import 'package:vocab/cases/use_case.dart';
import 'package:vocab/model/word_entity.dart';

import 'args/args.dart';

class TrainingWordsCountUseCase extends UseCase {
  TrainingWordsCountArgs get arguments => args as TrainingWordsCountArgs;
  TrainingWordsCountUseCase(args) : super(args);

  @override
  Future execute() async {
    var allWords = [...context.existingDict.words];
    if (arguments.takeWorst) {
      allWords.sort((f, s) => f.getRatio().compareTo(s.getRatio()));
      allWords = allWords.take(arguments.wordscount).toList();
    }
    allWords.shuffle();

    var successCount = 0;
    var idx = 0;

    var sessionWords = allWords.take(arguments.wordscount);
    for (var sessionWord in sessionWords) {
      idx++;
      if (arguments.direction == ArgsParser.directionEnDe) {
        var success = ende(sessionWord, idx);
        sessionWord.attempt(success);
        if (success) {
          successCount++;
        }
        context.existingDict.replace(sessionWord);
      } else if (arguments.direction == ArgsParser.directionDeEn) {
        var success = deen(sessionWord, idx);
        sessionWord.attempt(success);
        if (success) {
          successCount++;
        }
        context.existingDict.replace(sessionWord);
      }
      print('');
    }
    print('✅: $successCount, attempts: ${arguments.wordscount}');
    await context.existingDict.commit();
  }

  bool deen(WordEntity sessionWord, int idx) {
    color(
        '${getProgress(idx)}${sessionWord.meanings.map((e) => e.isNoun ? '${e.nounArticle} ${e.src}' : '${e.src} (${e.mark})').toSet().toList().join(', ')}',
        front: Styles.BLUE);
    var input = context.input.read().trim();
    if (sessionWord.meanings
        .any((element) => element.dests.any((x) => x == input))) {
      print(
          '✅ - ${sessionWord.meanings.map((element) => element.dests.join(', ')).join('; ')}');
      return true;
    } else {
      print(
          '❌ - ${sessionWord.meanings.map((e) => e.dests.map((d) => '$d (${e.mark})').join('; ')).join(', ')}');
      return false;
    }
  }

  bool ende(WordEntity sessionWord, int idx) {
    color(
        '${getProgress(idx)}${sessionWord.meanings.map((e) => e.dests.join(', ')).join('; ')}',
        front: Styles.BLUE);
    var input = context.input.read().trim();
    if (input == sessionWord.de) {
      print('✅ - ${<String>{
        sessionWord.de
      }.union(sessionWord.meanings.map((e) => '${e.src} (${e.mark})').toSet()).join(', ')}');

      return true;
    } else {
      print(
          '❌ - ${sessionWord.meanings.map((e) => e.src).toSet().toList().join(', ')}');

      return false;
    }
  }

  String getProgress(int idx) {
    return '$idx/${arguments.wordscount}: ';
  }
}
