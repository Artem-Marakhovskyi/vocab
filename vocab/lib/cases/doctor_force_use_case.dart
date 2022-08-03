import 'package:colorize/colorize.dart';
import 'package:vocab/cases/use_case.dart';

class DoctorForceUseCase extends UseCase {
  DoctorForceUseCase(super.args);

  @override
  Future execute() async {
    for (var term in context.existingDict.brokenWords) {
      await context.translator.addTranslation('de', 'en', term);
    }
    for (var term in [...context.existingDict.words]) {
      await context.translator.addTranslation('de', 'en', term.de);
    }

    for (var w in context.existingDict.words) {
      w.cleanup();
    }

    var actuallyBroken = <String>[];
    for (var w in context.existingDict.words) {
      if (w.meanings.any((element) =>
          element.dests.isEmpty ||
          element.dests
              .any((dest) => dest.contains(':') || dest.contains(';')))) {
        actuallyBroken.add(w.de);
        color('${w.de} is broken', front: Styles.YELLOW);
      }
    }
    for (var de in actuallyBroken) {
      context.existingDict.breakWord(de);
    }

    await context.existingDict.commit();
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
