final prettifyNameRegex = RegExp(r'([a-z])([A-Z])');

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

String prettifyName(String text) {
  var result = text.replaceAllMapped(prettifyNameRegex, (Match m) => '${m[1]} ${m[2]}');
  result = capitalizeFirstLetter(result);
  return result;
}
