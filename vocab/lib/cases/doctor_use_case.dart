import 'package:colorize/colorize.dart';
import 'package:vocab/cases/use_case.dart';

class DoctorUseCase extends UseCase {
  DoctorUseCase(args) : super(args);

  @override
  Future execute() async {
    if (context.existingDict.brokenWords.isEmpty) {
      color('There are no broken terms in the dictionary', front: Styles.GREEN);
      return;
    }

    for (var term in context.existingDict.brokenWords) {
      await context.translator.addTranslation('de', 'en', term);
    }

    if (context.existingDict.brokenWords.isEmpty) {
      color('--------------------------', front: Styles.GREEN);
      color('All broken terms are fixed', front: Styles.GREEN);
      return;
    } else {
      var brokenWords = context.existingDict.brokenWords.join(', ');
      var cut = brokenWords.length > 100
          ? brokenWords.substring(0, 100)
          : brokenWords;
      color(
          'There are ${context.existingDict.brokenWords.length} broken words left: $cut',
          front: Styles.YELLOW);
    }
  }
}
