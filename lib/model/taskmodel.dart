
class Task{

  
  static const tbName = "tasks";

  final int? id;
  final int? group_id;
  final String title;
  final String? info;
  final bool? isDone;
  final int? doneAt;
  final int? endAt;
  final int updatedAt;

  Task({
    this.id,
    required this.title,
    this.info,this.group_id = 1,
    this.isDone = false,
    this.doneAt,
    this.endAt,
    int? updatedAt}):updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch;
  
  Map<String,dynamic> toMap(){
    return{
      if (id != null) 'id': id,
      "title": title,
      "info": info ,
      'isDone': isDone ?? false,
      'doneAt': doneAt,
      'endAt' : endAt,
      "group_id": group_id ?? 0,
      'updatedAt': updatedAt,
      
    };
  }
  factory Task.fromMap(Map<String, dynamic> map){
    return Task(
      id: map["id"] as int?,
      title: map['title'] as String,
      info: map['info'] as String?,
      isDone: map['isDone'] as bool,
      doneAt: map['doneAt'] as int?, 
      endAt: map['endAt'] as int,
      group_id: map['group_id']  as int?,
      updatedAt: map['updatedAt'] as int,
    );
  }



}