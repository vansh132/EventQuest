import 'package:eventquest/services/task_services.dart';
import 'package:eventquest/theme/theme_ext.dart';
import 'package:flutter/material.dart';

class Highlights extends StatefulWidget {
  const Highlights({super.key});

  @override
  State<Highlights> createState() => _HighlightsState();
}

class _HighlightsState extends State<Highlights> {
  List<String> images = [];

  Future<List<String>> getAllImages() async {
    TaskServices taskServices = TaskServices();
    images = await taskServices.getAllImages(context);
    // print(images);
    return images;
  }

  @override
  void initState() {
    getAllImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Highlights",
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: appColors.primary,
                ),
          ),
          Container(
            height: 210,
            margin: const EdgeInsets.only(top: 6),
            child: FutureBuilder(
                future: getAllImages(),
                initialData: images,
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenImage(
                                  imageUrl: snapshot.data![index]),
                            ),
                          );
                        },
                        child: Hero(
                          tag: snapshot.data![index],
                          child: Container(
                            width: 140,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage((snapshot.data![index])),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: imageUrl,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              height: MediaQuery.of(context).size.height - 200,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
      ),
    );
  }
}
