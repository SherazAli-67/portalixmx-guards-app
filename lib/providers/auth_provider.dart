import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portalixmx_guards_app/generated/app_localizations.dart';
import 'package:portalixmx_guards_app/res/app_constants.dart';
import 'package:portalixmx_guards_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../res/api_constants.dart';

class AuthProvider extends ChangeNotifier{
  final _apiService = ApiService();

  bool _isLogging = false;
  bool _isVerifyingOTP = false;

  bool get isLogging  => _isLogging;
  bool get isVerifyingOTP  => _isVerifyingOTP;

  Future<bool> onLoginTap({required String email, required String password, required BuildContext context}) async {
    bool result = false;
    _isLogging = true;
    notifyListeners();

    final data = {
      'username' : email,
      'password' : password
    };
    try{
      final response =  await _apiService.postRequest(endpoint: ApiConstants.loginEndPoint, data: data);
      debugPrint("Login api response: ${response.body}");
      final responseMap = jsonDecode(response.body);
      bool status = responseMap['status'] ?? false;

      if(status){
        final Map<String,dynamic> map = jsonDecode(response.body)['data']['token']!;
        String role = map['role'];
        // bool isGuard = role =='guards';
        bool isGuard = true;
        if(isGuard){
          result = true;
          String token = map['token'];
          String userID = map['userId'];
          String userName = map['name'];

          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          await sharedPreferences.setString("token", token);
          await sharedPreferences.setString("userID", userID);
          await sharedPreferences.setString("userName", userName);

        }else{
          Fluttertoast.showToast(msg: AppLocalizations.of(context)!.invalidLoginCredentialsMessage);
        }
      }else{
        Fluttertoast.showToast(msg: AppLocalizations.of(context)!.invalidLoginCredentialsMessage);
      }


    }catch(e){
      String errorMessage = e.toString();
      if(e is SocketException){
        errorMessage = AppConstants.noInternetMsg;
      }

      Fluttertoast.showToast(msg: errorMessage);
    }

    _isLogging = false;
    notifyListeners();
    return result;
  }

  Future<bool> onVerifyOTPTap({required String otp,}) async{
    bool result = false;
    _isVerifyingOTP = true;
    notifyListeners();
    final data = {'otp' : otp};
    try{
      final response = await _apiService.postRequestWithToken(endpoint: ApiConstants.verifyOTPEndPoint, data: data,);
      if(response != null){
        result = jsonDecode(response.body)['status'];
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.setBool('isLoggedIn', true);
      }
    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }

    _isVerifyingOTP = false;
    notifyListeners();
    return result;
  }
}