
class Task{

  
  static const tbName = "tasks";

  final int? id;
  final String title;
  final String? info;
  final bool? isDone;
  final int? doneAt;
  final int? group_id;
  final String updatedAt;

  Task({this.id,required this.title,this.info,this.group_id, this.isDone,this.doneAt,required this.updatedAt});
  
  Map<String,dynamic> toMap(){
    return{
      if (id != null) 'id': id,
      "title": title,
      "info": info ,
      'isDone': isDone ?? false,
      'doneAt': doneAt,
      "group_id": group_id ?? 0,
      
    };
  }
    Map<String, dynamic> toMapForUpdate() {
    return {
    'title': title,
    'info': info ,
    'isDone': isDone ?? false ,
    'doneAt': doneAt,
    "group_id": group_id ?? 0
    };
  }
  factory Task.fromMap(Map<String, dynamic> map){
    return Task(
      id: map["id"] as int?,
      title: map['title'] as String,
      info: map['info'] as String?,
      isDone: map['isDone'] as bool,
      doneAt: map['doneAt'] as int?, 
      group_id: map['group_id']  as int?,
      updatedAt: map['updatedAt'] as String,
    );
  }



}