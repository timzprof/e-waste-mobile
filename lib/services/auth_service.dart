import 'package:dio/dio.dart';
import 'package:ewaste/models/user.dart';
import 'package:ewaste/services/client.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future register(
    {required String name,
    required String email,
    required String sensorId,
    required String password,
    String? businessName}) async {
  try {
    var data = {
      "name": name,
      "email": email,
      "password": password,
      "sensorId": sensorId
    };

    Response response = await client.post("/register-user", data: data);

    if (response.statusCode == 200) {
      print("User Registered: ${response.data}");
      return response.data;
    }
  } catch (err) {
    print('Error registering user: $err');
    if (err is DioException) {
      handleAPIError(err);
    } else {
      rethrow;
    }
  }
}

Future<User?> authenticate(
    {required String email, required String password}) async {
  try {
    String? token = "";

    try {
      token = await FirebaseMessaging.instance.getToken();
    } catch (error) {
      print("Failed to get Firebase token: $error");
    }

    var data = {
      "email": email,
      "password": password,
      "messagingToken": "$token"
    };

    Response response = await client.post("/login", data: data);

    if (response.statusCode == 200) {
      print("User Authenticated: ${response.data}");
      return User.fromJson(response.data['data'], firebaseToken: "$token");
    }
  } catch (err) {
    print('Error authenticating user: $err');
    if (err is DioException) {
      handleAPIError(err);
    } else {
      rethrow;
    }
  }
  return null;
}
