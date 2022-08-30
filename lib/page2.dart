import 'package:dancebuddy/page3.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';

class MySecondPage extends StatefulWidget {
  const MySecondPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MySecondPageState createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Screen 2',
            ),
            ElevatedButton(
              onPressed: () async {
                final ImagePicker _picker = ImagePicker();
                final XFile? image =
                    await _picker.pickVideo(source: ImageSource.gallery);
                print(image?.path);
                print(image?.name);
                // read the file data
                var fileBytes = await image?.readAsBytes();
                // upload the video to the server
                var url =
                    'http://ec2-54-176-5-252.us-west-1.compute.amazonaws.com:5000/hi';
                http.MultipartRequest request =
                    http.MultipartRequest('GET', Uri.parse('$url'));
                request.files.add(
                  await http.MultipartFile.fromBytes(
                    'file',
                    fileBytes!,
                    filename: 'test.midi',
                    contentType: MediaType('audio', 'midi'),
                  ),
                );
                print("sending ...");
                request.send().then((r) async {
                  print(r.statusCode);
                  if (r.statusCode == 200) {
                    var results = await r.stream.transform(utf8.decoder).join();
                    print(results);
                  } else {
                    setState(() {});
                    print('error + $r.statusCode');
                  }
                }).catchError((e) {
                  print("Failed to send the request");
                  print(e);
                });
              },
              child: const Text('upload video'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const MyThirdPage(title: "page 3")),
            //     );
            //   },
            //   child: const Text('record video'),
          ],
        ),
      ),
    );
  }
}
