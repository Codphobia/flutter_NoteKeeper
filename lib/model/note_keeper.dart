


class NoteKeeper
{
  int? id;
  String title,subTitle,description;

  NoteKeeper({this.id, required this.title, required this.subTitle, required this.description});


  Map<String, dynamic> toMap()
  {
    Map<String , dynamic> map={};
    if(id!=null)
      {
        map['id']=id;

      }
    map['title']=title;
    map['subTitle']=subTitle;
    map['description']=description;
    return map;
  }
  static NoteKeeper fromMap( Map<String, dynamic> map)
  {
    return NoteKeeper(id :map['id'],title: map['title'], subTitle: map['subTitle'], description: map['description']);
  }

}