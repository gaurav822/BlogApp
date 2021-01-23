import 'dart:ffi';

import 'package:BlogApp/Models/blogmodels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:progress_dialog/progress_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  TextEditingController titleController= TextEditingController();
  TextEditingController shortdetailController= TextEditingController();
  TextEditingController briefdetailController= TextEditingController();
  String helperText="Max Length Reached";
  bool isSearching=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: _appBar(),

      drawer: _drawer(),

      body: _body(),
    );
  }


  Widget _body(){
    // return Container(
    //   decoration: BoxDecoration(
    //     gradient: LinearGradient(colors: [Colors.deepPurple[700],Colors.purple[500],],
    //     begin: const FractionalOffset(0.5, 0.0),
    //     end: const FractionalOffset(0.0, 0.5),
    //     stops: [0.0,1.0])
    //   ),
    //   child: ListView(
    //     children: [
    //       for(int i=0;i<50;i++) _card()
    //     ],
    //   )
    //   );
    return Ink(
      color: Colors.amber,
        child: SizedBox(

        width: Get.width,
        
        height: Get.height,
        child: StreamBuilder(
          stream: firebaseFirestore.collection("BlogPosts").snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
            List<QueryDocumentSnapshot> qdocsnap= snapshot.data.docs;
            
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: qdocsnap.length,
                itemBuilder: (ctx,index){
                  return Container(
                  decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.deepPurple[700],Colors.purple[500],],
                  begin: const FractionalOffset(0.5, 0.0),
                  end: const FractionalOffset(0.0, 0.5),
                  stops: [0.0,1.0])
                ),
                child: _card(BlogModel(
                  title: qdocsnap[index]['title'], 
                  shortdesC: qdocsnap[index]['shortdetail'], 
                  briefDesc: qdocsnap[index]['briefdetails'],
                  postedDate: qdocsnap[index].reference.id
                  ),
    
                  
                  ),
               );
                    
                },
              );
            }
            
            return SizedBox();

          },
        ),
        
      ),
    );
  }

  Widget _card(BlogModel blogModel){
    return GestureDetector(
          onTap: (){
            // Navigator.push(context, MaterialPageRoute(builder: (context)=> BlogDetailsPage()));
            Navigator.pushNamed(context, "/detailedPage",arguments: blogModel);
          },
          child: Container(
        margin: EdgeInsets.all(10),
        height: Get.height*.2,
        child: Card(
          color: Colors.purple.shade200,
          child: Row(
        
              children: [
                Image.asset("assets/gaurav.png",
                width: 100,
                height: 60,),
                Flexible(
                                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Text(blogModel.title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                  SizedBox(
                    height: 10,
                  ),
                  Text(blogModel.shortdesC,style: TextStyle(color: Colors.white),),
                  
              ],
            ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawer(){
    return !isSearching?Drawer(

      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            
            accountName:  Text("Gaurav Dahal"), 
            accountEmail: Text("gauravdahal53@gmail.com"),
            currentAccountPicture: Image.asset("assets/gaurav.png"),
            
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
    ):
    SizedBox();
  }

  Widget _listTile({String title, Icon licon, Icon ticon, Function function}){
    return ListTile(
      title: Text(title),
      leading: licon,
      trailing: ticon,
      onTap: function,
  
    );
  }

  Widget _searchAppBar(){
    return AppBar(
      backgroundColor: Colors.blue,
       leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed:(){
         this.isSearching=!this.isSearching;
         setState(() {
           
         });
       } ,),
      title: _searchBarTitle()
    );
  
  }

  Widget _searchBarTitle(){
    return SizedBox(
      height: Get.height*.06,
      width: Get.width*.9,
      child: TextField(
          
          cursorColor: Colors.white,
          cursorWidth: 2,
          cursorHeight: 23,
          decoration: InputDecoration(
            hintText: "Search blogs here...",
            hintStyle: TextStyle(color: Colors.black),
            suffixIcon: Icon(Icons.search,color: Colors.amber,),
            enabled: true,
           
            fillColor: Colors.white
          ),
        ),
    );
  }

  Widget _mainAppBar(){
    return AppBar(
      backgroundColor: Colors.lightBlue,
      title:  Text("Flutter Blog App"),
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

  Widget _appBar(){
    return !isSearching? _mainAppBar():_searchAppBar();
  }

  Widget _iconButton({Icon icon, Function onPressed}){
     return IconButton(
       icon: icon, 
       onPressed: onPressed
       );
  }

  _searchBlog(){
    this.isSearching=!this.isSearching;
    setState(() {
      
    });

  }

  _addnewBlog(){
    showMaterialModalBottomSheet(
      context: context, 
      builder: (context)=> Container(
            height: Get.height*.8,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.teal
            ),
            child:  SingleChildScrollView(
                          child: Column(
                  children: [
                    Row( 
                      children: [
                        SizedBox(
                          width: Get.width*.25
                        ),
                        Text("Create New Blog",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)),
                        SizedBox(width: 10,),
                        Icon(Icons.event_note),
                      ],
                    ),

                    _textForm("Enter title",20, titleController,""),
                    _textForm("Enter short detail", 100,shortdetailController,""),
                    _textForm("Enter description on your blog...",500, briefdetailController,""),

                    SizedBox(
                      height: 30,
                    ),

                    _addBlogButton(),
  
                    SizedBox(
                      height: Get.height*.5
                    ),
                  
                  ],
                ),
            ),
          
      ));
  }

  Widget _addBlogButton(){
    return ButtonTheme(
          minWidth: 200,
          child: RaisedButton(
        
        color: Colors.white,
        onPressed: (){
          _addBlogtoFireStore();
        },
        child: Text("Add Blog"),
      ),
    );
  }

  _addBlogtoFireStore() async{
    ProgressDialog pr = ProgressDialog(context);
     pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
     pr.style(
       message: "Adding new Blog..."
     );
    if(titleController.text.isEmpty|| shortdetailController.text.isEmpty|| briefdetailController.text.isEmpty){
      Fluttertoast.showToast(msg: "Fields can't be empty");
    }

    else{
      await pr.show();
      Map<String,dynamic> blogData= {
      "title":titleController.text,
      "shortdetail" : shortdetailController.text,
      "briefdetails" : briefdetailController.text,};
      await firebaseFirestore.collection("BlogPosts").doc(DateTime.now().toString().substring(0,19)).set(blogData);
      titleController.clear();
      shortdetailController.clear();
      briefdetailController.clear();
      await pr.hide();
      Fluttertoast.showToast(msg: "Successfully Added!");
      Navigator.of(context).pop();
    
    }
  }

  Widget _textForm(String label, int maxlength, TextEditingController controller,String helperText){
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.white,width: 2)

    );
    return Container(  
      margin: EdgeInsets.only(top: 40),
      child: TextFormField(
        controller: controller,
        cursorHeight: 25,
        cursorWidth: 3,
        cursorColor: Colors.white,
          maxLength: maxlength,
          maxLines: null,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: Colors.black
            ),
            helperStyle: TextStyle(color: Colors.red.shade800),
            suffixIcon: IconButton(
              color: Colors.red,
              icon: Icon(Icons.delete),
              onPressed: (){
                controller.clear();
              },
            ),
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
        
          ),
        ),
    );
  }
}