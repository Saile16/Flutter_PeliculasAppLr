// Generated by https://quicktype.io

//nos servira como conteneodr de peliculas
class Peliculas{

  List<Pelicula> items = [];

  //constructor por el momento vacio
  Peliculas();

  //aca decimos que recibimos una lista de tipo dynamic y lo llamamoos jsonlist
  Peliculas.fromJsonList(List<dynamic> jsonList){

    if (jsonList==null) return;

    //
    for(var item in jsonList){
      //y aqui creamos la instancia de la pelicula
      final pelicula = new Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }
  }
}

class Pelicula {
  String? uniqueId;
  late bool adult;
  late String backdropPath;
  late List<int> genreIds;
  late int id;
  late String originalLanguage;
  late String originalTitle;
  late String overview;
  late double popularity;
  late String posterPath;
  late String releaseDate;
  late String title;
  late bool video;
  late double voteAverage;
  late int voteCount;

  Pelicula({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  Pelicula.fromJsonMap(Map<String,dynamic> json ){
    


    adult             = json['adult'];
    backdropPath      = json['backdrop_path'];
    genreIds          = json['genre_ids'].cast<int>();
    id                = json['id'];
    originalLanguage  = json['original_language'];
    originalTitle     = json['original_title'];
    overview          = json['overview'];
    popularity        = json['popularity']/1;
    posterPath        = json['poster_path'];
    releaseDate        = json['release_date'];
    title             = json['title'];
    video            = json['video'];
    voteAverage      = json['vote_average']/1;
    voteCount        = json['vote_count'];
  }

  getPosterImg(){
    if(posterPath == null){
      return 'https://st4.depositphotos.com/14953852/24787/v/600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg';
    }else{
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
    
  }

  getBackgroundImg(){
    if(posterPath == null){
      return 'https://st4.depositphotos.com/14953852/24787/v/600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg';
    }else{
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
    
  }
}


