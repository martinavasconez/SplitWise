import 'package:flutter/material.dart';
import 'CreateGroupScreen.dart';
import 'JoinGroupScreen.dart';
import 'GroupDetailsScreen.dart'; // Asegúrate de importar la pantalla de detalles del grupo
import 'Grupo.dart'; // Importamos la clase Grupo para su uso aquí

class GroupScreen extends StatefulWidget {
  final Grupo? group; // Ahora group puede ser nulo

  GroupScreen({this.group});

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Groups"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Column(
            children: [
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(right: 16.0),
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: 'Joined Groups'),
                  ],
                  indicatorColor: Colors.black,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                "Johanna Doe",
                style: TextStyle(color: Colors.black), // Cambia el color del texto a negro
              ),
              accountEmail: Text(
                "johanna@company.com",
                style: TextStyle(color: Colors.black), // Cambia el color del texto a negro
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/JeanDoe.png'), // Ruta de la imagen de perfil
                backgroundColor: Colors.white,
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text(
                'Groups',
                style: TextStyle(color: Colors.black), // Cambia el color del texto a negro
              ),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.group_add),
              title: Text(
                'Create Group',
                style: TextStyle(color: Colors.black), // Cambia el color del texto a negro
              ),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateGroupScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.input),
              title: Text(
                'Join Group',
                style: TextStyle(color: Colors.black), // Cambia el color del texto a negro
              ),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => JoinGroupScreen()));
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            children: [
              // Aquí mostramos el nuevo grupo como una tarjeta en la lista de grupos
              if (widget.group != null)
                Card(
                  child: ListTile(
                    leading: Icon(Icons.group),
                    title: Text(widget.group!.nombre ?? ''), // Nombre del grupo
                    // Subtítulo con más detalles del grupo si es necesario
                    subtitle: Text('Code: ${widget.group!.id ?? ''}'), // ID del grupo
                    onTap: () {
                      // Navegación a GroupDetailsScreen al tocar el grupo
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GroupDetailsScreen()));
                    },
                  ),
                ),
              // Cards que ya estaban implementadas
              Card(
                child: ListTile(
                  leading: Icon(Icons.group),
                  title: Text('Plan Zens'),
                  subtitle: Text('Code: 1139'),
                  onTap: () {
                    // Navegación a GroupDetailsScreen al tocar el grupo
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GroupDetailsScreen()));
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.group),
                  title: Text('Restaurante KFC'),
                  subtitle: Text('Code: 3365'),
                  onTap: () {
                    // Navegación a GroupDetailsScreen al tocar el grupo
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GroupDetailsScreen()));
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.group),
                  title: Text('Uber'),
                  subtitle: Text('Code: 3434'),
                  onTap: () {
                    // Navegación a GroupDetailsScreen al tocar el grupo
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GroupDetailsScreen()));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
