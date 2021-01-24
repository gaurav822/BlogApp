import 'package:BlogApp/Models/blogmodels.dart';
import 'package:flutter/material.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            
            children: [
              Container(
                  padding: EdgeInsets.all(8),
                  child: SizedBox(
                    width: 60,
                    height: 70,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(blogModel.imageUrl.isEmpty?"https://banner2.cleanpng.com/20190221/gw/kisspng-computer-icons-user-profile-clip-art-portable-netw-c-svg-png-icon-free-download-389-86-onlineweb-5c6f7efd8fecb7.6156919015508108775895.jpg":blogModel.imageUrl),
                    ),
                  ),
                ),
              Flexible(child: Text(blogModel.title,style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 20),))
            ],
          ),
        ),
        _fullDescriptionVlog(blogModel),

        _postDate(blogModel),

        _bloggerDetails(blogModel),
      ],
    );
  }

  Widget _bloggerDetails(BlogModel blogModel){
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