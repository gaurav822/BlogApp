import 'package:BlogApp/Screens/blogdetailspage.dart';
import 'package:BlogApp/Screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(

    home: HomePage(),
    debugShowCheckedModeBanner: false,
    routes: {
      "/detailedPage": (context)=> BlogDetailsPage()
    },
  ));
}

// Widget _floatingSearchBar(){
//   return FloatingSearchBar.builder(
//         itemCount: 100,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             leading: Text(index.toString()),
//           );
//         },
//         trailing: CircleAvatar(
//           child: Text("RD"),
//         ),
//         drawer: Drawer(
//           child: Container(),
//         ),
//         onChanged: (String value) {},
//         onTap: () {},
//         decoration: InputDecoration.collapsed(
//           hintText: "Search...",
//         ),
//       );
// }