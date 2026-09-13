import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../res/api_constants.dart';

/// Exception class for upload errors
class UploadException implements Exception {
  final int statusCode;
  final String message;

  UploadException({required this.statusCode, required this.message});

  @override
  String toString() => 'UploadException: Status $statusCode - $message';
}

class ApiService {

  // Singleton instance
  static final ApiService _instance = ApiService._internal();

  // Factory constructor
  factory ApiService() {
    return _instance;
  }

  // Private constructor
  ApiService._internal();
  final String _baseUrl = ApiConstants.baseUrl;

  Future<http.Response> postRequest({required String endpoint, required Map<String, dynamic> data, }) async {
    var url = Uri.parse(_baseUrl + endpoint);
    Map<String, String> headers =  await _getApiHeader();
    // debugPrint("Post request url: $url\nData: $data\nHeaders: $headers");

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    debugPrint("Post request response: ${response.body}");
    return response;
  }


  Future<http.Response?> postRequestWithToken({required String endpoint, required Map<String, dynamic> data,}) async {
    var url = Uri.parse(_baseUrl + endpoint);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");
    if(token != null){
      Map<String, String> headers =  await _getApiHeaderWithBearerToken(token);
      // debugPrint("Post request with token url: $url\nData: $data\nHeaders: $headers");

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(data),
      );

      debugPrint("Post request with token response: ${response.body}");
      return response;
    }
    return null;
  }


  Future<bool> uploadReportWithImages({required String reportText, required List<File> images,}) async {
    bool result = false;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");
    if(token != null){
      final url = Uri.parse("https://admin.portalixmx.com/api/app-api/save-report");

      var request = http.MultipartRequest('POST', url);

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      // Add complaint text
      request.fields['report_text'] = reportText;

      // Add multiple image files with SAME key
      for (var image in images) {
        final mimeType = lookupMimeType(image.path) ?? 'image/jpeg';
        final mimeSplit = mimeType.split('/');

        request.files.add(
          await http.MultipartFile.fromPath(
            'img',
            image.path,
            contentType: MediaType(mimeSplit[0], mimeSplit[1]),
            filename: basename(image.path),
          ),
        );
      }
      // Send request
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      debugPrint("addReport api response: ${responseBody}");
      
      if(response.statusCode == 200){
        result = true;
      } else {
        // Throw exception with status code for error handling
        throw UploadException(
          statusCode: response.statusCode,
          message: _extractErrorMessage(responseBody),
        );
      }
    }

    return result;
  }

  /// Extracts error message from HTML or JSON response
  String _extractErrorMessage(String responseBody) {
    // Check if it's HTML (like nginx error pages)
    if (responseBody.contains('<html>') || responseBody.contains('<title>')) {
      // Try to extract title or h1 content
      final titleMatch = RegExp(r'<title>(.*?)</title>', caseSensitive: false).firstMatch(responseBody);
      if (titleMatch != null) {
        return titleMatch.group(1) ?? 'Upload failed';
      }
      final h1Match = RegExp(r'<h1>(.*?)</h1>', caseSensitive: false).firstMatch(responseBody);
      if (h1Match != null) {
        return h1Match.group(1) ?? 'Upload failed';
      }
      return 'Upload failed';
    }
    
    // Try to parse as JSON
    try {
      final json = jsonDecode(responseBody);
      if (json is Map && json.containsKey('message')) {
        return json['message'].toString();
      }
      if (json is Map && json.containsKey('error')) {
        return json['error'].toString();
      }
    } catch (e) {
      // Not JSON, return generic message
    }
    
    return 'Upload failed';
  }

  Future<http.Response?> getRequest({required String endpoint,}) async {
    var url = Uri.parse(ApiConstants.baseUrl + endpoint);
    debugPrint("Get URL: $url");

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");
    if(token != null){
      final headers = await _getApiHeaderWithBearerToken(token);
      final response = await http.get(
        url,
        headers: headers,
      );
      return response;
    }

    return null;
  }

  Future<Map<String, String>> _getApiHeader() async {
    return {'Content-Type': 'application/json',};
  }

  Future<Map<String, String>> _getApiHeaderWithBearerToken(String token) async {
    return { 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',};
  }

  Future<bool> updateProfile({required Map<String, dynamic> map}) async {
    bool result = false;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");
    if(token != null){

      final url = Uri.parse("https://admin.portalixmx.com/api/app-api/update-profile");
      var request = http.MultipartRequest('POST', url);

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      // Add complaint text
      request.fields['name'] = map['name'];
      request.fields['mobile'] = map['mobile'];
      request.fields['additionalDetails'] = jsonEncode(map['additionalDetails']);
      // request.fields['emergencyContacts'] = jsonEncode(map['emergencyContacts']);

      if(map['img'] != null && map['img'].isNotEmpty){
        final mimeType = lookupMimeType(map['img']) ?? 'image/jpeg';
        final mimeSplit = mimeType.split('/');
        request.files.add(
          await http.MultipartFile.fromPath(
            'img',
            map['img'],
            contentType: MediaType(mimeSplit[0], mimeSplit[1]),
            filename: basename(map['img']),
          ),
        );
      }

      // Send request
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      debugPrint("update profile api response: $responseBody");
      if(response.statusCode == 200){
        result = true;
      }
    }

    return result;
  }
}