List<String> extractWords(String input) {
  RegExp wordRegExp = RegExp(r'\b[A-Za-z]+\b');
  Iterable<RegExpMatch> wordMatches = wordRegExp.allMatches(input);

  List<String> extractedWords =
      wordMatches.map((match) => match.group(0)!).toList();
  return extractedWords;
}

List<int> extractNumbers(String input) {
  RegExp numberRegExp = RegExp(r'\d+');
  Iterable<RegExpMatch> matches = numberRegExp.allMatches(input);

  List<int> numbers =
      matches.map((match) => int.parse(match.group(0)!)).toList();

  return numbers;
}
