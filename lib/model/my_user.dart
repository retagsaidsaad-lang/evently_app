class MyUser {

  static const String collectionName = 'Users';

  String uId;
  String name;
  String email;

  MyUser({required this.uId, required this.name, required this.email});


  MyUser.fromJson(Map<String, dynamic> data) : this(
    uId: data ['id'] as String,
    name: data ['name'] as String,
    email: data ['email'] as String,
  );


  Map<String, dynamic> toJson() {
    return {
      'id': uId,
      'name': name,
      'email': email
    };
  }
}