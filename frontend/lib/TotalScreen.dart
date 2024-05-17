import 'package:flutter/material.dart';
import 'Grupo.dart';
import 'Usuario.dart'; // Make sure this import points correctly to your Grupo.dart file

class TotalScreen extends StatefulWidget {
  final Usuario? usuario;
  final Grupo? group;

  TotalScreen({this.group, this.usuario});

  @override
  _TotalScreenState createState() => _TotalScreenState();
}

class _TotalScreenState extends State<TotalScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Widget buildPersonCard(int userId, String userName, double totalSpent) {
    return Card(
      child: ExpansionTile(
        leading: Icon(Icons.person),
        title: Text(userName),
        subtitle: Text('Total Spent: \$${totalSpent.toStringAsFixed(2)}'),
        children: widget.group!.deudaPorUsuario[userId]?.entries.map((entry) {
          int creditorId = entry.key;
          double amount = entry.value;
          String creditorName = widget.group!.listaDeUsuarios[creditorId]?? 'Unknown';
          return ListTile(
            title: Text('$creditorName will receive \$${amount.toStringAsFixed(2)}'),
          );
        }).toList()?? [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Assuming widget.group is populated and contains valid data
    if (widget.group == null || widget.group!.totalPorUsuario.isEmpty) {
      return Center(child: Text("No data available"));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Total'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Total Spent'),
            Tab(text: 'Total per Person'),
          ],
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // First tab content
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Spent',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 78, 179, 204),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.group!.total.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'USD',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Second tab content
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total per Person',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: Colors.black),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.group!.listaDeUsuarios.length,
                    itemBuilder: (context, index) {
                      int userId = widget.group!.listaDeUsuarios.keys.elementAt(index);
                      String userName = widget.group!.listaDeUsuarios[userId]!;
                      double totalSpent = widget.group!.totalPorUsuario[userId]?? 0;
                      return buildPersonCard(userId, userName, totalSpent);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}