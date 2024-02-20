import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class NewsDetailView extends StatefulWidget {
  final String? image, title, date, description, author, content, source;
  const NewsDetailView({super.key, this.image, this.title, this.date, this.description, this.author, this.content, this.source});

  @override
  State<NewsDetailView> createState() => _NewsDetailViewState();
}

class _NewsDetailViewState extends State<NewsDetailView> {
  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    DateTime dateTime = DateTime.parse(widget.date.toString());
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black)),
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              height: height * .45,
              width: width,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                child: CachedNetworkImage(
                    imageUrl: widget.image.toString(),
                    fit: BoxFit.fill,
                    placeholder: (context, url) => const Center(
                          child: SpinKitFadingCircle(
                            color: Colors.teal,
                            size: 50.0,
                          ),
                        )),
              ),
            ),
            Container(
                height: height * .7,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                margin: EdgeInsets.only(top: height * .4),
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                child: ListView(
                  children: [
                    Text(
                      widget.title.toString(),
                      // style: GoogleFonts.poppins(
                      //     color: Colors.black,
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.w700),
                      style: const TextStyle(fontSize: 20, color: Colors.black, fontFamily: "Ubuntu"),
                    ),
                    SizedBox(height: height * .04),
                    Text(
                      "Channel:- ${widget.source}",
                      // style: GoogleFonts.anton(
                      //     fontSize: 15.0, color: Colors.teal),
                      style: const TextStyle(fontSize: 15, color: Colors.teal, fontFamily: "Ubuntu"),
                    ),
                    SizedBox(height: height * .02),
                    Text(
                      "Date:-            ${format.format(dateTime)}",
                      // style: GoogleFonts.akshar(
                      //   fontSize: 13.0,
                      // ),
                      style: const TextStyle(fontSize: 13, color: Colors.grey, fontFamily: "Ubuntu"),
                    ),
                    SizedBox(height: height * .05),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    // Text(widget.source,
                    //     style: GoogleFonts.anton(
                    //         fontSize: 15.0, color: Colors.teal)),
                    // Text(format.format(dateTime),
                    //     style: GoogleFonts.akshar(
                    //       fontSize: 13.0,
                    //     )),
                    //   ],
                    // ),
                    Text(
                      widget.description.toString(),
                      // style: GoogleFonts.poppins(
                      //     color: Colors.grey,
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w400),
                      style: const TextStyle(fontSize: 14, color: Colors.grey, fontFamily: "Ubuntu"),
                    ),
                  ],
                ))
          ],
        ));
  }
}
