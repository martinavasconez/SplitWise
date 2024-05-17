import 'package:http/http.dart' as http;
import '/config/api.dart' as api; // Import the Api class
import 'dart:convert';
import 'Grupo.dart';

class Usuario {
  int? id;
  String nombre;
  String correo;
  String password;
  List<Grupo> listaDeGrupos;

  Usuario({
    this.id,
    required this.nombre,
    required this.correo,
    required this.password,
    this.listaDeGrupos = const [],
  });

  // Factory constructor that creates a Usuario instance from a JSON object
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      correo: json['correo'],
      password: '', // Assuming password is not included in the JSON for security reasons
    );
  }

  static Future<Usuario?> signIn(String email, String password) async {
  final response = await http.post(
    Uri.parse('${api.apiBaseUrlEmulator}/signin'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'correo': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var userJson = jsonResponse['user'];
    return Usuario.fromJson(userJson);
  } else {
    print('Failed to sign in.');
    throw Exception('Failed to sign in');
  }
}

  static Future<Usuario> signUp(String nombre, String correo, String password) async {
    final response = await http.post(
      Uri.parse('${api.apiBaseUrlEmulator}/signup'), // Adjust the URL according to your API base URL configuration
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nombre': nombre, 'correo': correo, 'password': password}),
    );

    if (response.statusCode == 201) { // Assuming successful creation returns status code 201
      var jsonResponse = jsonDecode(response.body);
      var userJson = jsonResponse['user'];
      return Usuario.fromJson(userJson);
    } else {
      print('Failed to sign up.');
      throw Exception('Failed to register'); 
    }
  }


  Future<void> fetchGroups() async {
  int? userId = id; // Removed unnecessary 'this.'
  final response = await http.get(
    Uri.parse('${api.apiBaseUrlEmulator}/groups/$userId'), // Removed unnecessary braces
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);

    List<Grupo> groups = [];
    for (var group in jsonResponse) {
      groups.add(Grupo.fromJson(group));
    }
    listaDeGrupos = groups; // Directly assign without 'this.'

  } else {
    throw Exception('Failed to fetch groups');
  }
}

}