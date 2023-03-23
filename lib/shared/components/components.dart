// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Widget buildArticleItem(article, context) {
  NetworkImage myImage;
  if (article['urlToImage'] == null) {
    myImage = NetworkImage(
        "https://www.rmofmarquis.com/wp-content/themes/rmmarquis/images/no-image-available.png");
  } else {
    myImage = NetworkImage("${article['urlToImage']}");
  }
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        //Image
        Container(
          width: 125,
          height: 125,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image(image: myImage, fit: BoxFit.cover),
        ),
        SizedBox(
          width: 10,
        ),
        //Title and Date
        Expanded(
          child: SizedBox(
            height: 125,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${article['title']}",
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  article['publishedAt']
                      .toString()
                      .substring(0, 10)
                      .replaceAll("-", " "),
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget itemsDivider() => Container(
      height: 5,
      color: Colors.grey,
    );
