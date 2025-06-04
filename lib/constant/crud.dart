import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';

class Crud {
  getRequest(String uri) async {
    try {
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print("error ${response.statusCode}");
      }
    } catch (e) {
      print("the error happened is ${e}");
    }
  }

  PostRequest(String uri, Map data) async {
    try {
      var response = await http.post(Uri.parse(uri), body: data);

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print("error ${response.statusCode}");
      }
    } catch (e) {
      print("the error happened is ${e}");
    }
  }

PostRequestWithFiles(String url, Map data, File file) async {
  try {
    print("Preparing request...");

    var request = http.MultipartRequest("POST", Uri.parse(url));

    var stream = http.ByteStream(file.openRead());
    var length = await file.length();

    print("File length: $length");

    var multipartfile = http.MultipartFile(
      "file",
      stream,
      length,
      filename: basename(file.path),
    );

    request.files.add(multipartfile);

    data.forEach((key, value) {
      request.fields[key] = value;
    });

    print("Sending request...");
    var myrequest = await request.send();
    print("Request sent. Awaiting response...");

    var response = await http.Response.fromStream(myrequest);

    print("Response received: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (myrequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("HTTP Error: ${myrequest.statusCode}");
      return {"status": "fail"};
    }
  } catch (e) {
    print("Exception caught: $e");
    return {"status": "fail", "error": e.toString()};
  }
}
}
