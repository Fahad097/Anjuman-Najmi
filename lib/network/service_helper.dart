import 'dart:convert';
import 'dart:developer';
import 'package:anjuman_e_najmi/utils/global_constants.dart';
import 'package:http/http.dart' as http;

class ServiceHelper {
  static Future<dynamic> getApiCall(String url) async {
    if (!Globals.isInternetAvalible) {
      await Globals.showToast("No internet connection");
      throw Exception("No internet connection");
    }
    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${Globals.token}"
    });

    if (response.statusCode == 200) {
      log("Exception: ${json.decode(response.body)}");
      return await json.decode(response.body);
    } else {
      log("Exception: ${json.decode(response.body)}");

      throw Exception("Failed to load data}");
    }
  }

  static Future<dynamic> getApiCallParams(
      String url, var queryParameters) async {
    if (!Globals.isInternetAvalible) {
      Globals.showToast("No internet connection");
      throw Exception("No internet connection");
    }
    String queryString = Uri(queryParameters: queryParameters).query;
    var requestUrl = url + '?' + queryString; //

    final response = await http.get(Uri.parse(requestUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${Globals.token}"
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      log("Exception: ${json.decode(response.body)}");
      throw Exception("Failed to load data");
    }
  }

  static Future<dynamic> postApiCall(String url, var dataBody) async {
    if (!Globals.isInternetAvalible) {
      Globals.showToast("No internet connection");
      throw Exception("No internet connection");
    }

    var body = json.encode(dataBody);
    var response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Globals.token}"
        },
        body: body);

    if (response.statusCode == 200) {
      log("Result: ${json.decode(response.body)}");

      return json.decode(response.body);
    } else {
      log("Exception: ${json.decode(response.body)}");
      throw Exception("Failed to load data  ${json.decode(response.body)}");
    }
  }

  static Future<dynamic> deleteApiCall(String url) async {
    if (!Globals.isInternetAvalible) {
      Globals.showToast("No internet connection");
      throw Exception("No internet connection");
    }

    var response = await http.delete(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${Globals.token}"
    });

    if (response.statusCode == 200) {
      log("Result: ${json.decode(response.body)}");
      return json.decode(response.body);
    } else {
      log("Exception: ${json.decode(response.body)}");
      throw Exception("Failed to load data");
    }
  }

  static Future<dynamic> putApiCall(String url, var dataBody) async {
    if (!Globals.isInternetAvalible) {
      await Globals.showToast("No internet connection");
      throw Exception("No internet connection");
    }
    var body = json.encode(dataBody);
    final response = await http.put(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Globals.token}"
        },
        body: body);

    if (response.statusCode == 200) {
      log("Exception: ${json.decode(response.body)}");
      return await json.decode(response.body);
    } else {
      log("Exception: ${json.decode(response.body)}");
      throw Exception("Failed to load data ");
    }
  }
}
