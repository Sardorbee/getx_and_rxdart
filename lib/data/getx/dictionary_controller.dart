import 'package:get/get.dart';
import 'package:getx_and_rxdart/data/models/dictionary_model.dart';
import 'package:getx_and_rxdart/data/models/universal_data.dart';
import 'package:getx_and_rxdart/data/repository/dictionary_repo/dictionary_repo.dart';

class DictionaryController extends GetxController {
  DictionaryController({required this.dictionaryRepository});

  final DictionaryRepository dictionaryRepository;

  RxList<DictionaryModel> users = <DictionaryModel>[].obs;

  getWordList({required String query}) async {
    UniversalData data = await dictionaryRepository.getDictionary(query: query);

    if (data.data is List) {
      List<DictionaryModel> loadedWords = List<DictionaryModel>.from(data.data);

      if (loadedWords.isNotEmpty) {
        users.value = loadedWords;
      } else {
        Get.snackbar("Error", "No data found.");
      }
    } else if (data.data is DictionaryModel) {
      DictionaryModel loadedWord = data.data;
      users.value = [loadedWord];
    } else {
      Get.snackbar("Error", data.error);
    }
  }
}
