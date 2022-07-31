class ModelPass{
  int? id;
  String? title;
  String? pass;
  // ModelPass({ this.title, this.pass});
  // Map<String,dynamic>toMap(){
  //   return ({
  //     'id':id,
  //     'title':title,
  //     'pass':pass
  //   });
  // }
  passwordMap(){
    var mapping=Map<String,dynamic>();
    mapping['id']=id??null;
    mapping['title']=title!;
    mapping['pass']=pass!;
    return mapping;

  }
}