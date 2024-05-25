import 'package:coincap/models/AppConfig.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class HttpService {
  final Dio dio = Dio();

  AppConfig? appConfig;
  String? baseUrl;

  HttpService() {
    appConfig = GetIt.instance.get<AppConfig>();
    baseUrl = appConfig!.COIN_API_BASE_URL;
  }

  Future<Response?> get(String path) async {
    try {
      String url = "$baseUrl$path";
      Response response = await dio.get(url);
      return response;
    } catch (e) {
      print("Unable to performed a get request. $e");
    }
    return null;
  }
}
