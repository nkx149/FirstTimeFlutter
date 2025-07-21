import 'package:bookshelf/models/login_response_dto.dart';
import 'package:bookshelf/widgets/navDrawer.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget{
  final LoginResponseDto dto;
  const EditProfilePage({super.key, required this.dto});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: MyNavDrawer(dto: widget.dto,),
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Card(),
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
    );
  }
}