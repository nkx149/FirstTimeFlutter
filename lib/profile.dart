import 'package:bookshelf/models/login_response_dto.dart';
import 'package:bookshelf/widgets/navDrawer.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget{
  final LoginResponseDto dto;
  const ProfilePage({super.key, required this.dto});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: MyNavDrawer(dto: widget.dto,),
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          ListView(
            padding: EdgeInsets.all(20),
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  radius: 50,
                  child: Icon(
                    Icons.person_4_rounded,
                    size: 70,
                  ),
                  
                ),
              ),
              SizedBox(height: 30,),
              Center(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "First Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                ),
                SizedBox(height: 20,),
                Center(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      border: OutlineInputBorder()
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Center(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      border: OutlineInputBorder()
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Center(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Address",
                      border: OutlineInputBorder()
                    ),
                  ),
                )
            ],
          ),
          Divider(thickness: 2)
        ],
      ),

    );
  }
}