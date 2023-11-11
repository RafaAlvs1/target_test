class User {
  String? id;
  String? nome;
  String? email;
  String? token;

  User({
    this.id,
    this.nome,
    this.email,
    this.token,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      token: map['token'],
    );
  }
}
