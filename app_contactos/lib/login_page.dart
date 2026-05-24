
import 'package:app_contactos/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  void _login() async{
    final usuario = await _authService.login(
      _usernameController.text,
      _passwordController.text,
       );

    if(usuario != null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bienvenido ${usuario.username}")));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Usuario o Contraseña incorrecta"),backgroundColor: const Color.fromARGB(255, 255, 17, 0),));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(controller: _usernameController,decoration: InputDecoration(labelText: "Usuario")),
          TextField(controller: _passwordController,decoration: InputDecoration(labelText: "Contraseña"),obscureText: true,),
          ElevatedButton(onPressed: _login, child: Text("Entrar")),
        ],
      ),
      ),
    );
  }
}