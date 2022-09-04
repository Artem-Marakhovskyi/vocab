import 'package:colorize/colorize.dart';
import 'package:vocab/cases/args/args_parser.dart';
import 'package:vocab/cases/use_case.dart';
import 'package:vocab/model/word_entity.dart';

import 'args/args.dart';

class DoctorSpecificUseCase extends UseCase {
  DoctorSpecificArgs get arguments => (args as DoctorSpecificArgs);
  DoctorSpecificUseCase(args) : super(args);

  @override
  Future execute() async {
    var meanings = <Meaning>[];

    var de = arguments.word;
    print(de);
    if (!context.existingDict.words.any((element) => element.de == de) &&
        !context.existingDict.brokenWords.contains(de)) {
      color('There is no word to alter found in the dictionary',
          front: Styles.YELLOW);
    }

    if (context.existingDict.brokenWords.contains(de)) {
      while (true) {
        print(
            'Enter term usage ("${ArgsParser.exitCommand}" to exit, "--save" to complete):');
        var src = context.input.read();
        if (src == ArgsParser.exitCommand) return;
        if (src == '--save') break;

        print('Enter usage mark (optional):');
        var mark = context.input.read();

        print('Enter term meaning(s), use comma to separate meanings:');
        var meaningsJoints = context.input.read();
        if (meaningsJoints == ArgsParser.exitCommand) return;

        var dests = meaningsJoints
            .split(',')
            .where((element) => element.isNotEmpty)
            .toList();
        meanings.add(Meaning(src, dests, mark));
      }
    }

    WordEntity wordEntity = WordEntity(de, meanings,
        DateTime.fromMicrosecondsSinceEpoch(0), 0, 0, DateTime.now());
    context.existingDict.add(wordEntity, wordEntity.de);
    await context.existingDict.commit();
  }
}
