class User {
  final String id, name, token, sensorId, email, firebaseToken;

  User(
      {required this.id,
      required this.email,
      required this.name,
      required this.sensorId,
      required this.token,
      required this.firebaseToken});

  static User fromJson(dynamic data, {String? firebaseToken}) {
    return User(
        email: data['user']['email'],
        id: data['user']['id'],
        name: data['user']['name'],
        sensorId: data['user']['sensorId'],
        token: data['token'],
        firebaseToken: data['firebaseToken'] ?? firebaseToken);
  }

  dynamic toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'token': token,
      'sensorId': sensorId,
      'firebaseToken': firebaseToken
    };
  }
}
