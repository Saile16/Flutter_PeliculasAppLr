import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;

  CardSwiper({ required this.peliculas});

  @override
  Widget build(BuildContext context) {

      //vamos a cambiar el tamaño de las tarjetas de acuerdo al tamaño del dispositivo
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 5.0),
    
      child: Swiper(
        layout: SwiperLayout.STACK,
          //decimos el 70% de largo
        itemWidth: _screenSize.width*0.7,
        itemHeight: _screenSize.height*0.5,
        itemBuilder: (BuildContext context,int index){
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(
                peliculas[index].getPosterImg()
              ),
              placeholder: AssetImage('assets/img/loading.gif'),
              fit: BoxFit.cover,
            ),
            //new Image.network("http://via.placeholder.com/350x150",fit: BoxFit.cover),
          );
          
        },
        //la cantidad en la lista 
        itemCount: peliculas.length,
        //para obtener la paginacion y las flechas de control
        // pagination:  SwiperPagination(),
        // control:  SwiperControl(),
        ),
    );
  }
}