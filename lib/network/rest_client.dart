import 'dart:convert';
import 'dart:io';

import 'package:news_app/dto/everything_response.dart';
import 'package:http/http.dart' as http;
class RestClient{
  Future<EverythingResponse> everything() async{
    final response = await http.get(
        Uri.parse("https://newsapi.org/v2/everything?q=italy"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer 125d2df29c0e429b8be76d619ec669da"
        }
    );

    if (response.statusCode == 200){
      return EverythingResponse.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception("Can\'t load everything response");
    }

  }
}