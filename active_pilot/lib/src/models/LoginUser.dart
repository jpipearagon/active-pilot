import 'User.dart';

class LoginUser {
    String? jwtToken;
    String? refreshToken;
    User? user;

    LoginUser({this.jwtToken, this.refreshToken, this.user});

    factory LoginUser.fromJson(Map<String, dynamic> json) {
        return LoginUser(
            jwtToken: json['jwtToken'], 
            refreshToken: json['refreshToken'], 
            user: json['user'] != null ? User.fromJson(json['user']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['jwtToken'] = this.jwtToken;
        data['refreshToken'] = this.refreshToken;
        if (this.user != null) {
            data['user'] = this.user?.toJson();
        }
        return data;
    }
}