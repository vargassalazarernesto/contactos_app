

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_contactos/models/usuario.dart';

class AuthService {
  final String baseUrl = "http://localhost:8080/api/auth";

  Future<Usuario?> login(String username, String password) async{
    try{
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {"Content-Type": "aplication/json"},
      body: jsonEncode({"username":username,"password":password}),
    );

    if(response.statusCode ==200){
      return Usuario.fromJson(jsonDecode(response.body));
    }else{
      return null;
    }
    }catch(e){
      print("Error al conectar $e");
      return null;
    }
  }
}