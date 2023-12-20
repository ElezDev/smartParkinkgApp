import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:smartparking/api/constant.dart';
import 'package:smartparking/models/api_response_model.dart';
import 'package:smartparking/models/auth_user_model.dart';
import 'package:smartparking/models/user_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// login
Future<ApiResponse> login(String email, String contrasena) async {
  ApiResponse apiResponse = ApiResponse();
  SharedPreferences pref = await SharedPreferences.getInstance();
  //String? tokenApp = pref.getString('tokenApp');

  try {
    final response = await http.post(
      Uri.parse('${baseURL}login_user'),
      headers: {'Accept': 'application/json'},
      body: {
        'email': email,
        'contrasena': contrasena,
      },
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}
//registro de usuario
Future<ApiResponse> register(
    String name,
    String lastName,
    String typeDocument,
    String numberDocument,
    String email,
    String contrasena,
    String numberPhone) async {
  ApiResponse apiResponse = ApiResponse();

  SharedPreferences pref = await SharedPreferences.getInstance();
  String? tokenApp = pref.getString('tokenApp');

  try {
    final response = await http.post(Uri.parse(registerURL), headers: {
      'Accept': 'application/json'
    }, body: {
      'nombre1': name,
      'apellido1': lastName,
      'idTipoIdentificacion': typeDocument,
      'identificacion': numberDocument,
      'email': email,
      'contrasena': contrasena,
      'celular': numberPhone,
      'device_token': tokenApp
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}
//logout borrar token
Future<ApiResponse> logout() async {
  ApiResponse apiResponse = ApiResponse();
  String token = await getToken();
  try {
    final response = await http.post(Uri.parse(logoutUrl),
        headers: {'Authorization': 'Bearer $token'});

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}

Future<ApiResponse> getUserDetail() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(userURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// get token
Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}

// get user id
Future<int> getUserId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('userId') ?? 0;
}

// Get base64 encoded image
String? getStringImage(File? file) {
  if (file == null) return null;
  return base64Encode(file.readAsBytesSync());
}

Future<ApiResponse> getProfile() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse('${baseURL}user_data'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = UserData.fromJson(jsonDecode(response.body));
        break;
      case 401:
        apiResponse.error = 'Unauthorized';
        break;
      default:
        apiResponse.error = 'Something went wrong';
        break;
    }
  } catch (e) {
    apiResponse.error = 'Server error';
  }

  return apiResponse;
}
