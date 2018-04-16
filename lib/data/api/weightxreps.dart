import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kinoweights/data/entities/summary.dart';

class CommunityApi{

  static final String APIFY_API_KEY = "iadgAaLPsyeAgxACunJdo8Div";

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

}