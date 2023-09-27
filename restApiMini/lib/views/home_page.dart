import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../model/post_model.dart';
import '../services/remote_services.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post>? posts;
  var isLoaded =
      false; // it'll keep track whether the api data is loaded or not
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(); // This ensures that we get the data first thing when the page loads
  }

  getData() async {
    posts = await RemoteService().getPosts();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text(
          "Posts",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Croissant'),
        ),
      ),
      body: Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          // Expanded(
          //   child: Shimmer.fromColors(
          //     baseColor: Colors.white24,
          //     highlightColor: Colors.grey,
          //     enabled: !isLoaded,
          //     child: ListView.builder(
          //       itemCount: posts?.length,
          //       itemBuilder: (context, index) => Padding(
          //         padding: const EdgeInsets.only(bottom: 8.0),
          //         child: Row(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Container(
          //               width: 60,
          //               height: 60,
          //               color: Colors.white, // Placeholder color
          //             ),
          //             SizedBox(width: 12),
          //             Expanded(
          //               child: Container(
          //                 height: 12,
          //                 color: Colors.white, // Placeholder color
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          child: ListView.builder(
            itemCount: posts?.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            posts![index].title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            posts![index].body ??
                                ' ', //We added null safety, coz inside the model we mentioned the body can be null
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
