import 'package:bookshelf/widgets/navDrawer.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget{
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: MyNavDrawer(),
      appBar: AppBar(
        title: const Text('Profile'),
      ),
    );
  }
}