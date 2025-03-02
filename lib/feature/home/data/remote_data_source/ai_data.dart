
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AiService {
  final Dio dio;

  AiService({required this.dio});

  Future<int?> getPrediction(List<int> features) async {
    try {
      Map<String, dynamic> body = {'features': features};
      Response response = await dio.post(
        "http://192.168.1.3:5001/predict",
        data: json.encode(body),
      );

      if (response.statusCode == 200) {
        
        if (kDebugMode) {
       ;
         return response.data['prediction'][0];
        }
      } else {
        if (kDebugMode) {
          print('Failed to get prediction');
          return null;
        }
        print(response.statusMessage);
      }
    } catch (e) {
      print("Error>  : $e");
      return null;
    }
    return null;
  }
}