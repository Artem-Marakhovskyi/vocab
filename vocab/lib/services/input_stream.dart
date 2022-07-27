import 'dart:io';

class InputStream {
  List<String>? input;

  InputStream() {}

  InputStream.fromInput(this.input);

  String read() {
    if (input == null || input!.isEmpty) {
      return stdin.readLineSync()!;
    }

    return input!.removeAt(0);
  }
}
