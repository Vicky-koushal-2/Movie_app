import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:movie_app/details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List searchResut =[];
  TextEditingController _searchControoler = TextEditingController();
  
  searchMovies(String query)async{
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));
    if(response==200)
      {
        setState(() {
          searchResut =json.decode(response.body);
        });
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          controller: _searchControoler,
          decoration: InputDecoration(
            hintText: 'Search movies...',
              prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none
            ),
            filled: true,
            fillColor: Colors.grey.shade300
          ),
          onSubmitted: searchMovies,
        ),
      ),
      body: ListView.builder(
          itemCount: searchResut.length,
          itemBuilder: (context, index){
            final movie = searchResut[index]['show'];
            return  Card(
              child: ListTile(
                leading: Image.network(movie['image']?['medium']??''),
                title: Text(movie['name']),
                subtitle: Text(movie['summary']?.replaceAll(RegExp(r'<[^>]*>'),'')?? ''),
             onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(movie: movie,)));
             },
              ),
            );
          }),

    );
  }
}
