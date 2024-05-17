import 'Grupo.dart';

class Usuario {
  int? id;
  String nombre;
  String correo;
  String password;
  List<Grupo> listaDeGrupos;

  Usuario({
    this.id,
    this.nombre = "", // Inicialización con cadena vacía
    this.correo = "", // Inicialización con cadena vacía
    this.password = "", // Inicialización con cadena vacía
    this.listaDeGrupos = const [], // Inicialización con lista vacía constante
    });
}
