class User {
  final String uid;
  final String username;

  User({this.uid, this.username});

  Map<String, dynamic> toMap() => {'uid': uid, 'username': username};
}
