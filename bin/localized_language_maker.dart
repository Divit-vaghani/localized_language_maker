import 'dart:convert';
import 'dart:io';
import 'package:translator/translator.dart';
import 'model/translation_type.dart';
import 'utils/converter.dart';

void main() async {
  File file = File("assets/app_en.arb");
  File supportedLang = File("assets/supported_lang.txt");

  Map<String, dynamic> languageList =
      jsonDecode(await supportedLang.readAsString(encoding: utf8));

  Map<String, dynamic> data =
      jsonDecode((await file.readAsString(encoding: utf8)));
  List<Future<Map<String, dynamic>>> allFuture = [];

  for (MapEntry single in languageList.entries) {
    TranslationType translationType = TranslationType(
      translator: GoogleTranslator(),
      body: data,
      from: 'en',
      to: single.key,
    );
    allFuture.add(convertTo(translationType));
  }
  List<Map<String, dynamic>> doneFuture =
      await Future.wait<Map<String, dynamic>>(
    allFuture,
  );

  for (var value in doneFuture) {
    print(JsonEncoder.withIndent(" " * 4).convert(value));
  }
}
