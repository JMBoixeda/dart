import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:emc2/screens/installation_detail_screen.dart';

import 'package:emc2/screens/add_installation/add_installation_01_screen.dart';
import '../providers/installation_set.dart';
import 'installation_detail_screen.dart';
import 'package:emc2/screens/project_detail_screen.dart';
import 'package:emc2/widgets/app_drawer.dart';

class InstallationsListScreen extends StatefulWidget {
  static const routeName = '/installation-list';

  @override
  _InstallationsListScreenState createState() =>
      _InstallationsListScreenState();
}

class _InstallationsListScreenState extends State<InstallationsListScreen> {
  int _showDropDown = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instalaciones"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(AddInstallation01Screen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Center(
        child: FutureBuilder(
          future: Provider.of<InstallationSet>(context, listen: false)
              .fetchAndSetInstallations(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<InstallationSet>(
                  child: Center(
                    child: const Text(
                        'No hay instalaciones registradas. Comience añadiendo alguna'),
                  ),
                  builder: (context, installations, ch) =>
                      installations.items.length <= 0
                          ? ch
                          : ListView.builder(
                              itemCount: installations.items.length,
                              itemBuilder: (ctx, i) => Stack(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: FileImage(
                                        installations.items[i].image,
                                      ),
                                    ),
                                    title: Text(installations.items[i].title),
                                    subtitle:
                                        Text(installations.items[i].address),
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          InstallationDetailScreen.routeName,
                                          arguments: installations.items[i].id);
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        _showDropDown = i;
                                      });
                                    },
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: _showDropDown == i
                                        ? DropDownSelector(
                                            data: installations.items[i].id)
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                ),
        ),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class DropDownSelector extends StatefulWidget {
  final data;
  DropDownSelector({Key key, this.data}) : super(key: key);

  @override
  _DropDownSelectorState createState() => _DropDownSelectorState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropDownSelectorState extends State<DropDownSelector> {
  var dropdownValue = 'Detalles';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Theme.of(context).primaryColor),
        underline: Container(
          height: 2,
          color: Theme.of(context).primaryColor,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
          switch (newValue) {
            case 'Detalles':
              {
                Navigator.of(context).pushNamed(
                    InstallationDetailScreen.routeName,
                    arguments: widget.data);
              }
              break;
            case 'Proyecto':
              {
                Navigator.of(context).pushNamed(ProjectDetailScreen.routeName,
                    arguments: widget.data);
              }
              break;
            default:
              {
                print('after');
                break;
              }
          }
        },
        items: <String>[
          'Detalles',
          'Proyecto',
          'Estadisticas',
          'Instaladores',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
