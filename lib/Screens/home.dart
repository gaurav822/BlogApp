
import 'package:BlogApp/Controllers/searchbarcontroller.dart';
import 'package:BlogApp/Models/blogmodels.dart';
import 'package:BlogApp/Screens/blogdetailspage.dart';
import 'package:BlogApp/SignInPage/googleSignIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  TextEditingController searchController = TextEditingController();
  SearchBarController searchBarController = SearchBarController();

  List<QueryDocumentSnapshot> blogModelSnapShots= List();
  String helperText="Max Length Reached";
  bool isSearching=false;
  FirebaseAuth firebaseAuth= FirebaseAuth.instance;
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
        child: Stack(
                  children: [SizedBox(

          width: Get.width,
          height: Get.height,
          child: StreamBuilder(
            stream: firebaseFirestore.collection("BlogPosts").snapshots(),
            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
              List<QueryDocumentSnapshot> qdocsnap= snapshot.data.docs;
              blogModelSnapShots=qdocsnap;
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
                    postedDate: qdocsnap[index].reference.id,
                    imageUrl: qdocsnap[index]['imageUrl']
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
      Positioned(
        right: Get.width*.05,
        left: Get.width*.05,
        child: _suggestionBox())
      ],
        ),
    );
  }

  Widget _suggestionBox(){

    return GetBuilder(
      init: searchBarController,
      builder: (_)=>

     searchBarController.query.isEmpty? SizedBox(): Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(top: 10),
        width: Get.width,
        height: Get.height*.4,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              offset: Offset(2,2),
              blurRadius: 3,
              spreadRadius: 1
            )
          ],
          borderRadius: BorderRadius.circular(18)
        ),
        child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              
              _eachSuggestionCard(
                BlogModel(
                  title: blogModelSnapShots[0]['title'], 
                    shortdesC: blogModelSnapShots[0]['shortdetail'], 
                    briefDesc: blogModelSnapShots[0]['briefdetails'],
                    postedDate: blogModelSnapShots[0].reference.id,
                    imageUrl: blogModelSnapShots[0]['imageUrl']
                ),

                blogModelSnapShots
              )
            ],
          ),
        ),
      
      )
    );
  }

   Widget _eachSuggestionCard(BlogModel blogModel, List<QueryDocumentSnapshot> blogModelSnapShots, ){
    return GestureDetector(
      onTap: (){
        searchBarController.hideSuggestionBox();
      
        Navigator.pushNamed(context, "/detailedPage",arguments: blogModel);
      
      },
          child: Container(
            
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        width: Get.width,
        // height: Get.height*.2,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            for(int i=0;i<blogModelSnapShots.length;i++)
            
            blogModelSnapShots[i]['title'].toString().toLowerCase().contains(searchBarController.query.toLowerCase())?
      
            Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
             
              children: [
                
                CircleAvatar(
                      backgroundImage: NetworkImage(blogModelSnapShots[i]['imageUrl']),
                    ),

                    SizedBox(
                      width: 30,
                    ),
                    Flexible(child: Text(blogModelSnapShots[i]['title']))
              ],
            )
              ],
            ):
            SizedBox(),
          ],
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
                Container(
                  padding: EdgeInsets.all(8),
                  child: SizedBox(
                    width: 60,
                    height: 50,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(blogModel.imageUrl.isEmpty?"https://banner2.cleanpng.com/20190221/gw/kisspng-computer-icons-user-profile-clip-art-portable-netw-c-svg-png-icon-free-download-389-86-onlineweb-5c6f7efd8fecb7.6156919015508108775895.jpg":blogModel.imageUrl),
                    ),
                  ),
                ),
                  
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
            
            accountName:  Text(firebaseAuth.currentUser.displayName), 
            accountEmail: Text(firebaseAuth.currentUser.email),
            currentAccountPicture: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(firebaseAuth.currentUser.photoURL),
              ),
            
            ),

            _listTile(
              ticon: Icon(Icons.close),
            title: "Close",
            function: (){
              Navigator.of(context).pop();
            }
            ),

            _listTile(licon: Icon(Icons.logout),title: "Logout",
            function: () async{
              FirebaseAuth firebaseAuth=FirebaseAuth.instance;
              await firebaseAuth.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));

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
      child:TextField(
            onChanged: (value){
              searchBarController.onChanged(value);
            },
            cursorColor: Colors.white,
            cursorWidth: 2,
            cursorHeight: 23,
            controller: searchController,
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
      "briefdetails" : briefdetailController.text,
      "imageUrl" : firebaseAuth.currentUser.photoURL
      };
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


