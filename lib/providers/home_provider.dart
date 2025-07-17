import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/guest_api_response.dart';
import '../models/visitor_api_response.dart';
import '../models/verified_user.dart';
import '../res/api_constants.dart';
import '../services/api_service.dart';

class HomeProvider extends ChangeNotifier {
  bool loadingUserInfo = false;
  String userName = '';
  String userID = '';
  bool loadingGuestInfo = false;
  bool loadingVisitorInfo = false;
  List<VerifiedUser> _verifiedUsers = [];
  String _verifiedUsersKey = 'verifiedUsers';

  List<VerifiedUser> get verifiedUsers => _verifiedUsers;


  HomeProvider(){
    _initUser();
  }

  bool addingGuestVisitor =  false;
  final _apiService = ApiService();
  List<Visitor> _visitors  = [];
  List<Guest> _guests  = [];

  List<Visitor> get visitors => _visitors;
  List<Guest> get guests => _guests;


  void setUserName({required String name}){
    userName = name;
    notifyListeners();
  }
  Future<Map<String, dynamic>?> getAllVisitors() async{

    try{
      final response =  await _apiService.getRequest(endpoint: ApiConstants.allVisitorsEndPoint,);
      debugPrint("Visitor api response: ${response?.body}");
      if(jsonDecode(response!.body)['message'] == 'Token expired'){
        return null;
      }
      VisitorResponse apiResponse = VisitorResponse.fromJson(jsonDecode(response.body));
      _visitors = apiResponse.data;
      _visitors.sort((a, b)=> b.createdAt.compareTo(a.createdAt));
      notifyListeners();
    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }

    return null;
  }

  Future<dynamic> getVisitorByID({required String visitorID}) async{
    loadingVisitorInfo = true;
    notifyListeners();
    try{
      String endPoint = '${ApiConstants.visitorByID}/$visitorID';
      final response =  await _apiService.getRequest(endpoint: endPoint);
      debugPrint("Visitor by id response: ${response?.body}");
      if(response != null){
        final map = jsonDecode(response.body);
        if(map['status']){
          loadingVisitorInfo = false;
          notifyListeners();
          debugPrint("Status true and data is: \n${map['data']}");
          Visitor visitor = Visitor.fromJson(map['data']);
          debugPrint("Visitor Name: ${visitor.name}");
          return visitor;
        }
      }
    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }

    loadingVisitorInfo = false;
    notifyListeners();
    return null;
  }

  Future<Map<String, dynamic>?> getAllGuests() async{

    try{
      final response =  await _apiService.getRequest(endpoint: ApiConstants.allGuestsEndPoint,);
      if(response != null){
        GuestResponse apiResponse = GuestResponse.fromJson(jsonDecode(response.body));
        _guests = apiResponse.data;
        _guests.sort((a, b)=> b.createdAt.compareTo(a.createdAt));
        notifyListeners();
      }
    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }

    return null;
  }

  Future<dynamic> getGuestByID({required String guestID}) async{
    loadingGuestInfo = true;
    notifyListeners();
    try{
      String endPoint = '${ApiConstants.guestByID}/$guestID';

      final response =  await _apiService.getRequest(endpoint: endPoint);
      debugPrint("Guest by id response: ${response?.body}");
      /*if(response != null){
        GuestResponse apiResponse = GuestResponse.fromJson(jsonDecode(response.body));
        _guests = apiResponse.data;
        _guests.sort((a, b)=> b.createdAt.compareTo(a.createdAt));
        notifyListeners();
      }*/
    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }

    loadingGuestInfo = false;
    notifyListeners();
    return null;
  }

  Future<bool> addGuest({required Map<String, dynamic> data, bool comingForUpdate = false}) async{
    bool result = false;
    addingGuestVisitor = true;
    notifyListeners();
    try{
      final response = await _apiService.postRequestWithToken(endpoint: comingForUpdate ? ApiConstants.updateGuest : ApiConstants.addGuest, data: data);
      if(response != null){
        result = response.statusCode == 200;
      }
    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }
    addingGuestVisitor = false;
    notifyListeners();
    return result;
  }

  Future<bool> addVisitor({ required Map<String, dynamic> data, bool comingForUpdate = false}) async{
    bool result = false;
    addingGuestVisitor = true;
    notifyListeners();
    try{
      final response = await _apiService.postRequestWithToken(endpoint: comingForUpdate ? ApiConstants.updateVisitor : ApiConstants.addVisitor, data: data);
      if(response != null){
        result = response.statusCode == 200;
      }
    }catch(e){
      debugPrint("Error while adding user in: ${e.toString()}");
    }
    addingGuestVisitor = false;
    notifyListeners();
    return result;
  }

  Future<bool> deleteGuest({required String guestID, bool isVisitor = false}) async {
    bool result = false;
    debugPrint("Delete Api called");
    try {
      String endPoint = '${ApiConstants.deleteGuest}/$guestID';
      if (isVisitor) {
        endPoint = '${ApiConstants.deleteVisitor}/$guestID';
      }

      final response = await _apiService.getRequest(endpoint: endPoint,);
      if(response != null){
        debugPrint("Delete api response: ${response.body}");
        if (response.statusCode == 200) {
          result = true;

          if (isVisitor) {
            Fluttertoast.showToast(msg: "Visitor is removed successfully");
            getAllVisitors();
          } else {
            Fluttertoast.showToast(msg: "Guest is removed successfully");
            getAllGuests();
          }
        }
      }

    } catch (e) {
      debugPrint('Error occurred: $e');
    }
    return result;
  }

  void _initUser()async {
    loadingUserInfo = true;
    notifyListeners();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userName = sharedPreferences.getString("userName") ?? '';
    userID = sharedPreferences.getString("userID") ?? '';

    final String? storedData = sharedPreferences.getString(_verifiedUsersKey);

    if (storedData != null) {
      final List<dynamic> decodedData = json.decode(storedData);
      _verifiedUsers = decodedData
          .map((item) => VerifiedUser.fromJson(item))
          .toList();
    }
    notifyListeners();
  }


  void addUserToVerifiedList(Visitor visitor) async {
    final verifiedUser = VerifiedUser(
      user: visitor,
      logsIn: DateTime.now(),
      logsOut: null,
    );
    _verifiedUsers.add(verifiedUser);
    notifyListeners();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> encodedData =
        _verifiedUsers.map((user) => user.toJson()).toList();
    await sharedPreferences.setString(_verifiedUsersKey, json.encode(encodedData));
  }

  void addGuestToVerifiedList(Guest guest) async {
    final verifiedUser = VerifiedUser(
      user: guest,
      logsIn: DateTime.now(),
      logsOut: null,
    );
    _verifiedUsers.add(verifiedUser);
    notifyListeners();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> encodedData =
        _verifiedUsers.map((user) => user.toJson()).toList();
    await sharedPreferences.setString(_verifiedUsersKey, json.encode(encodedData));
  }
}