import 'package:html/parser.dart';

class RemoveHtml {
  String delHtml(String html) {
    final document = parse(html);
    final String parsedText = parse(document.body!.text).documentElement!.text;
    return parsedText;
  }
}
