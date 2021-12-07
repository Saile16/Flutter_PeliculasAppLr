import 'dart:convert';

class Cast{
  List<Actor> actores =  [];

  Cast.fromJsonList(List<dynamic> jsonList ){
    if(jsonList == null) return;

    jsonList.forEach((item) {

      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
     });
  }
}

class Actor {
  bool? adult;
  int? gender;
  int? id;
  Department? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;
  Department? department;
  String? job;

  Actor({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  //necesitamos un metodo para recivir la informacion en un mapa y asignar cada una de esas propiedades
  //a las propiedades de la clase y a la vez crear una instancia de actor
  Actor.fromJsonMap(Map<String,dynamic> json){
    this.adult               = json['adult'];
    this.gender              = json['gender'];
    this.id                 = json['id'];
    this.knownForDepartment   = json['known_fordepartment'];
    this.name               = json['name'];
    this.originalName       = json['originalName'];
    this.popularity         = json['popularity'];
    this.profilePath        = json['profile_path'];
    this.castId             = json['cast_id'];
    this.character          = json['character'];
    this.creditId           = json['creditId'];
    this.order              = json['order'];
    this.department         = json['department'];
    this.job                = json['job'];
  }

  getFoto(){
    if(profilePath == null){
      return 'https://image.shutterstock.com/image-vector/avatar-vector-male-profile-gray-260nw-538707355.jpg';
    }else{
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
    
  }
}

enum Department { ACTING, CREW, COSTUME_MAKE_UP, WRITING, PRODUCTION, SOUND, DIRECTING, CAMERA, LIGHTING, ART, EDITING, VISUAL_EFFECTS }
