class UserUpdateDto {
   int id;
   String? firstName;
   String? lastName;
   String? phoneNumber;
   String? email;
   String? password;
   String? address;
   int? age;

  UserUpdateDto({
    required this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.password,
    this.address,
    this.age,
  });

  /// Creates an instance from a JSON map.
  factory UserUpdateDto.fromJson(Map<String, dynamic> json) {
    return UserUpdateDto(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      password: json['password'],
      address: json['address'],
      age: json['age'],
    );
  }

  /// Converts this DTO to a JSON map for sending to the API.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      if (firstName != null) 'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (address != null) 'address': address,
      if (age != null) 'age': age,
    };
  }
}
