import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portalixmx_guards_app/generated/app_localizations.dart';
import 'package:portalixmx_guards_app/models/report_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../res/api_constants.dart';
import '../services/api_service.dart';

class ReportProvider extends ChangeNotifier {
  final String _reportsKey = 'reports';
  final _apiService = ApiService();
  bool _loadingReports = false;
  List<Report> _allReports  = [];
  List<Report> get allReports => _allReports;
  bool get loadingReport => _loadingReports;

  bool addingReport =  false;
  ReportProvider(){
    getAllReports();
  }
  Future<bool> addReport({required String complaint, required List<File> files}) async{
    bool result = false;
    addingReport = true;
    notifyListeners();
    try{

      result = await _apiService.uploadReportWithImages(reportText: complaint, images: files);
      addingReport = false;
      notifyListeners();
      getAllReports();
    }catch(e){
      addingReport = false;
      notifyListeners();
      debugPrint("Error while logging in: ${e.toString()}");
    }
    return result;
  }

  Future<Map<String, dynamic>?> getAllReports() async{
    _loadingReports = true;
    notifyListeners();
    try{
      final response =  await _apiService.getRequest(endpoint: ApiConstants.allReports,);
      if(response != null){
        debugPrint("Report api response: ${response.body}");
        ReportApiResponse apiResponse = ReportApiResponse.fromJson(jsonDecode(response.body));
        _allReports = apiResponse.data;
        _allReports.sort((a, b)=> b.createdAt.compareTo(a.createdAt));
        notifyListeners();

        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        List<Map<String, dynamic>> reports = _allReports.map((report) => report.toJson()).toList();
        await sharedPreferences.setString(_reportsKey, jsonEncode(reports));
      }
    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }
    _loadingReports = false;
    notifyListeners();
    return null;
  }

  Future<bool> deleteReportByID(Report report, BuildContext context) async {

    bool result = false;
    _allReports.remove(report);
    notifyListeners();
    try {
      String endPoint = '${ApiConstants.deleteReport}/${report.id}';
      final response = await _apiService.getRequest(endpoint: endPoint,);
      if(response != null){
        debugPrint("Report complaint api response: ${response.body}");
        if (response.statusCode == 200) {
          result = true;
          Fluttertoast.showToast(msg: AppLocalizations.of(context)!.reportDeletedSuccessfully);
        }
      }

    } catch (e) {
      debugPrint('Error occurred: $e');
    }
    return result;
  }

}