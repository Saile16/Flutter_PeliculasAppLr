import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';


class HomePage extends StatelessWidget {
  
  final peliculasProvider=new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    //iniciamos obteniedo las peliculas populares
    peliculasProvider.getPopulares();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
            )
        ],
      ),
      //el safearea es usado para evitar esos dispositivos con algun bloqueo en la pantalla
      //estilos del celular(como posicion de camara delantera etc,)
      body:Container(
        child: Column(
          //separacion
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context)
          ],
        ),
      )
    );
  }

  Widget _swiperTarjetas() {


    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      //tenemos que especificar que es de tipo listPelicula
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        
        if(snapshot.hasData){
          return CardSwiper(
              peliculas: snapshot.data!,
              );
        } else{
          return Container(
            height: 200.0,
            child: Center(
              child: CircularProgressIndicator()
              )
            );
        }

        
      },
    );
    
    // peliculasProvider.getEnCines();
    // //llamamos al swiper que creamos y enviamos los argumentos
    // return CardSwiper(
    //   peliculas: [1,2,3,4,5],
    // );
    // // return Container();
  }

  Widget _footer(BuildContext context) {
    return Container(
      //para agarrar todo el espacio
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares',style: Theme.of(context).textTheme.subtitle1)
            ),
          SizedBox(height: 5.0),
          //trabajaremos con el stream builder
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            
            // future:peliculasProvider.getPopulares(),
            builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {

                if(snapshot.hasData){
                  return MovieHorizontal(
                    peliculas: snapshot.data!,
                    siguientePagina: peliculasProvider.getPopulares,
                    );
                }else{
                  return Center(child: CircularProgressIndicator());
                }

            },
          ),
        ],
      ),
    );
  }
}