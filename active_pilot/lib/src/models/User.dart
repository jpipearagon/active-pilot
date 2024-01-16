
class User {
    String? id;
    String? email;
    String? role;

    User({this.id, this.email, this.role});

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            id: json['_id'],
            email: json['email'], 
            role: json['role'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this.id;
        data['email'] = this.email;
        data['role'] = this.role;
        return data;
    }
}