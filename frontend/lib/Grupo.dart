class Grupo {
  int id;
  String nombre;
  String detalles;
  Map<int, Map<String, double>> articulos; // Mapa de usuario ID a artículos y costo
  double total;
  Map<int, double> totalPorUsuario; // Total gastado por cada usuario
  Map<int, Map<int, double>> deudaPorUsuario; // Deuda de cada usuario hacia otros usuarios
  Map<int, String> listaDeUsuarios; // Mapa de usuario ID a nombre

  // Lista de miembros del grupo
  List<int> miembros;

  Grupo({
    required this.id,
    required this.nombre,
    this.detalles = "",
    this.articulos = const {},
    this.total = 0,
    this.totalPorUsuario = const {},
    this.deudaPorUsuario = const {},
    this.listaDeUsuarios = const {},
    this.miembros = const [], // Inicializar como una lista vacía
  });

  factory Grupo.fromJson(Map<String, dynamic> json) {
    return Grupo(
      id: json['id'],
      nombre: json['nombre'],
      detalles: json['detalles'] ?? "", // Provide a default value in case 'detalles' is null
      total: double.tryParse(json['total']) ?? 0.0, // Attempt to parse 'total' as a double, defaulting to 0.0 if parsing fails
    );
  }

  // Método para añadir un artículo al grupo
  void addArticulo(int usuarioId, String nombreArticulo, double costo) {
    if (articulos.containsKey(usuarioId)) {
      articulos[usuarioId]![nombreArticulo] = costo;
    } else {
      articulos[usuarioId] = {nombreArticulo: costo};
    }
    total += costo;
    totalPorUsuario.update(usuarioId, (valor) => valor + costo, ifAbsent: () => costo);
    // Aquí deberías actualizar también la deudaPorUsuario según necesites
  }
}
