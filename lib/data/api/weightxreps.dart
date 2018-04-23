import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kinoweights/data/entities/summary.dart';
import 'package:crypto/crypto.dart';

class CommunityApi{

  static final CommunityApi _singleton = new CommunityApi._internal();

  factory CommunityApi() {
    return _singleton;
  }

  CommunityApi._internal();

  Future<List<Summary>> fetchSummary() async {
    final response = await http.get('https://api.apify.com/v1/W34JM2HMA6L2cMsrg/crawlers/n444LBxiSGYKHKn3P/lastExec/results?token=' + APIFY_API_KEY);
    final responseJson = (json.decode(response.body) as List);

    var summaries = new List<Summary>();

    var iterable = (responseJson.first as Map);

    for(var summary in (iterable['pageFunctionResult'] as List)){
      summaries.add(new Summary.fromJson(summary));
    }
    return summaries;
  }

  Future<bool> login(String user, String pass) async {
    return true;
    var headers = new Map<String, String>();
    headers.putIfAbsent("Content-Type", () => "application/json");

    var body = new Map<String, List<Map<String, String>>>();
    var cookies = new List<Map<String, String>>();
    var cookie = new Map<String, String>();
    cookie.putIfAbsent("name", () => "WXR_REMEMBER_ME_v2");
    cookie.putIfAbsent("value", () => md5.convert(Utf8Encoder().convert(user)).toString() + md5.convert(Utf8Encoder().convert(pass)).toString());
    cookie.putIfAbsent("domain", () => "weightxreps.net");
    cookies.add(cookie);
    body.putIfAbsent("cookies", () => cookies);

    final response = await http.post('https://api.apify.com/v1/W34JM2HMA6L2cMsrg/crawlers/6Wz4ADJFYhjrLhY5b/execute?token=' + APIFY_API_KEY + "&wait=120", headers: headers, body: jsonEncode(body));
    final responseJson = (json.decode(response.body));

    final checkValidity = await http.get(responseJson['resultsUrl']);
    final validityJson = (json.decode(checkValidity.body));
    final iterable = ((validityJson as List).first as Map);

    final isSuccess = (iterable['pageFunctionResult']['status'] == "SUCCESS");

    if(isSuccess){

    }

    return (isSuccess);
  }

}