import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fetch_data/comment.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Comment>? _comment;

  @override
  void initState() {
    super.initState();
    _comment = fetchComment();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Comment Details', style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold)),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: FutureBuilder<Comment>(
              future: _comment,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: "Post ID: ", style: GoogleFonts.ubuntu(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0)),
                            TextSpan(
                              text: snapshot.data!.postId.toString(),
                              style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: "ID: ", style: GoogleFonts.ubuntu(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0)),
                            TextSpan(
                              text: snapshot.data!.id.toString(),
                              style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: "Name: ", style: GoogleFonts.ubuntu(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0)),
                            TextSpan(
                              text: snapshot.data!.name,
                              style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: "Email: ", style: GoogleFonts.ubuntu(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0)),
                            TextSpan(
                              text: snapshot.data!.email,
                              style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: "Body: ", style: GoogleFonts.ubuntu(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0)),
                            TextSpan(
                              text: snapshot.data!.body,
                              style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}

Future<Comment> fetchComment() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments/1'));
  if (response.statusCode == 200) {
    return Comment.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load comment');
  }
}
