import 'dart:convert';
import 'dart:io';
import 'package:smartparking/api/constant.dart';
import 'package:smartparking/models/api_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:smartparking/models/auth_user_model.dart';
import 'package:smartparking/services/auth_service.dart';

Future<ApiResponse> updateProfile({
  String? nombre1,
  String? nombre2,
  String? apellido1,
  String? apellido2,
  String? celular,
  File? rutaFotoFile,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    Map<String, dynamic> requestBody = {};

    if (nombre1 != null) requestBody["nombre1"] = nombre1;
    if (nombre2 != null) requestBody["nombre2"] = nombre2;
    if (apellido1 != null) requestBody["apellido1"] = apellido1;
    if (apellido2 != null) requestBody["apellido2"] = apellido2;
    if (celular != null) requestBody["celular"] = celular;
    if (rutaFotoFile != null) requestBody["rutaFotoFile"] = rutaFotoFile;

    //print('2 $requestBody');

    http.Response response = await http.post(Uri.parse(urlUpdateProfile),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: requestBody);

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 500:
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

Future<ApiResponse> updatePhotoProfile({
  File? rutaFotoFile,
}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();

    var request = http.MultipartRequest('POST', Uri.parse(urlUpdateProfile));

    if (rutaFotoFile != null) {
      var fileStream = http.ByteStream.fromBytes(rutaFotoFile.readAsBytesSync());
      var length = await rutaFotoFile.length();
      var multipartFile = http.MultipartFile('rutaFotoFile', fileStream, length,
          filename: rutaFotoFile.path.split('/').last);
      request.files.add(multipartFile);
    }

    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    var response = await request.send();

    var responseString = await response.stream.bytesToString();

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(responseString));
        break;
      case 422:
        final errors = jsonDecode(responseString)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];

        break;
      case 401:

        break;
      case 403:
        apiResponse.error = jsonDecode(responseString)['message'];

        break;
      case 500:
        apiResponse.error = jsonDecode(responseString)['message'];
     
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

