import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:mughal_news/res/constant/color_constant.dart';
import 'package:mughal_news/utils/utils.dart';

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
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                height: height * .52,
                width: width,
                child: Stack(
                  children: [
                    Hero(
                      tag: widget.image!,
                      child: InkWell(
                        onTap: () => showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                content: Container(
                                  height: height * .4,
                                  width: double.infinity,
                                  child: InteractiveViewer(
                                    minScale: 1.0,
                                    maxScale: 6.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Image.network(
                                        widget.image.toString(),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                        child: CachedNetworkImage(
                            imageUrl: widget.image.toString(),
                            height: double.infinity,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => const Center(
                                  child: SpinKitFadingCircle(
                                    color: Colors.teal,
                                    size: 50.0,
                                  ),
                                )),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white, size: 35.0),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: height * .5,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                margin: EdgeInsets.only(top: height * .48),
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                child: ListView(
                  children: [
                    Hero(
                      tag: widget.title!,
                      child: Text(
                        widget.title.toString(),
                        style: const TextStyle(fontSize: 20, color: Colors.black, fontFamily: "Ubuntu", fontWeight: FontWeight.w500),
                      ),
                    ),
                    Utils.appDivider(),
                    Hero(
                      tag: widget.source!,
                      child: Utils.richTexted(
                        title: "Channel :- ",
                        subTitle: "${widget.source}",
                        titleColor: Colors.teal,
                        subTitleColor: Colors.teal,
                      ),
                    ),
                    SizedBox(height: height * .02),
                    Hero(
                      tag: widget.date!,
                      child: Utils.richTexted(
                        title: "Date :- ",
                        subTitle: format.format(dateTime),
                      ),
                    ),
                    Utils.appDivider(),
                    Text(
                      widget.description.toString(),
                      style: TextStyle(fontSize: 15.0, color: AppColor.blackColor.withOpacity(0.5), fontFamily: "Ubuntu"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
