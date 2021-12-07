import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate{
  
  String seleccion='';
  //importamos peliculas provider
  final peliculasProvider = new PeliculasProvider();

  final peliculas = [
    'Iron Man',
    'Pelicula2',
    'Pelicula3',
    'Pelicula4',
    'Pelicula5'
  ];
  final peliculasRecientes=[
    'Spiderman',
    'Capitan America'
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    //Son las acciones de nuestro AppBar
    return [
      IconButton(
        onPressed: (){
          //aqui guardamos lo que escribe el usuario
          query='';
        }, 
        icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //Icono a la izquierda del AppBar
    return IconButton(
      onPressed: (){
        close(
          context,
          null
        );
      }, 
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamso a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona está escribiendo

    if(query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future:peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot){
        if(snapshot.hasData){
          final peliculas = snapshot.data;
          return ListView(
            children:peliculas!.map((pelicula){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: (){
                  close(context, null);
                  pelicula.uniqueId='';
                  Navigator.pushNamed(context, 'detalle',arguments: pelicula);
                },
              );
            }).toList()
          );
        } else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      );
    
  }

}

// final listaSugerida = (query.isEmpty) ? peliculasRecientes
//                                           : peliculas.where(
//                                             (p) => p.toLowerCase().startsWith(query.toLowerCase())
//                                             );

    
//     return ListView.builder(
//       itemCount: listaSugerida.length,
//       itemBuilder: (context,i){
//         return ListTile(
//           leading: Icon(Icons.movie),
//           title: Text(listaSugerida.toString()),
//           onTap:(){
//             seleccion=listaSugerida[i];
//             showResults(context);
//           },
//         );
//       }
//       );