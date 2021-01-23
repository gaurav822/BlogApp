import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),

      drawer: _drawer(),
    );
  }

  Widget _drawer(){
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            
            accountName:  Text("Gaurav Dahal"), 
            accountEmail: Text("gauravdahal53@gmail.com")
            ),

            _listTile(licon: Icon(Icons.cake),title: "First Option"),
            _listTile(licon: Icon(Icons.search),title: "Second Option"),
            _listTile(licon: Icon(Icons.cached),title: "Third Option"),
            _listTile(licon: Icon(Icons.menu),title: "Fourth Option"),

            Divider(
              height: 10,
              color: Colors.black,
            ),

            _listTile(
              ticon: Icon(Icons.close),
            title: "Close",
            function: (){
              Navigator.of(context).pop();
            }
            ),

        ],
      ),
    );
  }

  Widget _listTile({String title, Icon licon, Icon ticon, Function function}){
    return ListTile(
      title: Text(title),
      leading: licon,
      trailing: ticon,
      onTap: function,
  
    );
  }

  Widget _appBar(){
    return AppBar(
      backgroundColor: Colors.lightBlue,
      title: Text("Flutter Blog App"),
      actions: [
       _iconButton(
         icon: Icon(Icons.search),
         onPressed: _searchBlog
       ),
       _iconButton(
         icon: Icon(Icons.add),
         onPressed: _addnewBlog
       ),
      ],
    
    );
  }

  Widget _iconButton({Icon icon, Function onPressed}){
     return IconButton(
       icon: icon, 
       onPressed: onPressed
       );
  }

  _searchBlog(){
    Fluttertoast.showToast(msg: "Search");
  }

  _addnewBlog(){
    Fluttertoast.showToast(msg: "Add");
  }
}