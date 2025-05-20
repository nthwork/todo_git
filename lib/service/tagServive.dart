import 'package:nthtodolist/model/taskmodel.dart';

import "../db/db.dart";
import '../model/tagmodel.dart';
enum tagSortOption{
    name,
    color,
    none
}
class TagService {

    Future<bool> insertTask(Tag values) async{
        final db = await Dbhelper.init.database;
        try{
            var result  = await db.insert(
                Tag.tbName, 
                values.toMap()
            );
            print("insertTag result: $result");
            return true;
        }catch(e){
            print("$e");
            return false;
        }
    }
    Future<bool> deleteTask(Tag values) async{
        final db = await Dbhelper.init.database;
        try{
            var result = await db.delete(
                Task.tbName,
                where: "id = ?",
                whereArgs: [values.id]
            );
            print("deleteTag result: $result");
            return true;
        }catch(e){
            print("$e");
            return false;
        }
    }

    Future<bool> updateTag(Tag values) async{
        final db = await Dbhelper.init.database;
        try{
            var result = await db.update(
                Task.tbName, 
                values.toMap(),
                where: "id = ?",
                whereArgs: [values.id]
            );
            print("updateTag result: $result");
            return true;
        }catch(e){
            print("$e");
            return false;
        }
    }
    Future<List<Tag>> queryTag(
    int? id,
    String? color,
    String? name,
    tagSortOption sortOption,
    bool isAscOrDesc,
    )async{
        List<String> clause =[];
        List<dynamic> args = []; 
        void clauseBuilder(){
            if(id != null){
                clause.add('id = ?');
                args.add(id);
            }
            if(color != null){
                clause.add(' color = ? ');
                args.add(color);
            }
            if(name != null){
                clause.add(" name LIKE ?");
                args.add("%$name%");
            }
        }
        String orderby(){
            switch(sortOption){
                case tagSortOption.none :
                    return "null";
                case tagSortOption.name:
                    return "name";
                case tagSortOption.color:
                    return "color";
            }
        }
        try{
            clauseBuilder();
            final whereString = clause.join(" AND ");
            final db = await Dbhelper.init.database;
            
            final result = await db.query(
                Tag.tbName,
                where: whereString,
                whereArgs: args,
                orderBy: "${orderby()} ${isAscOrDesc ? "ASC":'DESC'}",
            );
            print('quertTag result: $result');
            return result.map((e) => Tag.fromMap(e)).toList();
        }catch(e){
            print("$e");
            return [];
        }
    }

}