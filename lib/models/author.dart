class Author {
  final String uid;
  final String username;
  final String email;

  Author({required this.uid, required this.email, required this.username});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      uid: json['uid'],
      username: json['username'],
      email: json['email'],
    );
  }
}
