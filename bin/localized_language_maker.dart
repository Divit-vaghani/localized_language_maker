import 'dart:convert';
import 'dart:io';
import 'package:translator/translator.dart';
import 'model/translation_type.dart';
import 'utils/converter.dart';

Future<void> main() async {
  Stopwatch stopwatch = Stopwatch();
  File file = File("/home/divit-vaghani/Documents/localized_language_maker/assets/app_en.arb");
  File supportedLang = File("/home/divit-vaghani/Documents/localized_language_maker/assets/supported_lang.txt");

  Map<String, dynamic> languageList =
      jsonDecode(await supportedLang.readAsString(encoding: utf8));

  Map<String, dynamic> data =
      jsonDecode((await file.readAsString(encoding: utf8)));
  List<Future<Map<String, dynamic>>> allFuture = [];

  stopwatch.start();
  for (MapEntry single in languageList.entries) {
    TranslationType translationType = TranslationType(
      translator: GoogleTranslator(),
      body: data,
      from: 'en',
      to: single.key,
    );
    // compute(convertTo,translationType).then((value) => print(value));
    allFuture.add(convertTo(translationType));
  }
  await Future.wait<Map<String, dynamic>>(allFuture);
  print(stopwatch.elapsed);
  stopwatch.stop();
}
