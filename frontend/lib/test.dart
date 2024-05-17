import 'package:proyectofinal/Usuario.dart'; // Adjust the import path according to your project structure
import 'package:proyectofinal/Grupo.dart'; // Adjust the import path according to your project structure
void main() async {
  String email = 'gaby@example.com';
  String password = 'pass';

  // Grupo grupo = Grupo(id: 1, nombre: 'Grupo 1', detalles: 'Detalles del grupo', total: 100.0);
  // List<Grupo> listaDeGrupos = [grupo];

  // Call the signIn method
  Usuario ?user = await Usuario.signIn(email, password);


  await user?.fetchGroups();
  print(user?.listaDeGrupos.length);

  await user?.joinGroup(1001);
  print(user?.listaDeGrupos.length);

  print("done");



}