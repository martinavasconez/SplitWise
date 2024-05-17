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

  await user?.listaDeGrupos[0].updateGroupDetails();

  var userID = user?.id;

  print('test');

  await user?.listaDeGrupos[0].updateDeudaPorUsuario();

  await user?.listaDeGrupos[0].updateGroupDetails();

  print("done");



}