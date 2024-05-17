import 'package:http/http.dart' as http;
import '/config/api.dart' as api; // Import the Api class
import 'dart:convert';

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
    detalles: json['detalles']?? "", // Provide a default value in case 'detalles' is null
    total: double.tryParse(json['total'])?? 0.0, // Attempt to parse 'total' as a double, defaulting to 0.0 if parsing fails
  );
}

  Future<void> updateGroupDetails() async {
    final response = await http.get(Uri.parse('${api.apiBaseUrlEmulator}/load-group-details/$id'));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      articulos = {};
      totalPorUsuario = {};
      listaDeUsuarios = {};

      // Actualizar articulos
      for (var item in jsonResponse['articulos']) {
        int userId = item['usuario_id'];
        String itemName = item['nombre_articulo'];
        double cost = double.parse(item['costo']); 
        if (!articulos.containsKey(userId)) {
          articulos[userId] = {};
        }
        articulos[userId]![itemName] = cost;
      }

      // Actualizar total
      total = double.parse(jsonResponse['total']);

      // Actualizar totalPorUsuario
      for (var userTotal in jsonResponse['totalPorUsuario']) {
        int userId = userTotal['id_usuario'];
        double totalCost = double.parse(userTotal['total']);
        totalPorUsuario[userId] = totalCost;
      }

      // Actualizar listaDeUsuarios
      for (var user in jsonResponse['usuarios']) {
        int userId = user['id_usuario'];
        String userName = user['nombre_usuario'];
        listaDeUsuarios[userId] = userName;
      }
    } else {
      throw Exception('Failed to update group details');
    }
  }

  Future<void> addItem(String nombreArticulo, double costo, int userId) async {
    final response = await http.post(
      Uri.parse('${api.apiBaseUrlEmulator}/add_item'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'grupo_id': id,
        'user_id': userId,
        'nombre_articulo': nombreArticulo,
        'costo': costo.toString(), // Convertir costo a string para enviarlo en JSON
      }),
    );

    if (response.statusCode == 201) {
      // Item added successfully, you can update local state if necessary
      print('Item added successfully');
    } else {
      // Handle error
      print('Failed to add item');
      throw Exception('Failed to add item');
    }
  }

  Future<void> updateDeudaPorUsuario() async {
  final response = await http.post(
    Uri.parse('${api.apiBaseUrlEmulator}/update-deudas/$id'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    Map<int, Map<int, double>> deudaPorUsuario = {};

    // Parse the deuda_por_usuario field from the response
    if (jsonResponse['deuda_por_usuario']!= null) {
      for (var debtorId in jsonResponse['deuda_por_usuario'].keys) {
        Map<int, double> debts = {};
        for (var creditorId in jsonResponse['deuda_por_usuario'][debtorId].keys) {
          double debtAmount = double.parse(jsonResponse['deuda_por_usuario'][debtorId][creditorId]);
          debts[int.parse(creditorId)] = debtAmount; // Ensure creditorId is parsed to int
        }
        deudaPorUsuario[int.parse(debtorId)] = debts;
      }
    }

    // Update the deudaPorUsuario map in the current instance
    this.deudaPorUsuario = deudaPorUsuario;

    print('Deudas updated successfully');
  } else {
    return;
    throw Exception('Failed to update deudas');
  }
}

}
