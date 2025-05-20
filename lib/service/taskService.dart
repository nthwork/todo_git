import '../db/db.dart';
import '../model/taskmodel.dart';

enum orderby {
  updateAt,
  endat,
  isdone,
  group_id,
}
class GroupService {

    
  Future<bool> insertTask(Task values)async{
    final db  = await Dbhelper.init.database;
    try{
      var result = await db.insert(
        Task.tbName,
        values.toMap());
      print("insertTask result : $result");
      return true;
    }catch(e){
      print("$e");
      return false;
    }
  }
  //內容查詢
  Future<List<Task>> queryTaskByinfo(
  String? textInput,
  List<int>? groupIDList,
  bool? isDone,
  DateTime? startTime,
  DateTime? endTime,
  orderby orderby,
  bool isAscOrDesc,
  ) async{
    final db = await Dbhelper.init.database;
    List<String> clause = [];
    List<dynamic> args = [];
    final trimmedInput = textInput?.trim();
    void whereClause(){
      if(trimmedInput != null && trimmedInput.isNotEmpty){
        clause.add('(title LIKE ? OR info LIKE ?)');
        args.add("%$textInput%");
        args.add("%$textInput%");
      } 
      if(groupIDList != null){
        if(groupIDList.length == 1){
          clause.add("group_id = ? ");
          args.add(groupIDList.first.toString());
        }else{
          String inClause = '(${List.filled(groupIDList.length,'?').join(',')})';
          clause.add('group_id in $inClause');
          args.addAll(groupIDList.map((e) => e.toString()));
        }

      }
      if(isDone != null){
        clause.add("isDone = ?");
        args.add(isDone ? 1 : 0);
      }
      if(startTime != null){
        final starttimeToSec = startTime.millisecondsSinceEpoch;
        clause.add("updatedAt >= ?");
        args.add(starttimeToSec);
      }
      if(endTime != null){
        final endtimeToSec = endTime.millisecondsSinceEpoch;
        clause.add("endAt <= ?");
        args.add(endtimeToSec);
      }
    }
    try{
      whereClause();
      final whereString = clause.isEmpty ? null : clause.join(' AND ');   
      var result = await db.query(
        Task.tbName,
        where: whereString,
        whereArgs: args.isEmpty? null :args,
        orderBy: "${orderby.name} ${isAscOrDesc ? "ASC" : "DESC"}"
      );
      print("queryTask result: $result");
      return result.map((e) => Task.fromMap(e)).toList();
      
    }catch(e){
      print("$e");
      return [];
    }
  }
  //時間查詢(用於日曆)(周、月)(用於添加範圍限制、限制出現範圍)

  Future<bool> updateTask (Task values) async{
    final db = await Dbhelper.init.database;
    try{
      var result = db.update(
        Task.tbName, 
        values.toMap(),
        where: "id = ?",
        whereArgs: [values.id]
      );
      print("updateTask result: $result ");
      return true;
    }catch(e){
      print("$e");
      return false;
    }
  }
  Future<bool> deleteTask(Task values)async{
    final db = await Dbhelper.init.database;

    try{
      var result = db.delete(
        Task.tbName,
        where: "id = ?",
        whereArgs: [values.id]
      );
      print("deletetask result: $result");
      return true;
    }catch(e){
      print("$e");
      return false;
    }
  }
}