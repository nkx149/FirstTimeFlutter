import 'dart:convert';
import 'dart:async';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Album>? futureAlbum;


  @override
  void initState(){
    super.initState();
    futureAlbum = fetchAlbum("1");
  }

  void _updateAlbum(String query){
    setState(() {
      futureAlbum = fetchAlbum(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withValues(),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 30,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Demo App',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Welcome back!',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),

                    onTap: (){

                      GoRouter.of(context).push('/');

                    },
                  ),

                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),

                    onTap: (){
                      GoRouter.of(context).push('/profile');
                    },
                  ),

                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('Favourites'),
                    onTap: (){
                    },
                  ),
                ],
              ),
            ),
  
            Spacer(),

            Divider(height: 1),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Log Out'),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              final result = await showSearch(context: context, delegate: CustomSearchDelegate());
              if (result != null && result.isNotEmpty) {
                  _updateAlbum(result);
                }
            }, 
            icon: const Icon(
              Icons.search,
            ),
            tooltip: "Search",
          ),
        ],
        title: const Text("Bookshelf"),
      ),
      body: Center(
        child: FutureBuilder<Album>(future: futureAlbum, builder: (context, snapshot){
          if(snapshot.hasData){
           return _buildAlbumCard(snapshot.data!);

          }else if (snapshot.hasError) {
            return _buildErrorCard(snapshot.error.toString());
          }
          return Center(child: const CircularProgressIndicator());
        })
      ),
    );
  }

  Widget _buildAlbumCard(Album album){
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              // child: _buildPlaceholderImage(),
              child: _buildGradientPlaceholder(),
            ),
          ),

          Padding(padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  album.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorScheme.fromSeed(seedColor: Colors.green).primary,

                  ),
                ),
                SizedBox(height: 8.0,),

                Row(
                  children: [
                    Icon(Icons.tag, size: 16, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Text(
                      'ID: ${album.id}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.0,),

                Row(
                  children: [
                    Icon(Icons.person, size: 16, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Text(
                      'User ID: ${album.userId}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
  Widget _buildPlaceholderImage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_outlined,
            size: 48,
            color: Colors.grey[400],
          ),
          SizedBox(height: 8),
          Text(
            'No Image Available',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorCard(String error) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline, 
              size: 64, 
              color: Colors.red[400],
            ),
            SizedBox(height: 16),
            Text(
              "Error",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red[600],
              ),
            ),
            SizedBox(height: 8),
            Text(
              error,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientPlaceholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue[100]!,
            Colors.purple[100]!,
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: 48,
          color: Colors.white,
        ),
      ),
    );
  }
}


class CustomSearchDelegate extends SearchDelegate {
  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text(
          'Please enter an album ID number',
          style: TextStyle(
            fontSize: 18,
            color: Colors.orange,
          ),
        ),
      );
    }
    
    return FutureBuilder<Album>(future: fetchAlbum(query), builder: (context, snapshot){
      if (snapshot.connectionState == ConnectionState.waiting){
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16,),
              Text("Validating ID...."),
            ],
          ),
        );
      }

      if (snapshot.hasError){
        return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red),
                SizedBox(height: 16),
                Text(
                  "Error: ${snapshot.error}",
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
      }

      if (!snapshot.hasData) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  "No results found",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
            ],
          ),
        );
      }

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 64, color: Colors.green),
            SizedBox(height: 16),
            Text(
              "Album found!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Tap the search button to view",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ); 
    }
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          if (query.isNotEmpty) {
            close(context, query); // Return the search query
          }
        },
      ),
    ];
  }
  
  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text('Type and press search'));
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

}


class Album {
  final int userId;
  final int id;
  final String title;

  const Album({required this.userId, required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'userId': int userId, 'id': int id, 'title': String title} => Album(
        userId: userId,
        id: id,
        title: title,
      ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

// Future<Album> fetchAlbum(String query) async{
//   final albumId = int.tryParse(query);
  
//   if (albumId == null){
//     throw Exception("Please enter a valid id number");
//   }

//   final response = await http.get(
//     Uri.parse("https://jsonplaceholder.typicode.com/albums/$query"),
//   );

//   if (response.statusCode == 200){
//     return Album.fromJson(jsonDecode(response.body)as Map<String, dynamic>);
//   } else {
//     throw Exception('Failed to load album');
//   }
// }

class AlbumFetchException implements Exception {
  final String message;
  AlbumFetchException(this.message);

  @override
  String toString() => message;
}

// Improved fetch function
Future<Album> fetchAlbum(String query) async {
  final albumId = int.tryParse(query);

  if (albumId == null) {
    throw AlbumFetchException("Please enter a valid numeric album ID.");
  }

  try {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/albums/$albumId"),
    );

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else if (response.statusCode == 404) {
      throw AlbumFetchException("Album not found (404). Please check the ID.");
    } else {
      throw AlbumFetchException(
        'Failed to load album (HTTP ${response.statusCode}).',
      );
    }
  } catch (e) {
    throw AlbumFetchException("Could not fetch album: ${e.toString()}");
  }
}


