import 'dart:convert';
import 'dart:io';
import 'package:translator/translator.dart';

class TranslationType {
  const TranslationType({
    required this.from,
    required this.to,
    required this.body,
    required this.translator,
  });

  final String from;
  final String to;
  final GoogleTranslator translator;
  final Map<String, dynamic> body;

  Future<void> saveContent(Map<String, dynamic> data) async =>
      File("assets/arb/app_$to.arb").writeAsString(
        JsonEncoder.withIndent(" " * 4).convert(data),
      );
}
