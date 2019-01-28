//importando la librerias
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/movieModel.dart';
// agregamos a las dependenccias para poder usar la 
// biblioteca 
// dependencies:
//   carousel_slider: ^1.0.1 
import 'package:carousel_slider/carousel_slider.dart';

// constante con el link raiz de informacion
const baseUrl = "https://api.themoviedb.org/3/movie/";

// constante con el link raiz de las imagenes
const baseImagesUrl = "https://image.tmdb.org/t/p/";

// constante con la llave apikey para identificarnos con el API
const apiKey = "e5f70b25f779797e7d9106a4dcbaeb85";

// constante de peliculas en proyeccion
const nowPlayingUrl = "${baseUrl}now_playing?api_key=$apiKey";

//Metodo principal
void main() => runApp(

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
    ));


// Creamos el widget principal a partir
// del StatefulWidget o widget con estado
class Cinapp extends StatefulWidget {
  @override

  // Creamos un widget estado
  _Cinapp createState() => new _Cinapp();
}

//Creamos un widget estado
class _Cinapp extends State<Cinapp> {
  
  // Creamos un objeto Movie para guardar los resultados de la
  // pagina moviedb
  Movie nowPlayingMovies;
  @override

  // Llamamos al metodos initState para iniciar el procesp antes
  // que la aplicacio corra
  void initState() {
    // TODO: implement initState

    // llama a su clase padre
    super.initState();

    // llamamos los resultados del sitio web
    _fetchNowPlayingMovies();
  }

  // creamos un metodo que llame los resultados del sitio web
  // de forma asincrona para que no detenga el funcionamiento
  // de la app y que se cargue en segundo plano
  void _fetchNowPlayingMovies() async {

    // solicitamos que guarde resultados en response y que a
    // su vez tenga una espera por ellos
    var response = await http.get(nowPlayingUrl);

    // decodificamos el JSON que nos devuelve el sitio
    var decodeJson = jsonDecode(response.body);

    // Guardamos el resultado en la variable nowPlayingMovies
    // devolviendo una lista de objetos que son convertidos a
    // atributos de la case Result por medio de la clase Movie
    setState(() {
      nowPlayingMovies = Movie.fromJson(decodeJson);
      //print(decodeJson);
    });
  }
  //  Creamos un metodo para cargar el Carousel
  //  Este tiene como parametro una lista de items 
  //  encansulapdo la creacion del objeto que se 
  //  cargara desde build usando el formato
  //  Arrow function var=> Objeto de retorno
  Widget _buildCaruoselSlider() => CarouselSlider(

        // Enviamos el parametro items que esta en el link
        // nowPlayingMovies y retornamos el array results
        // por el metodo map recorrio por la varieble
        // movieItem y volvemos a retornar los objetos
        // como una lista con Arrow function
        items: nowPlayingMovies == null ? Center(child: CircularProgressIndicator(),) : 
              nowPlayingMovies.results  .map((movieItem) =>
    
            // Image.networks al que le enviamos el link
            // con la dimension y la concatenacion del
            // nombre del archivo   
                Image.network("${baseImagesUrl}w500${movieItem.posterPath}"))
            .toList(),
    
        // No queremos que no se reproduzca solo
        autoPlay: true,
        initialPage: 0,
        interval: const Duration(seconds: 6),
        autoPlayCurve: Curves.elasticIn,
    
        // Altura de carrousel
        height: 300.0,
        // distancia entre imagenes
        viewportFraction: 0.6,
      );

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
              color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
        ),

        // Este atributo los elementos de la appBar centreados
        centerTitle: true,
        elevation: 0.0,

        // Este atributo incluye en tu widget otros widgets con estados
        leading: IconButton(

          // Le agreagamos un icono y por defecto tendra una accion
          // onpressed
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),

        // actions le agrega anuestro boton una coleccion de widgets
        actions: <Widget>[

          // El widget IconButton es un boton al que le asignamos un icono
          // que necesita unaaccion onpressed
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
          /*,
          IconButton(icon: Icon(Icons.photo),
          onPressed: (){
          },
          ),
          IconButton(icon: Icon(Icons.chat),
          onPressed: (){
          },
          ),
          IconButton(icon: Icon(Icons.gps_fixed),
          onPressed: (){
          },
          )
          */
        ],
      ),

      // implementamos el Body del scafold con un NestedScrollView
      // que nos permite varios widgets que anidan otros Scrolss
      body: NestedScrollView(

        //  nuesto eidget necesita el headerSliverBuilde con los
        //  parametros (BuildContext context, bool innerboxScrolled) 
        headerSliverBuilder: (BuildContext context, bool innerboxScrolled) {

          // retorna una lista de widgets
          return <Widget>[

            // dentro de nuestra lista de widgets le agregamos 
            // SliverAppBar que nos permite recorrer los elementos
            // bajo el carrusel para que nuestro carrusel se oculte 
            // o vuelva ala pantalla
            SliverAppBar(

              // parametro titulo del carusel centro un widget center
              title: Center(

                // dentro de center creamos un child para poder darle
                // un passig inferior
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),

                  // y dentro de otro child metemos el Texto con
                  // Formato
                  child: Text("En Sala",
                      style:
                          TextStyle(color: Colors.grey[100], fontSize: 12.0)),
                ),
              ),

              // tamaño maximo de la SliderBar
              expandedHeight: 400.0,
              floating: false,
              pinned: true,

              // Desplegado del Carousel con FlexibleSpaceBar
              flexibleSpace: FlexibleSpaceBar(

                // le damos una imagen de fondo y na superpuestas
                // con una stack
                background: Stack(

                  // una stack puede tener multiples hijos
                  children: <Widget>[

                    // dentro un contenedor le damos un hijo
                    // que contenga la imagen
                    Container(
                      child: Image.network(
                        "${baseImagesUrl}w780/5Ka49BWWyKMXr93YMbH5wLN7aAM.jpg",

                        // hacemos encajar en el contenedor
                        fit: BoxFit.cover,
                        // le damos un ancho
                        width: 1000.0,
                        colorBlendMode: BlendMode.dstATop,
                        // y le damos un color de fondo con
                        // opacidad
                        color: Colors.blue.withOpacity(0.5),
                      ),
                    ),

                    // Insertamos en carousel dentro un padding
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0),
                      // un hijo con una columna con mas hijos
                      child: Column(

                        // los hijos contienen a los elementos de carousel
                        children: nowPlayingMovies == null ? 
                          <Widget>[
                            Center(child: CircularProgressIndicator(),)
                          ]: <Widget>[_buildCaruoselSlider()],
                      ),
                    )
                  ],
                ),
              ),
            )
          ];
        },
        // devolvemos un body con un texto centreado
        body: Center(child: Text("Look")),
      ),
    );
  }
}
