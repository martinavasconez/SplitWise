import 'package:flutter/material.dart';
import 'SignInScreen.dart';
import 'Usuario.dart'; // Importa la clase Usuario

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
                onPressed: () {
                  // Verifica que todos los campos estén completos antes de crear el objeto Usuario
                  if (nameController.text.isNotEmpty &&
                      emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    setState(() {
                      // Crea el objeto Usuario con los datos ingresados
                      usuario = Usuario(
                        nombre: nameController.text,
                        correo: emailController.text,
                        password: passwordController.text,
                        listaDeGrupos: [],
                      );
                    });

                    // Redirige al usuario a la pantalla de inicio de sesión
                    Navigator.push(context, MaterialPageRoute(builder: (_) => SignInScreen()));
                  }
                  // Si algún campo está vacío, puedes mostrar un mensaje o realizar otra acción
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
