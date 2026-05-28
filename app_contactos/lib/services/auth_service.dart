

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_contactos/models/usuario.dart';

class AuthService {
  final String baseUrl = "http://localhost:8081/api/auth";

  Future<Usuario?> login(String username, String password) async{
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        "Content-Type": "application/json",
        },
      body: jsonEncode({"username":username,"password":password}),
    );

    if(response.statusCode ==200){
      return Usuario.fromJson(jsonDecode(response.body));
    }else{
      return null;
    }
  }

  Future<Usuario?> verificarPorUsuario(String usuario) async{
    final response = await http.get(
      Uri.parse('$baseUrl/verificar?usuario=$usuario'),
      headers: {
        'Accept':'application/json',
      }
    );
    if(response.statusCode ==200){
      return Usuario.fromJson(jsonDecode(response.body));
    }else{
      print("Error del servidor: ${response.statusCode}");
      return null;
    }
  }

  Future<Usuario?> newUsuario(String username, String password) async{
    final respuesta = await http.post(
      Uri.parse('$baseUrl/registro'),
      headers: {
        "Content-Type":"application/json",
        "Accept":"application/json",
        },
      body: jsonEncode({"username":username,"password":password}),
    );

    print("Cuerpo que responde el servidor: ${respuesta.body}");
    if(respuesta.statusCode == 200 || respuesta.statusCode==201){
      return Usuario.fromJson(jsonDecode(respuesta.body));
    }else{
      return null;
    }
  }
}