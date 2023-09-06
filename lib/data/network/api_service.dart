import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:getx_and_rxdart/data/models/dictionary_model.dart';
import 'package:getx_and_rxdart/data/models/universal_data.dart';

class ApiService {
  // DIO SETTINGS

  final _dio = Dio(
    BaseOptions(
      baseUrl: "https://api.dictionaryapi.dev/api/v2/entries/en/",
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );

  ApiService() {
    _init();
  }

  _init() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          //error.response.statusCode
          debugPrint("ERRORGA KIRDI:${error.message} and ${error.response}");
          return handler.next(error);
        },
        onRequest: (requestOptions, handler) async {
          debugPrint("SO'ROV  YUBORILDI :${requestOptions.path}");

          // return handler.resolve(Response(requestOptions: requestOptions, data: {"name": "ali", "age": 26}));
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) async {
          debugPrint("JAVOB  KELDI :${response.requestOptions.path}");
          return handler.next(response);
        },
      ),
    );
  }

  Future<UniversalData> getDictionary({required String query}) async {
    Response response;
    try {
      response = await _dio.get(query);
      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        final responseData = response.data;


        if (responseData is List) {
          List<DictionaryModel> articles = responseData.map((articleJson) {
            return DictionaryModel.fromJson(articleJson);
          }).toList();
          print('list: $articles');
          return UniversalData(
            data: articles,
          );
        } else if (responseData is Map<String, dynamic>) {
          final dictionaryModel = DictionaryModel.fromJson(responseData);
          print('dictionaryModel: $dictionaryModel');
          return UniversalData(
            data: dictionaryModel, // Convert map data into a list
          );
        }
        return UniversalData(error: "Unknown Data Type");
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      if (e.response != null) {
        return UniversalData(error: e.response!.data["message"]);
      } else {
        return UniversalData(error: e.message!);
      }
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}
