import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:home_automation/model/home_appliance_model.dart';

class ApiData {
  static Future<String> loadApplianceAsset() async {
    return await rootBundle.loadString('assets/data/appliances.json');
  }

  static Future<HomeModel> loadAppliances() async {
    String jsonString = await loadApplianceAsset();
    final Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
    return HomeModel.fromJson(jsonResponse);
  }
}
