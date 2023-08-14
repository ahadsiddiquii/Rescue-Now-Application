import 'dart:io';

void main() {
  final List<String> dartFilePaths = getDartFilePaths(
      Directory('./lib')); // Change to your project's root directory
  final Set<String> extractedStrings = extractStringsFromFiles(dartFilePaths);

  print('Extracted Strings:');
  extractedStrings.forEach(print);
}

List<String> getDartFilePaths(Directory directory) {
  final List<String> filePaths = [];
  for (final entity in directory.listSync(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      filePaths.add(entity.path);
    }
  }
  return filePaths;
}

Set<String> extractStringsFromFiles(List<String> filePaths) {
  final Set<String> extractedStrings = {};

  for (final filePath in filePaths) {
    final File file = File(filePath);
    final String content = file.readAsStringSync();

    final RegExp stringLiteralRegex = RegExp(r'"([^"\\]*(?:\\.[^"\\]*)*)"');
    final Iterable<RegExpMatch> matches =
        stringLiteralRegex.allMatches(content);

    for (final match in matches) {
      extractedStrings.add(match.group(1)!); // Add matched string value
    }
  }

  return extractedStrings;
}
