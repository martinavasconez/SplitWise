import '/Grupo.dart';

class Usuario {
  int id;
  String nombre;
  String correo;
  String password;
  List<Grupo> listaDeGrupos; 
  
  Usuario({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.password,
    required this.listaDeGrupos,
  });
}
