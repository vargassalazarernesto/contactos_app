
import 'package:app_contactos/pantallas/pantallaRegistro.dart';
import 'package:app_contactos/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:app_contactos/pantallas/principal.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  void borrarInputs(){
    _usernameController.clear();
    _passwordController.clear();
  }

  void _login() async{
    final usuario = await _authService.login(
      _usernameController.text,
      _passwordController.text,
       );

    if(usuario != null){
      borrarInputs();
      Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context)=>Principal())
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Usuario o Contraseña incorrecta"),backgroundColor: const Color.fromARGB(255, 255, 17, 0),));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 62, 228, 234),
      body: Padding(padding: EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                child: Icon(Icons.person,color: const Color.fromARGB(255, 62, 228, 234),size: 70,),
              ),
              SizedBox(height: 20,),
              const Text("SingIn",style: TextStyle(fontSize: 50,color: Colors.white),),
              const Text("Guarda a tus amigos"),
              SizedBox(height:40),
              TextField(controller: _usernameController,decoration: InputDecoration(labelText: "Usuario"),),
              SizedBox(height: 40,),
              TextField(controller: _passwordController,decoration: InputDecoration(labelText: "Contraseña"),obscureText: true,)
            ],
          ),
        
          ElevatedButton(
            onPressed: _login, 
            child: Text("Entrar",style: TextStyle(color: Colors.black),),
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200,50),
            ),
            ),
          
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const Text("No tienes cuenta?"),
              SizedBox(width: 5,),
              GestureDetector(
                onTap: (){Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>PantallaRegistro()),
                );
                },
                child: Text("Registrate aqui",style:TextStyle(
                  color: const Color.fromARGB(255, 140, 0, 255)
                ),),
              )
            ],
            ),
        ]
        )
      )
      ),
    );
  }
}