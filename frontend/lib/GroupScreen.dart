import 'package:flutter/material.dart';
import 'CreateGroupScreen.dart';
import 'JoinGroupScreen.dart';
import 'GroupDetailsScreen.dart';
import 'Grupo.dart';
import 'Usuario.dart';

class GroupScreen extends StatefulWidget {
  final Usuario? usuario;
  final Grupo? group;

  GroupScreen({this.group, this.usuario});

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

  Widget buildGroupCard(String groupName, String groupCode) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.group),
        title: Text(groupName),
        subtitle: Text('Code: $groupCode'),
        onTap: () {
        Grupo grupoSeleccionado = widget.usuario!.getGroupById(int.parse(groupCode))!;
        grupoSeleccionado.updateGroupDetails();
        grupoSeleccionado.updateDeudaPorUsuario();
         Navigator.push(context, MaterialPageRoute(builder: (context) => GroupDetailsScreen(group: grupoSeleccionado, usuario: widget.usuario)));
},

      ),
    );
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
                widget.usuario?.nombre?? "Johanna Doe",
                style: TextStyle(color: Colors.black),
              ),
              accountEmail: Text(
                widget.usuario?.correo?? "johanna@company.com",
                style: TextStyle(color: Colors.black),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/JeanDoe.png'),
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
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.group_add),
              title: Text(
                'Create Group',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateGroupScreen(usuario: widget.usuario,)));
              },
            ),
            ListTile(
              leading: Icon(Icons.input),
              title: Text(
                'Join Group',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => JoinGroupScreen(usuario: widget.usuario,)));
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            itemCount: widget.usuario?.listaDeGrupos?.length?? 0,
            itemBuilder: (context, index) {
              Grupo grupo = widget.usuario!.listaDeGrupos![index];
              return buildGroupCard(grupo.nombre!, grupo.id.toString());
            },
          ),
        ],
      ),
    );
  }
}