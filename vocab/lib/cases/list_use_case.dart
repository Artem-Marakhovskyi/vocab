import 'dart:io';

import 'package:colorize/colorize.dart';
import 'package:vocab/cases/args/args.dart';
import 'package:vocab/cases/use_case.dart';

class ListUseCase extends UseCase {
  ListArgs get arguments => args as ListArgs;
  ListUseCase(args) : super(args);

  @override
  Future execute() {
    var words = [...context.existingDict.words];
    words.sort((f, s) {
      var fR = f.getRatio();
      var sR = s.getRatio();

      return arguments.listBest ? fR.compareTo(sR) : sR.compareTo(fR);
    });
    for (var w in words.take(arguments.count)) {
      color(w.toString(), front: Styles.BLUE);
    }

    return Future.value();
  }
}
