class Grupo {
  int id;
  String nombre;
  Map<int, Map<String, double>> articulos; // Mapa de usuario ID a artículos y costo
  double total;
  Map<int, double> totalPorUsuario; // Total gastado por cada usuario
  Map<int, Map<int, double>> deudaPorUsuario; // Deuda de cada usuario hacia otros usuarios

  Grupo({
    required this.id,
    required this.nombre,
    this.articulos = const {},
    this.total = 0,
    this.totalPorUsuario = const {},
    this.deudaPorUsuario = const {},
  });

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
