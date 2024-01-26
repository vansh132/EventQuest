import 'package:flutter/material.dart';

List<String> images = [
  "https://images.unsplash.com/photo-1525921429624-479b6a26d84d?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://plus.unsplash.com/premium_photo-1682284353470-53c3a913bded?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1523875194681-bedd468c58bf?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://img.freepik.com/free-photo/front-view-smiley-man-holding-book_23-2149915900.jpg?w=360&t=st=1706267307~exp=1706267907~hmac=7f9fb76e4341662680c8ecde9d05a1aa2226ead4509564c8a88f61a2f5bf3363",
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Image Gallery')),
        body: Highlights(),
      ),
    );
  }
}

class Highlights extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        itemCount: images.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FullScreenImage(imageUrl: images[index]),
                ),
              );
            },
            child: Hero(
              tag: images[index],
              child: Container(
                width: 140,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(images[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  FullScreenImage({required this.imageUrl});

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
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height - 200,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
      ),
    );
  }
}
