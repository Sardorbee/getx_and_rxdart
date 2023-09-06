import 'package:getx_and_rxdart/data/models/universal_data.dart';
import 'package:getx_and_rxdart/data/network/api_service.dart';

class DictionaryRepository {
  final ApiService apiService;
  DictionaryRepository({required this.apiService});

  Future<UniversalData> getDictionary({required String query}) async {
    return await apiService.getDictionary(query: query);
  }
}
