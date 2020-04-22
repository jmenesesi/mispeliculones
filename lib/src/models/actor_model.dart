class Cast {

  List<Actor> items = new List();

  Cast();

  Cast.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    for ( var item in jsonList  ) {
      final actor = new Actor.fromJsonMap(item);
      items.add( actor );
    }

  }

}

class Actor {
  int id;
  int castId;
  String creditId;
  int gender;
  String name;
  int order;
  String profilePath;
  String character;
  

  Actor({
    this.id,
    this.castId,
    this.creditId,
    this.gender,
    this.name,
    this.order,
    this.profilePath,
    this.character,
  });

  Actor.fromJsonMap( Map<String, dynamic> json ) {
    id               = json['id'];
    castId            = json['cast_id'];
    creditId      = json['credit_id'];
    gender            = json['gender'];
    name       = json['name'];
    order       = json['order'];
    profilePath = json['profile_path'];
    character    = json['character'];
  }

  getProfileImage() {
    if(profilePath == null) {
      return "https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png";  
    } else {
      return "https://image.tmdb.org/t/p/w500/$profilePath";
    }
  }

}


