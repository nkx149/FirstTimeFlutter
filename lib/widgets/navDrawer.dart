import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyNavDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Drawer(
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
      );
  }
}