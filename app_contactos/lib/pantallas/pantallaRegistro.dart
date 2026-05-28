
import 'package:app_contactos/pantallas/principal.dart';
import 'package:app_contactos/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class PantallaRegistro extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>_PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro>{
  final _newUsuario = TextEditingController();
  final _newPasword = TextEditingController();
  final _authService = AuthService();

  void borrarInputs(){
    _newUsuario.clear();
    _newPasword.clear();
  }

    void _mostrarMensajeConfirmacion(BuildContext context){
    showDialog(context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("!Usuario registrado con éxito¡"),
          actions: <Widget>[
            TextButton(
              onPressed:(){
                Navigator.pushAndRemoveUntil(context, 
                MaterialPageRoute(builder: (context) => const Principal()), 
                (Route<dynamic> route)=>false,
                );
              } , 
              child: const Text("Ok")),
          ],
        );
      }
    );
  }

  void crearCuenta() async{
    final _usuarioVerificado = await _authService.verificarPorUsuario(_newUsuario.text);
    
    if(_newUsuario.text.isEmpty || _newPasword.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Por favor, rellene todos los campos"),backgroundColor: const Color.fromARGB(255, 255, 17, 0),));
    }
      
    if(_usuarioVerificado != null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Este usuario ya existe"),backgroundColor: const Color.fromARGB(255, 255, 17, 0),));
    }else{
      final _cuentaCreada = await _authService.newUsuario(_newUsuario.text, _newPasword.text);
      if(_cuentaCreada != null){
        _mostrarMensajeConfirmacion(context);
      }else{
        print("no se creo");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro",style: TextStyle(fontSize: 20),),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
      ),
      body:Padding(padding: EdgeInsets.all(20),
        child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const CircleAvatar(
                  backgroundColor:const Color.fromARGB(255, 62, 228, 234) ,
                  radius: 80,
                  child: Icon(Icons.person,size: 70,color: Colors.white,),
                  ),
                  SizedBox(height: 30,),
                TextField(controller: _newUsuario,decoration: InputDecoration(labelText: "Nuevo usuario"),),
                TextField(controller: _newPasword,decoration: InputDecoration(labelText: "Contraseña"),obscureText: true,),
                  ],
                ),
                
                ElevatedButton(onPressed:crearCuenta , 
                  child:const Text("Registrarse",style: TextStyle(color: Colors.black),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 62, 228, 234),
                    fixedSize: const Size(200, 50),
                  ),
                  )
              ],
            ),
          ),
        ),
      );
  }

}