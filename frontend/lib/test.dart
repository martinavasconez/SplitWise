import 'package:proyectofinal/Usuario.dart'; // Adjust the import path according to your project structure

void main() async {
  String name = 'John';
  String email = 'john@example.com';
  String password = 'pass';

  // Call the signIn method
  Usuario ?user = await Usuario.signUp(name, email, password);

  print(user);



}