import 'package:bookshelf/models/login_response_dto.dart';
import 'package:bookshelf/services/update_profile_service.dart';
import 'package:bookshelf/widgets/navDrawer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'models/user_update_dto.dart';

class EditProfilePage extends StatefulWidget{
  final LoginResponseDto dto;
  const EditProfilePage({super.key, required this.dto});

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage>{

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController ageController;
  late TextEditingController phoneNumberController;

  late TextEditingController addressController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  late Map<String, String?> originalData;

  late bool _newPasswordVisible;
  late bool _confirmPasswordVisible;

  String? errorMessage;

  


  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.dto.firstName ?? '');
    lastNameController = TextEditingController(text: widget.dto.lastName ?? '');
    emailController = TextEditingController(text: widget.dto.email);
    ageController = TextEditingController(text: widget.dto.age?.toString() ?? '');
    phoneNumberController = TextEditingController(text: widget.dto.phoneNumber ?? '');
    addressController = TextEditingController(text: widget.dto.address ?? '');
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    _newPasswordVisible = false;
    _confirmPasswordVisible = false;
    

    originalData = {
      "firstName": widget.dto.firstName,
      "lastName" : widget.dto.lastName,
      "email": widget.dto.email,
      "phoneNumber": widget.dto.phoneNumber,
      "address": widget.dto.address,
      "newPassword" : ""
    };
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    ageController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void saveChanges() async {

    final updateDto = UserUpdateDto(id: widget.dto.id);
    if (firstNameController.text.trim() != originalData['firstName']) {
      updateDto.firstName = firstNameController.text.trim();
    }
    
    if (lastNameController.text.trim() != originalData['lastName']) {
      updateDto.lastName = lastNameController.text.trim();
    }

    if (emailController.text.trim() != originalData['email']) {
      updateDto.email = emailController.text.trim();

    }

    final ageText = ageController.text.trim();

    if (ageText.isNotEmpty && ageText != originalData['age'].toString()) {
      final parsedAge = int.tryParse(ageText);
      if (parsedAge != null) {
        updateDto.age = parsedAge;
      }
    }

    if (addressController.text.trim() != originalData['address']) {
      updateDto.address = addressController.text.trim();
    }

    if (phoneNumberController.text.trim() != originalData['phoneNumber']) {
      updateDto.phoneNumber = phoneNumberController.text.trim();
    }

    if (passwordController.text.trim().isNotEmpty){
      updateDto.password = passwordController.text.trim();
    }

    final service = UpdateProfileService();

    try {
      await service.UpdateUser(dto: updateDto);

      // Show success feedback
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully.'), duration: Duration(seconds: 2),),
      );
      await Future.delayed(Duration(seconds: 2));

      if (!mounted) return;

      Navigator.pop(context, updateDto);
    } on ApiException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Unexpected error occurred.';
      });
      SnackBar(content: Text('Error: $e'));
    }

  }


  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: MyNavDrawer(dto: widget.dto,),
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SafeArea(
          child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded
                (
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () => context.pop(),
                          ),
                        ),
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
                        controller: firstNameController,
                      ),
                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Last Name",
                            border: OutlineInputBorder()
                          ),
                          controller: lastNameController,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder()
                          ),
                          controller: emailController,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Age",
                            border: OutlineInputBorder()
                          ),
                          controller: ageController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                            border: OutlineInputBorder()
                          ),
                          controller: phoneNumberController,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Address",
                            border: OutlineInputBorder()
                          ),
                          controller: addressController,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Divider(thickness: 2,),
                      SizedBox(height: 20,),
                      Center(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "New Password",
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _newPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: (){
                                setState(() {
                                  _newPasswordVisible = !_newPasswordVisible;
                                });
                              },
                            ),
                            
                          ),
                          obscureText: !_newPasswordVisible,
                          controller: passwordController,
                            
                        ),
                      ),
            
                      SizedBox(height: 20,),
                      Center(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: (){
                                setState(() {
                                  _confirmPasswordVisible = !_confirmPasswordVisible;
                                });
                              },

                          )),
                          obscureText: !_confirmPasswordVisible,
                          controller: confirmPasswordController,
                        ),
                      ),
                    ],
                  )
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(onPressed: () {
                  final newPass = passwordController.text.trim();
                  final confirmPass = confirmPasswordController.text.trim();

                  if (newPass != confirmPass) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Passwords do not match")),
                      
                    );
                    return; // Don't pop!
                  }
                  saveChanges();
                }, child: Text("Save Changes")),
              ),
              
              
            ],
          ),
        ),
      ),

    );
  }
}