import 'package:BlogApp/Models/blogmodels.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogDetailsPage extends StatefulWidget {
  @override
  _BlogDetailsPageState createState() => _BlogDetailsPageState();
}

class _BlogDetailsPageState extends State<BlogDetailsPage> {
  @override
  Widget build(BuildContext context) {
    BlogModel blogModel= ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Details"),
        backgroundColor: Colors.green,
    
      ),
      body: _body(blogModel),
    );
  }

  Widget _body(BlogModel blogModel){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset("assets/gaurav.png",height: 60,width: 100,),
              Flexible(child: Text(blogModel.title,style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 20),))
            ],
          ),
        ),
        _fullDescriptionVlog(blogModel),

        _postDate(blogModel),

        _bloggerDetails(),
      ],
    );
  }

  Widget _bloggerDetails(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text("Name: ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              Text("Gaurav Dahal",style: TextStyle(color: Colors.grey.shade700),)
            ],
          ),
          Row(
            children: [
              // Text("Email: ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              Icon(Icons.email_outlined,color: Colors.red.shade400,),
              SizedBox(
                width: 10,
              ),
              SelectableText("gauravdahal53@gmail.com",style: TextStyle(color: Colors.grey.shade700),)
            ],        ),
        ],
      ),
    );
  }

  Widget _postDate(BlogModel blogModel){
    return  Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
          children: [
            Text("Posted on:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            SizedBox(width: 10,),
            Text(blogModel.postedDate,style: TextStyle(color: Colors.grey),)
          ],
        
      ),
    );
  }

  Widget _fullDescriptionVlog(BlogModel blogModel){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SelectableText(blogModel.briefDesc),
    );
  }
}