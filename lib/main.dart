import 'package:change/data/Dao.dart';
import 'package:flutter/material.dart';

import 'MyHomePage.dart';

void main() {
  initDatabase();
  runApp(MyApp());
}

void initDatabase() async {
  getDatabase(false);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '中航店title',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: '中航店'),
    );
  }
}


// ignore_for_file: public_member_api_docs
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:share/share.dart';
//
// import 'image_previews.dart';
//
// void main() {
//   runApp(DemoApp());
// }
//
// class DemoApp extends StatefulWidget {
//   @override
//   DemoAppState createState() => DemoAppState();
// }
//
// class DemoAppState extends State<DemoApp> {
//   String text = '';
//   String subject = '';
//   List<String> imagePaths = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Share Plugin Demo',
//       home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Share Plugin Demo'),
//           ),
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   TextField(
//                     decoration: const InputDecoration(
//                       labelText: 'Share text:',
//                       hintText: 'Enter some text and/or link to share',
//                     ),
//                     maxLines: 2,
//                     onChanged: (String value) => setState(() {
//                       text = value;
//                     }),
//                   ),
//                   TextField(
//                     decoration: const InputDecoration(
//                       labelText: 'Share subject:',
//                       hintText: 'Enter subject to share (optional)',
//                     ),
//                     maxLines: 2,
//                     onChanged: (String value) => setState(() {
//                       subject = value;
//                     }),
//                   ),
//                   const Padding(padding: EdgeInsets.only(top: 12.0)),
//                   ImagePreviews(imagePaths, onDelete: _onDeleteImage),
//                   ListTile(
//                     leading: Icon(Icons.add),
//                     title: Text("Add image"),
//                     onTap: () async {
//                       final imagePicker = ImagePicker();
//                       final pickedFile = await imagePicker.getImage(
//                         source: ImageSource.gallery,
//                       );
//                       if (pickedFile != null) {
//                         setState(() {
//                           imagePaths.add(pickedFile.path);
//                         });
//                       }
//                     },
//                   ),
//                   const Padding(padding: EdgeInsets.only(top: 12.0)),
//                   Builder(
//                     builder: (BuildContext context) {
//                       return ElevatedButton(
//                         child: const Text('Share'),
//                         onPressed: text.isEmpty && imagePaths.isEmpty
//                             ? null
//                             : () => _onShare(context),
//                       );
//                     },
//                   ),
//                   const Padding(padding: EdgeInsets.only(top: 12.0)),
//                   Builder(
//                     builder: (BuildContext context) {
//                       return ElevatedButton(
//                         child: const Text('Share With Empty Origin'),
//                         onPressed: () => _onShareWithEmptyOrigin(context),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
//
//   _onDeleteImage(int position) {
//     setState(() {
//       imagePaths.removeAt(position);
//     });
//   }
//
//   _onShare(BuildContext context) async {
//     // A builder is used to retrieve the context immediately
//     // surrounding the ElevatedButton.
//     //
//     // The context's `findRenderObject` returns the first
//     // RenderObject in its descendent tree when it's not
//     // a RenderObjectWidget. The ElevatedButton's RenderObject
//     // has its position and size after it's built.
//     final RenderBox box = context.findRenderObject() as RenderBox;
//
//     if (imagePaths.isNotEmpty) {
//       await Share.shareFiles(imagePaths,
//           text: text,
//           subject: subject,
//           sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
//     } else {
//       await Share.share(text,
//           subject: subject,
//           sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
//     }
//   }
//
//   _onShareWithEmptyOrigin(BuildContext context) async {
//     await Share.share("text");
//   }
// }
