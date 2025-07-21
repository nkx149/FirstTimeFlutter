class LoginResponseDto {
  final String token;
  final String username;
  final String email;
  final int id;
  final DateTime dateRegistered;
  final String? address;
  final String? firstName;
  final String? lastName;
  final int? age;
  final String? gender;
  final String? phoneNumber;

  
  LoginResponseDto(
    {
      required this.token,
      required this.username,
      required this.email,
      required this.id,
      required this.dateRegistered,
      required this.address,
      required this.firstName,
      required this.lastName,
      required this.age,
      required this.gender,
      required this.phoneNumber


    }
  );

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(
      token: json['token'],
      username: json['username'],
      email: json['email'],
      id: json['id'],
      dateRegistered: DateTime.parse(json['dateRegistered']),
      address: json['address'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      age: json['age'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
    );
  }
}