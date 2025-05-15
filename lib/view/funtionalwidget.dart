import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nthtodolist/VM/UIVM.dart';

class ButtonList extends StatelessWidget{
  VoidCallback openEndDrawer ;
  ButtonList({super.key,required this.isOpen,required this.openEndDrawer});

  bool isOpen ;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height*0.125,
      right: MediaQuery.of(context).size.width*0.025,
      child: AnimatedOpacity(
        opacity: isOpen ? 1.0 : 0.0,
        duration: Duration(milliseconds: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: "btn1",
              onPressed: () {
                Navigator.pushNamed(context, "/clander");
              },
              mini: true,
              child: Icon(Icons.task),
            ),
            SizedBox(height: 10),
            FloatingActionButton(
              heroTag: "btn2",
              onPressed: () {
                Navigator.pushNamed(context, "/tasklist");
              },
              mini: true,
              child: Icon(Icons.note),
            ),
            SizedBox(height: 10),
            FloatingActionButton(
              heroTag: "btn3",
              onPressed: () {
                openEndDrawer();
              },
              mini: true,
              child: Icon(Icons.event),
            ),
          ],
        ),
      )
    );
  }
}

class FAB extends StatelessWidget{
  int nowPage ; 
  FAB({required this.nowPage});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
            context: context, 
            builder: (context) => AddTaskDiolog(),
          );
        },
        onDoubleTap: () {
          Provider.of<UIVM>(context, listen: false).toggleButtonList();
        },
        child: FloatingActionButton(
        onPressed: null,
        child: const Icon(Icons.add),
        ),
    );
  }
}

class AddTaskDiolog extends StatefulWidget{
  AddTaskDiolog({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddTaskDialogState();
  }
}
class _AddTaskDialogState extends State<AddTaskDiolog>{
    
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("新增任務"),
      content: Text("這裡放置任務列表"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text("取消")
        ),
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text("確認輸入")
        )
      ],
    );
  }
}


class AddGroupDiolog extends StatefulWidget{
  AddGroupDiolog({super.key});
  @override
  State<StatefulWidget> createState() {
    return _AddGroupDialogState();
  }
}
class _AddGroupDialogState extends State<AddGroupDiolog>{
    
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("新增群組"),
      content: Text("這裡放置任務列表"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text("取消")
        ),
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text("確認輸入")
        )
      ],
    );
  }
}

class DrawerWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "群組清單",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: Icon(Icons.circle),
                  title: Text("群組一"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.change_circle_outlined),
                      Icon(Icons.delete),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context, 
                      "/group" ,
                      arguments: {'groupName': '群組一'}
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.circle),
                  title: Text("群組二"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.change_circle_outlined),
                      Icon(Icons.delete),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context, 
                      "/group" ,
                      arguments: {'groupName': '群組二'}
                    );
                  },
                ),
              ],
            ),
          ),
          Divider(),
          ElevatedButton(
            onPressed: (){
                showDialog(
                  context: context, 
                  builder: (context) => AddGroupDiolog(),
                );
            }, 
            child: Text("新增群組"))
        ],
      ),
    );
  }
} 
