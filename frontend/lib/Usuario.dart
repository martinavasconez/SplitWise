class Usuario {
  int id;
  String nombre;
  String correo;
  String cel;
  String password;
  List<int> listaDeGrupos; // Esto asume que cada grupo tiene un ID único de tipo int

  Usuario({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.cel,
    required this.password,
    required this.listaDeGrupos,
  });
}
