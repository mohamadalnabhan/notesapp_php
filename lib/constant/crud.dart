import 'package:http/http.dart' as http;
import 'dart:convert';
class Crud {
  getRequest(String uri)async{
    try{
      var response = await http.get(Uri.parse(uri));

      if(response.statusCode == 200){
        var responseBody = jsonDecode(response.body);
        return responseBody ;
      }else{
        print("error ${response.statusCode}");
      }

    }catch(e){
     print("the error happened is ${e}");
    }
  }
 PostRequest(String uri , Map data)async{
    try{
      var response = await http.post(Uri.parse(uri), body: data);

      if(response.statusCode == 200){
        var responseBody = jsonDecode(response.body);
        return responseBody ;
      }else{
        print("error ${response.statusCode}");
      }

    }catch(e){
      print("the error happened is ${e}");
    }
  }



}