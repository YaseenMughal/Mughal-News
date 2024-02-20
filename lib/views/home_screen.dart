import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:mughal_news/models/category_news_model.dart';
import 'package:mughal_news/models/news_channel_headlines_model.dart';
import 'package:mughal_news/view_models/news_view_model.dart';
import 'package:mughal_news/views/category_screen.dart';
import 'package:mughal_news/views/news_detail_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

enum FilterList { bbcNews, washington, reuters, cnn, alJazeera }

class _HomeViewState extends State<HomeView> {
  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat('MMMM dd, yyyy');
  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {});
  }

  FilterList? selectedMenu;
  String name = "bbc-news";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          "News",
          // style: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
          style: const TextStyle(fontSize: 20, color: Colors.black, fontFamily: "Ubuntu"),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoriesView()));
          },
          icon: Image.asset(
            'assets/images/category_icon.png',
            scale: 25,
          ),
        ),
        actions: [
          PopupMenuButton<FilterList>(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onSelected: (FilterList item) {
              if (FilterList.bbcNews.name == item.name) {
                name = 'bbc-news';
              }
              if (FilterList.washington.name == item.name) {
                name = 'the-washington-post';
              }

              if (FilterList.cnn.name == item.name) {
                name = 'cnn';
              }
              if (FilterList.reuters.name == item.name) {
                name = 'reuters';
              }
              if (FilterList.alJazeera.name == item.name) {
                name = 'al-jazeera-english';
              }

              setState(() {
                selectedMenu = item;
              });
            },
            initialValue: selectedMenu,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>>[
              const PopupMenuItem<FilterList>(
                value: FilterList.bbcNews,
                child: Text("BBC News"),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.washington,
                child: Text("Washington"),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.reuters,
                child: Text("Reuters"),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.cnn,
                child: Text("CNN"),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.alJazeera,
                child: Text("Al-Jazeera"),
              ),
            ],
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView(
          children: [
            SizedBox(
              width: width,
              height: height * .55,
              child: FutureBuilder<NewsChannelHeadlinesModel>(
                future: newsViewModel.fetchNewsChannelHeadlinesApi(name),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitFadingCircle(
                        color: Colors.teal,
                        size: 50.0,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsDetailView(
                                            image: snapshot.data!.articles![index].urlToImage.toString(),
                                            title: snapshot.data!.articles![index].title.toString(),
                                            date: snapshot.data!.articles![index].publishedAt.toString(),
                                            description: snapshot.data!.articles![index].description.toString(),
                                            author: snapshot.data!.articles![index].author.toString(),
                                            content: snapshot.data!.articles![index].content.toString(),
                                            source: snapshot.data!.articles![index].source!.name.toString(),
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 12, right: 7),
                              child: Stack(children: [
                                SizedBox(
                                  height: height * .8,
                                  width: width * .8,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                      fit: BoxFit.fill,
                                      errorWidget: (context, url, error) => const Icon(Icons.error_outline, color: Colors.red),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    bottom: height * .03,
                                    right: width * .01,
                                    left: width * .01,
                                    child: Card(
                                      elevation: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data!.articles![index].title.toString(),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              // style: GoogleFonts.poppins(),
                                            ),
                                            SizedBox(height: height * .1),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot.data!.articles![index].source!.name.toString(),
                                                  // style: GoogleFonts.anton(
                                                  //     fontSize: 15.0,
                                                  //     color: Colors.teal),
                                                  style: const TextStyle(fontSize: 15, color: Colors.teal, fontFamily: "Ubuntu"),
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  // style: GoogleFonts.akshar(
                                                  //   fontSize: 12.0,
                                                  // ),
                                                  style: const TextStyle(fontSize: 12.0, color: Colors.white, fontFamily: "Ubuntu"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                              ]),
                            ),
                          );
                        });
                  }
                },
              ),
            ),
            SizedBox(height: height * .02),
            Container(
              width: width,
              height: height * .5,
              child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fetchCategoriesNewsApi('General'),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitFadingCircle(
                        color: Colors.teal,
                        size: 50.0,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(
                            snapshot.data!.articles![index].publishedAt.toString(),
                          );
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsDetailView(
                                            image: snapshot.data!.articles![index].urlToImage.toString(),
                                            title: snapshot.data!.articles![index].title.toString(),
                                            date: snapshot.data!.articles![index].publishedAt.toString(),
                                            description: snapshot.data!.articles![index].description.toString(),
                                            author: snapshot.data!.articles![index].author.toString(),
                                            content: snapshot.data!.articles![index].content.toString(),
                                            source: snapshot.data!.articles![index].source!.name.toString(),
                                          )));
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 12, right: 7),
                                child: Container(
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                          fit: BoxFit.fill,
                                          height: height * .21,
                                          width: width * .3,
                                          errorWidget: (context, url, error) => const Icon(Icons.error_outline, color: Colors.red),
                                        ),
                                      ),
                                      SizedBox(width: width * .03),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data!.articles![index].title.toString(),
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                            // style: GoogleFonts.poppins(
                                            //     fontSize: 13,
                                            //     color: Colors.grey,
                                            //     fontWeight: FontWeight.w500),
                                            style: const TextStyle(fontSize: 13, color: Colors.grey, fontFamily: "Ubuntu"),
                                          ),
                                          SizedBox(height: height * .07),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot.data!.articles![index].source!.name.toString(),
                                                  // style: GoogleFonts.anton(
                                                  //     fontSize: 15.0,
                                                  //     color: Colors.teal),
                                                  style: const TextStyle(fontSize: 15, color: Colors.teal, fontFamily: "Ubuntu"),
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  // style: GoogleFonts.akshar(
                                                  //   fontSize: 12.0,
                                                  // ),
                                                  style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: "Ubuntu"),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                )),
                          );
                        });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
