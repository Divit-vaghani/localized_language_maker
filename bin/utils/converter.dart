import 'package:translator/translator.dart';
import '../model/translation_type.dart';

Future<Map<String, dynamic>> convertTo(TranslationType translationType) async {
  Map<String, dynamic> translateMap = <String, dynamic>{};
  for (MapEntry<String, dynamic> single in translationType.body.entries) {
    if (single.value is Map) {
      translateMap.addEntries([single]);
    } else if (single.key == "abEmail") {
      translateMap.addEntries([single]);
    } else {
      Translation translation = await translationType.translator.translate(
        single.value,
        from: translationType.from,
        to: translationType.to,
      );
      translateMap.addEntries([MapEntry(single.key, translation.text)]);
    }
  }
  await translationType.saveContent(translateMap);
  return translateMap;
}
