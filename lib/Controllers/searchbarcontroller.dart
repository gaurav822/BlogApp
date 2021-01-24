import 'package:get/get.dart';

class SearchBarController extends GetxController{
  String query= '';

  onChanged(String val){
    query=val;
    update();
  }

  hideSuggestionBox(){
    query="";
    update();
  }

  getSuggestionList(){
    
  }

}