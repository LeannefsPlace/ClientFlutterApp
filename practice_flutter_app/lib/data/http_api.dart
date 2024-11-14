import 'package:http/http.dart' as http;
import 'package:practice_flutter_app/constants/API_constants';
import 'dart:convert';

import 'package:practice_flutter_app/data/model.dart';

class HttpApi {
  Future<Fact> getRandomFact() async{
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/rand'));

    if(response.statusCode == 200){
      return Fact.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception ("Unable to load fact");
    }
  }

  Future<Fact> getRandomFactByCategory(String category) async{
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/rand/${category}'));

    if(response.statusCode == 200){
      return Fact.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception ("Unable to load fact from category ${category}");
    }
  }

  Future<Fact> newFact(Fact fact) async{
    final response = await http.post(Uri.parse('${ApiConstants.baseUrl}/'),
    headers: {'Content-type':'application/json'},
    body: jsonEncode(fact));

    if(response.statusCode == 200){
      return Fact.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception ("Unable to write fact");
    }
  }

  Future<Fact> like(int id) async{
    final response = await http.post(Uri.parse('${ApiConstants.baseUrl}/${id}/like'));

    if(response.statusCode == 200){
      return Fact.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception ("Unable to write your like");
    }
  }

  Future<Fact> dislike(int id) async{
    final response = await http.post(Uri.parse('${ApiConstants.baseUrl}/${id}/dislike'));

    if(response.statusCode == 200){
      return Fact.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception ("Unable to write your dislike");
    }
  }
}