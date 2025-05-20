import '../db/db.dart';
import '../model/groupmodel.dart';

class GroupService  {


  Future<bool> InsertGroup(Group values) async{
    final db = await Dbhelper.init.database;
    try{
      var result =  await db.insert(Group.tbName, values.toMap());
      String answer = "insert result : $result";
      print(answer);
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<List<Group>> queryGroup({
    String name ='',
    List<String>? gcolorlist,
    bool groupByColor = false
    }) async{
    final db = await Dbhelper.init.database;
    gcolorlist ??= ["#7C586B"];

    try{
      String inClause = '(${List.filled(gcolorlist.length, '?').join(', ')})';
      String whereClause = name.isEmpty
          ? 'gColor IN $inClause'
          : 'gColor IN $inClause AND name LIKE ?';
      List<Object> whereArgs = name.isEmpty
        ? gcolorlist
        : [...gcolorlist, '%$name%'];
      var result = await db.query(
        Group.tbName,
        where: whereClause,
        whereArgs: whereArgs,
        groupBy: groupByColor ? "gColor" : null);
        String answer = "query result : $result";
        print(answer);
        return result.map((e)=> Group.fromMap(e)).toList();
    }catch(e){
      print(e);
      return [];
    }
  }
  Future<bool> UpdateGroup(Group values) async{
    final db = await Dbhelper.init.database;
    try{
      var result = await db.update(
        Group.tbName, 
        values.toMapForUpdate(),
        where: "id = ?",
        whereArgs: [values.id]);
        String answer = "update result: $result";
        print(answer);
        return true;
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<bool> DeleteGroup(Group values) async{
    final db = await Dbhelper.init.database;
    try{
      var result = await db.delete(
        Group.tbName,
        where: "id = ?",
        whereArgs: [values.id]
      );
      String answer = "delete result: $result";
      print(answer);
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }
}
