import 'package:flutter/material.dart';

import 'package:emc2/screens/graphics/graphics_screen.dart';
import 'package:emc2/screens/project_detail_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('EMC2'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.data_usage),
            title: Text('Graficas'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(GraphicsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.build),
            title: Text('Instalaciones'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Gestión de Proyectos'),
            onTap: () {
              // Navigator.of(context).pushReplacementNamed(ProjectDetailScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
