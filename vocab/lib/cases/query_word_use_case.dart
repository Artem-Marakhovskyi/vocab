import 'package:colorize/colorize.dart';
import 'package:vocab/cases/args/args.dart';
import 'package:vocab/cases/use_case.dart';

class QueryWordUseCase extends UseCase {
  QueryWordArgs get arguments => args as QueryWordArgs;
  QueryWordUseCase(args) : super(args);

  @override
  Future execute() async {
    var similars = context.existingDict.words
        .where((element) => element.de == arguments.word);
    if (similars.isEmpty) {
      await context.translator.addTranslation('de', 'en', arguments.word);
    } else {
      for (var word in similars) {
        color(word.toString(), front: Styles.BLUE);
      }
    }
  }
}
