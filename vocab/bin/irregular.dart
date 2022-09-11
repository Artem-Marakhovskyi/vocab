import 'dart:io';

import 'package:colorize/colorize.dart';
import 'package:vocab/model/input_dict.dart';
import 'package:vocab/services/input_stream.dart';

void main(List<String> arguments) async {
  var file = File('${Directory.current.path}/../vocabulary/irregular.txt');
  if (arguments.length == 1) {
    PairCollection(file).trainFromEngCount(int.parse(arguments[0]));
  } else {
    PairCollection(file).trainFromEnStartCount(
        int.parse(arguments[0]), int.parse(arguments[1]));
  }
}

class PairCollection {
  late List<Pair> pairs;

  final InputStream _inputStream = InputStream();

  PairCollection(File file) {
    var linesSplitted = file
        .readAsLinesSync()
        .where((element) => element.startsWith('#'))
        .map((e) => e.split('|'));
    var p = <Pair>[];
    try {
      for (var l in linesSplitted) {
        p.add(Pair(l[0].split(','), l[1]));
      }
    } on Error catch (e) {
      print(e);
    }
    pairs = p;
  }

  void trainFromEnStartCount(int start, int count) {
    var trainingMaterial = [...pairs];
    trainingMaterial = trainingMaterial.skip(start).take(count).toList();
    trainingMaterial.shuffle();
    _trainFrom(trainingMaterial, true);
  }

  void trainFromEngCount(int count) {
    var trainingMaterial = [...pairs];
    trainingMaterial.shuffle();
    trainingMaterial = trainingMaterial.take(count).toList();
    _trainFrom(trainingMaterial, true);
  }

  void _trainFrom(List<Pair> trainingMaterial, bool fromEng) {
    var count = trainingMaterial.length;
    var success = 0;
    var attempts = 0;
    for (var i = 0; i < count; i++) {
      color(
          '${++attempts}/$count: ${fromEng ? trainingMaterial[i].eng : trainingMaterial[i].de}',
          front: Styles.BLUE);
      var userEnteredLine = _inputStream.read();
      if (fromEng
          ? userEnteredLine == trainingMaterial[i].de
          : trainingMaterial[i].eng.any((e) => e == userEnteredLine)) {
        print('✅');
        success++;
      } else {
        color('${fromEng ? trainingMaterial[i].de : trainingMaterial[i].eng}',
            front: Styles.RED);
      }
    }

    color('$success/$count');
  }
}

class Pair {
  final List<String> eng;
  final String de;
  Pair(this.eng, this.de);
}
