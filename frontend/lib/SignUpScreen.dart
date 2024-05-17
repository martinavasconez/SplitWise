import 'package:flutter/material.dart';
import 'SignInScreen.dart';
import 'Usuario.dart'; // Importa la clase Usuario
import 'GroupScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController(); 

  Usuario? usuario; // Variable para almacenar el objeto Usuario

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Name',
              style: TextStyle(
                color: Color.fromARGB(255, 78, 179, 204),
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Your name',
                border: UnderlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  // Actualiza el nombre del usuario en el objeto Usuario
                  usuario?.nombre = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Email',
              style: TextStyle(
                color: Color.fromARGB(255, 78, 179, 204),
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Your email address',
                border: UnderlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                setState(() {
                  // Actualiza el correo electrónico del usuario en el objeto Usuario
                  usuario?.correo = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Password',
              style: TextStyle(
                color: Color.fromARGB(255, 78, 179, 204),
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Your password',
                border: UnderlineInputBorder(),
              ),
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  // Actualiza la contraseña del usuario en el objeto Usuario
                  usuario?.password = value;
                });
              },
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (nameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Error"),
                          content: const Text("Please fill all fields"),
                          actions: <Widget>[
                            TextButton(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }
                  try {
                    // Use the signUp method from Usuario.dart
                    Usuario newUser = await Usuario.signUp(nameController.text, emailController.text, passwordController.text);

                    // Navigate to SignInScreen on success
                    Navigator.push(context, MaterialPageRoute(builder: (_) => GroupScreen(usuario: newUser,)));

                    // Clear text fields
                    nameController.clear();
                    emailController.clear();
                    passwordController.clear();
                  } catch (e) {
                    // Show an alert dialog on error
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Error"),
                          content: Text(e.toString()),
                          actions: <Widget>[
                            TextButton(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },

                child: Text('Continue'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 78, 179, 204),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            Spacer(),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => SignInScreen()));
                },
                child: Text(
                  'Have an Account? Sign In',
                  style: TextStyle(
                    color: Color.fromARGB(255, 78, 179, 204),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
