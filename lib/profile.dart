import 'package:bookshelf/models/login_response_dto.dart';
import 'package:bookshelf/widgets/navDrawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:bookshelf/models/user_update_dto.dart';

class ProfilePage extends StatefulWidget{
  final LoginResponseDto dto;
  const ProfilePage({super.key, required this.dto});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{

  late LoginResponseDto dto;
  @override
  void initState() {
    super.initState();
    dto = widget.dto;
  }
  
  @override
  Widget build(BuildContext context){
    final dateString = DateFormat('dd-MM-yyyy').format(dto.dateRegistered);
    return Scaffold(
      drawer: MyNavDrawer(dto: dto,),
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 80,
                  child: Icon(
                    Icons.person_4_rounded,
                    size: 70,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "${dto.username}",
                  style: TextStyle(
                    fontSize: 25
                  ),
                ),
              )
            ],
          ),
          SafeArea
          (
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: 
                [
                  _buildFieldRow("Name", "${dto.firstName} ${dto.lastName}"),
                  _buildFieldRow("Email", dto.email),
                  _buildFieldRow("Age", "${dto.age}"),
                  _buildFieldRow("Phone Number", dto.phoneNumber),
                  _buildFieldRow("Address", dto.address),
                  _buildFieldRow("Date Joined", dateString),
                  

                  
                ],
            )
          ),
         ),
         ElevatedButton(
          onPressed: () async {
            final updateDto = await GoRouter.of(context).push<UserUpdateDto>('/edit-profile', extra: dto);

            if (updateDto != null) {
              setState(() {
                dto = LoginResponseDto(
                  token: dto.token,
                  id: dto.id,
                  username: dto.username,
                  dateRegistered: dto.dateRegistered,
                  firstName: updateDto.firstName ?? dto.firstName,
                  lastName: updateDto.lastName ?? dto.lastName,
                  email: updateDto.email ?? dto.email,
                  address: updateDto.address ?? dto.address,
                  age: updateDto.age ?? dto.age,
                  phoneNumber: updateDto.phoneNumber ?? dto.phoneNumber,
              );
            });
          }
          }, 
          child: Text("Edit Details")),
        ],
      ),

    );
  }
}

Widget _buildFieldRow(String fieldName, String? contents) {
  return Row(
    children: [
      Text("$fieldName: ", 
        style: TextStyle(
          fontWeight: FontWeight.bold, color: ColorScheme.fromSeed(seedColor: Colors.green).primary,
        ),
      ),
      Text("$contents"),
    ],
  );
}