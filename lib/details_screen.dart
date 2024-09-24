import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Map movie;
  const DetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie['name']),),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(movie['image']?['original']??''),
            SizedBox(height: 15,),
            Text(movie['name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            SizedBox(height: 10,),
            Text(movie['summary']?.replaceAll(RegExp(r'<[^>]*>'), '') ?? '', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
