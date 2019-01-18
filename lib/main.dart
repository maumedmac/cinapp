//importando la libreria de diseño Material
import 'package:flutter/material.dart';
//Metodo principal
void main()=> runApp(
  //Metodo material
  MaterialApp(
    //Barra en modo debug inhabilitada
    debugShowCheckedModeBanner: false,
    //Nombre de la App
    title: "Cine App",
    //Tema de estilo de la App
    theme: ThemeData.dark(),
    //Llamando el widget principal
    home: Cinapp(),
  )
);

// Creamos el widget principal a partir
// del StatefulWidget o widget con estado
class Cinapp extends StatefulWidget{
  @override
  // Creamos un widget estado
  _Cinapp createState() => new _Cinapp();

}
//Creamos un widget estado 
class _Cinapp extends State<Cinapp>{
  @override
    // Creamos nuestro widget contructor y le pasamos el contexto
    Widget build(BuildContext context) {
      // Retornamos un Scaffold que es una forma de organizar 
      // nuestra aplicacion, este esta compuesto por appbar, body entre
      // otros elementos que nos permite situarnos en la app
      return Scaffold(
        // appBar es la barra superior de la app donde ponemos
        // un texto que nos identifique donde estamos y podemos 
        // poner un icono que faxilite la navegaxion
        appBar: AppBar(
          // Un atributo de la appBar es el title que seria el titulo
          // este mismo puede incluir alineacion, texto e iconos. 
          // Aca le enviamos un widget texto 
          title: Text(
            // como atributo le pasamos una cadena de caracteres
            "Cine App",
            // dendro del widget testo le agregamos el atributo de
            // estilo TextStyle y dentro declaramos los atributos
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold
              ), 
        ),
        // Este atributo los elementos de la appBar centreados
        centerTitle:true,
        elevation: 0.0,
        // Este atributo incluye en tu widget otros widgets con estados
        leading: IconButton(
          // Lr agreagamos un icono y por defecto tendra una accion
          icon: Icon(Icons.menu), 
          onPressed: () {   
          },
        ),
      ),
      );
    }
}
