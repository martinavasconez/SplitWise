import 'package:flutter/material.dart';
import 'GroupScreen.dart';
import 'SignUpScreen.dart';
import 'Usuario.dart'; // Importamos la clase Usuario para su uso aquí

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  void _signIn() async {
  // Obtenemos el correo y la contraseña ingresados por el usuario
  String email = emailController.text;
  String password = passwordController.text;

  try {
    // Intentamos iniciar sesión usando el método signIn de Usuario
    Usuario? usuario = await Usuario.signIn(email, password);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GroupScreen()),
      );
    
  } catch (e) {
    // Manejo de excepciones para errores inesperados durante el proceso de inicio de sesión
    print("Error al iniciar sesión: $e");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error de inicio de sesión'),
          content: Text('Ocurrió un error inesperado. Por favor, inténtalo de nuevo más tarde.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Center(
                child: Image.asset(
                  'assets/images/Logo.png',
                  height: 100,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'SplitWise',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 78, 179, 204),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Hi there! Nice to see you again.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 30),
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
                  hintText: 'example@email.com',
                  border: UnderlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
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
                  hintText: 'password',
                  border: UnderlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _signIn,
                  child: Text('Sign In'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 78, 179, 204), // Color del botón
                    foregroundColor: Colors.white, // Color del texto   // Color del texto
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: Text(
                    "Don't have an Account? Sign Up",
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
      ),
    );
  }
}
