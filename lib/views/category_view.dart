import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:mughal_news/models/category_news_model.dart';
import 'package:mughal_news/res/constant/color_constant.dart';
import 'package:mughal_news/view_models/news_view_model.dart';
import 'package:mughal_news/views/news_detail_view.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM dd, yyyy');

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {});
  }

  String categoryName = "General";
  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology',
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black)),
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Category News",
            style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: "Ubuntu"),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoriesList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          categoryName = categoriesList[index];
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0), color: categoryName == categoriesList[index] ? Colors.teal : Colors.grey),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                child: Text(
                                  categoriesList[index].toString(),
                                  style: const TextStyle(fontSize: 15, color: Colors.white, fontFamily: "Ubuntu"),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: FutureBuilder<CategoriesNewsModel>(
                    future: newsViewModel.fetchCategoriesNewsApi(categoryName),
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
                                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () => showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content:
                                                      InteractiveViewer(minScale: 1.0, maxScale: 6.0, child: Image.network(snapshot.data!.articles![index].urlToImage.toString())),
                                                );
                                              }),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: CachedNetworkImage(
                                              imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                              fit: BoxFit.fill,
                                              height: height * .21,
                                              width: width * .3,
                                              errorWidget: (context, url, error) => const Icon(Icons.error_outline, color: Colors.red),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: width * .03),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data!.articles![index].title.toString(),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(fontSize: 13, color: AppColor.blackColor, fontFamily: "Ubuntu", fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(height: height * .07),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    snapshot.data!.articles![index].source!.name.toString(),
                                                    style: const TextStyle(fontSize: 14.0, color: Colors.teal, fontFamily: "Ubuntu"),
                                                  ),
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: "Ubuntu"),
                                                )
                                              ],
                                            )
                                          ],
                                        ))
                                      ],
                                    )),
                                // overflow: TextOverflow.clip,
                              );
                            });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
