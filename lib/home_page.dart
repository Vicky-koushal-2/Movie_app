import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:movie_app/details_screen.dart';
import 'package:movie_app/search_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List movies = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMovies();
  }
  fetchMovies() async{
   final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
   if(response.statusCode == 200){
     setState(() {
       movies = json.decode(response.body);
     });
   }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(title: Text('Movie'),
backgroundColor: Colors.red.shade300,
actions: [
  IconButton(onPressed: (){}, icon: Icon(Icons.search))
],),
      body: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context,index){
            final movie = movies[index]['show'];
            return Card(
              elevation: 5,
              child: ListTile(

                leading: Image.network(movie['image']?['medium']??''),
                title: Text(movie['name']),
                subtitle: Text(movie['summary']?.replaceAll(RegExp(r'<[^>]*>'),'')?? '',maxLines: 3,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(movie:movie,)));

                },
              ),
            );
          }
          ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search),label: 'Search'),
      ],
      currentIndex: 0,
      selectedItemColor: Colors.red,
      onTap: (index){
        setState(() {
index = index;
        });
        if(index==1){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
        }

      },

      ),
    );
  }
}
