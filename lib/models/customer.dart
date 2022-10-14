class CustomerModel {
  String email;
  String username;
  String firstname;
  String lastname;
  String password;

  CustomerModel(
      {required this.email,
      required this.username,
      required this.firstname,
      required this.lastname,
      required this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map.addAll({
      'username': username,
      'email': email,
      'first_name': firstname,
      'last_name': lastname,
      'password': password
    });

    return map;
  }
}
