import 'package:flutter/material.dart';
import 'package:fantasyapp/widgets/constants/sizes.dart';
import 'package:fantasyapp/widgets/news_details.dart';
import 'package:fantasyapp/widgets/video_palyer.dart';

class NewsCard extends StatelessWidget {
  final String imgUrl, title, desc, videourl;

  const NewsCard({
    super.key,
    required this.imgUrl,
    required this.desc,
    required this.title,
    required this.videourl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: Sizes.dimen_4,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_10))),
      margin: const EdgeInsets.fromLTRB(
          Sizes.dimen_16, 0, Sizes.dimen_16, Sizes.dimen_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(Sizes.dimen_6),
            child: Text(
              title,
              maxLines: 2,
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: Sizes.dimen_20,
                  fontWeight: FontWeight.w500),
            ),
          ),
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(Sizes.dimen_10),
                  topRight: Radius.circular(Sizes.dimen_10)),
              child: Builder(builder: (context) {
                if (videourl == "") {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewsDetail(
                                    title: title,
                                    desc: desc,
                                    imgUrl: imgUrl,
                                  )));
                    },
                    child: Image.network(
                      imgUrl,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                      // if the image is null
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Sizes.dimen_10)),
                          child: const SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Icon(Icons.broken_image_outlined),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const VideoPlayerWidget();
                }
              })),
          Padding(
            padding: const EdgeInsets.all(Sizes.dimen_6),
            child: Text(
              desc,
              maxLines: 2,
              style: const TextStyle(
                  color: Colors.black54, fontSize: Sizes.dimen_14),
            ),
          ),
        ],
      ),
    );
  }
}
