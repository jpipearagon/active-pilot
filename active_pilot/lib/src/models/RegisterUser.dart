
import 'Country.dart';

class RegisterUser {
    int v;
    String id;
    Country country;
    String dateBirth;
    bool deleted;
    String email;
    String firstName;
    String gender;
    String lastName;
    String password;
    String phone;
    String role;

    RegisterUser({this.v, this.id, this.country, this.dateBirth, this.deleted, this.email, this.firstName, this.gender, this.lastName, this.password, this.phone, this.role});

    factory RegisterUser.fromJson(Map<String, dynamic> json) {
        return RegisterUser(
            v: json['__v'],
            id: json['_id'],
            country: json['country'] != null ? Country.fromJson(json['country']) : null, 
            dateBirth: json['dateBirth'], 
            deleted: json['deleted'], 
            email: json['email'], 
            firstName: json['firstName'], 
            gender: json['gender'], 
            lastName: json['lastName'], 
            password: json['password'], 
            phone: json['phone'], 
            role: json['role'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['__v'] = this.v;
        data['_id'] = this.id;
        data['dateBirth'] = this.dateBirth;
        data['deleted'] = this.deleted;
        data['email'] = this.email;
        data['firstName'] = this.firstName;
        data['gender'] = this.gender;
        data['lastName'] = this.lastName;
        data['password'] = this.password;
        data['phone'] = this.phone;
        data['role'] = this.role;
        if (this.country != null) {
            data['country'] = this.country.toJson();
        }
        return data;
    }
}