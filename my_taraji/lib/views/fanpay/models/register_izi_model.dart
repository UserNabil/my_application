import 'dart:io';

class RegisterModel {
  String firstName;
  String lastName;
  String legalId;
  String email;
  int gender;
  String phone;
  String birthDate;
  String address;
  File? selfie;
  File? legalIdFront;
  File? legalIdBack;

  RegisterModel({
    required this.firstName,
    required this.lastName,
    required this.legalId,
    required this.email,
    required this.gender,
    required this.phone,
    required this.birthDate,
    required this.address,
    this.selfie,
    this.legalIdFront,
    this.legalIdBack,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      legalId: json['legalId'],
      email: json['email'],
      gender: json['gender'],
      phone: json['phone'],
      birthDate: json['birthDate'],
      address: json['address'],
      selfie: json['selfie'],
      legalIdFront: json['legalIdFront'],
      legalIdBack: json['legalIdBack'],
    );
  }
}
