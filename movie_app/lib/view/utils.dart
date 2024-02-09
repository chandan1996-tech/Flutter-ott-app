import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget makeInput(
    {label,
    obsureText = false,
    TextInputType? keyboardType,
    TextEditingController? controller,
    Widget? suffix}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      const SizedBox(
        height: 5,
      ),
      TextField(
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obsureText,
        decoration: InputDecoration(
          suffixIcon: suffix,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(),
          ),
        ),
      ),
      const SizedBox(
        height: 30,
      )
    ],
  );
}

Future<bool> setUserToPrefs(User user) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return await prefs
      .setString("USER_MODEL", jsonEncode(user))
      .whenComplete(() => true)
      .onError((error, stackTrace) => false);
}

Future<User> getUserFromPrefs() async {
  const String placeHolder =
      '{"id":"","userName":"","userNumber":"","userEmail":"","userPassword":""}';
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String storedData = prefs.getString("USER_MODEL") ?? placeHolder;
  final Map<String, dynamic> parsed =
      json.decode(storedData != '' ? storedData : placeHolder);
  return User.fromJson(parsed);
}

void showSnackBar(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(message),
    duration: const Duration(seconds: 2),
    padding: const EdgeInsets.all(12),
  ));
}

dynamic returnResponse(context, http.Response response) {
  switch (response.statusCode) {
    case 200:
      final dynamic responseJson = jsonDecode(response.body);
      return responseJson;
    case 400:
      showSnackBar(context, message: response.body.toString());
      break;

    case 401:
    case 403:
      showSnackBar(context, message: response.body.toString());
      break;
    case 500:
    default:
      showSnackBar(context,
          message:
              'Error occurred while communication with server with status code : ${response.statusCode}');
  }
}
