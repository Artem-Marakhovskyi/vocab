import 'package:colorize/colorize.dart';
import 'package:vocab/cases/args/args_parser.dart';
import 'package:vocab/cases/use_case.dart';

import 'args/args.dart';

class TrainingWordsCountUseCase extends UseCase {
  TrainingWordsCountArgs get arguments => args as TrainingWordsCountArgs;
  TrainingWordsCountUseCase(super.args);

  @override
  Future execute() async {
    var allWords = [...context.existingDict.words];
    allWords.shuffle();

    var successCount = 0;
    var idx = 0;

    var sessionWords = allWords.take(arguments.wordscount);
    for (var sessionWord in sessionWords) {
      idx++;
      if (arguments.direction == ArgsParser.directionEnDe) {
        color(
            '$idx/${arguments.wordscount}: ${sessionWord.meanings.map((e) => e.dests.join(', ')).join('; ')}',
            front: Styles.BLUE);
        var input = context.input.read().trim();
        if (input == sessionWord.de) {
          successCount++;
          print('✅ - ${<String>{
            sessionWord.de
          }.union(sessionWord.meanings.map((e) => '${e.src} (${e.mark})').toSet()).join(', ')}');
        } else {
          print(
              '❌ - ${sessionWord.meanings.map((e) => e.src).toSet().toList().join(', ')}');
        }
      } else if (arguments.direction == ArgsParser.directionDeEn) {
        color(
            '$idx/${arguments.wordscount}: ${sessionWord.meanings.map((e) => e.src).toSet().toList().join(', ')}',
            front: Styles.BLUE);
        var input = context.input.read().trim();
        if (sessionWord.meanings
            .any((element) => element.dests.any((x) => x == input))) {
          print(
              '✅ - ${sessionWord.meanings.map((element) => element.dests.join(', ')).join('; ')}');
          successCount++;
        } else {
          print(
              '❌ - ${sessionWord.meanings.map((e) => e.dests.join('; ')).join(', ')}');
        }
      }
    }

    print('✅: $successCount, attempts: ${arguments.wordscount}');
  }
}
