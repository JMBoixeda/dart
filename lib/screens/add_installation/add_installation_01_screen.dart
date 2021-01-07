import 'dart:math';

import 'package:emc2/screens/add_installation/components/installation_01_form.dart';
import 'package:flutter/material.dart';
import 'package:merge_map/merge_map.dart';

import 'package:emc2/widgets/location_input.dart';
import 'package:emc2/models/installation.dart';
import 'package:emc2/screens/add_installation/add_installation_02_screen.dart';
import 'package:emc2/widgets/app_drawer.dart';

class AddInstallation01Screen extends StatefulWidget {
  static const routeName = '/add-installation-01';

  @override
  _AddInstallation01ScreenState createState() =>
      _AddInstallation01ScreenState();
}

class _AddInstallation01ScreenState extends State<AddInstallation01Screen> {
  TextEditingController _titleController;
  TextEditingController _addressController;
  TextEditingController _dpController;
  TextEditingController _cityController;
  TextEditingController _stateController;

  Random _random = Random.secure();
  bool controllersCreated = false;

  Map _installation = {
    'id': '',
    'title': '',
    'address': '',
    'city': '',
    'dp': '',
    'state': '',
    'powerinstalled': '',
    'comsumption': '',
    'facadeavailabiity': '',
    'orientation': '',
    'location': '',
    'image': '',
  };

  Map<String, TextEditingController> _controllers = {
    'title': null,
    'address': null,
    'city': null,
    'dp': null,
    'state': null,
  };

  InstallationLocation _pickedLocation;

  Map _generateInstallation(Map<dynamic, dynamic> installationData) {
    var _randomNumber = _random.nextInt(10000);
    _installation['title'] = 'Install$_randomNumber';
    _installation['location'] = _pickedLocation;
    return _installation;
  }

  Map<String, TextEditingController> _generateControllers() {
    setState(() {
      _controllers['title'] = _titleController;
      _controllers['address'] = _addressController;
      _controllers['city'] = _cityController;
      _controllers['dp'] = _dpController;
      _controllers['state'] = _stateController;
    });
    return _controllers;
  }

  void _cancelSelection() {
    Navigator.of(context).pop();
  }

  void _selectInstallation(Installation installation, double lat, double lng) {
    _pickedLocation = InstallationLocation(latitude: lat, longitude: lng);
    setState(() {
      _installation['address'] = installation.address;
      _installation['city'] = installation.city;
      _installation['dp'] = installation.dp;
      _installation['state'] = installation.state;
      _installation['location'] = InstallationLocation(latitude: lat, longitude: lng);
    });
  }

  @override
  void initState() {
    super.initState();
    // Additional initialization of the State
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> _installationData =
        ModalRoute.of(context).settings.arguments;

    _installation = mergeMap([
      _installation,
      _installationData,
    ]);

    return Scaffold(
        appBar: AppBar(
          title: Text('Añadir Instalación (1)'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.pushNamed(context, AddInstallation02Screen.routeName,
                    arguments: _installation);
              },
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 280,
                        constraints: BoxConstraints(
                          minHeight: 200,
                        ),
                        child: Installation01Form(
                          data: _generateInstallation(_installation),
                          controllers: _generateControllers(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      LocationInput(_selectInstallation),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonTheme(
                  minWidth: 200,
                  child: RaisedButton.icon(
                    onPressed: _cancelSelection,
                    icon: Icon(Icons.cancel),
                    label: Text('Cancelar'),
                    elevation: 0,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                ButtonTheme(
                  minWidth: 150,
                  child: RaisedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, AddInstallation02Screen.routeName,
                          arguments: _installation);
                    },
                    icon: Icon(Icons.arrow_forward),
                    label: Text('Datos de Consumo'),
                    elevation: 0,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
