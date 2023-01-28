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

  List<Map<String, dynamic>> translatedListLanguage = <Map<String, dynamic>>[];

  for (MapEntry single in languageList.entries) {
    TranslationType translationType = TranslationType(
      translator: GoogleTranslator(),
      body: data,
      from: 'en',
      to: single.key,
    );

    Map<String, dynamic> translation = await convertTo(translationType);

    translatedListLanguage.add(translation);

    await File("assets/arb/app_${single.key}.arb").writeAsString(
      JsonEncoder.withIndent(" " * 4).convert(translation),
    );
  }
  print("Total Translated Language : ${translatedListLanguage.length}");
}
