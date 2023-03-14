import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseUrl = dotenv.env['baseUrl'];
final loginApi = '$baseUrl/user/login';
final changeNameApi = '$baseUrl/user/update/nickname/';
final userInfoApi = '$baseUrl/user/userinfo';
