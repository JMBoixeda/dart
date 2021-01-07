import 'dart:io';
import 'dart:math';

import 'package:emc2/screens/show_forecasted_offer_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:merge_map/merge_map.dart';

import '../../widgets/image_input.dart';
import '../../providers/installation_set.dart';
import 'package:emc2/providers/projects.dart';
import 'package:emc2/screens/add_installation/add_installation_01_screen.dart';
import 'package:emc2/screens/add_installation/components/installation_02_form.dart';
import 'package:emc2/screens/installations_list_screen.dart';

class AddInstallation02Screen extends StatefulWidget {
  static const routeName = '/add-installation-02';

  @override
  _AddInstallation02ScreenState createState() =>
      _AddInstallation02ScreenState();
}

class _AddInstallation02ScreenState extends State<AddInstallation02Screen> {
  bool controllersCreated = false;
  Random _random = Random.secure();

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

  File _pickedImage;

  Map _updateInstallation(Map<dynamic, dynamic> installationData) {
    _installation = mergeMap([
      _installation,
      installationData,
    ]);
    return _installation;
  }

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
    _installation['image'] = pickedImage;
  }

  void _saveInstallation() async {
    if (_installation['title'].isEmpty ||
        //    _pickedLocation == null ||
        _pickedImage == null) return;

    final retValue =
        await Provider.of<InstallationSet>(context, listen: false).addInstallation(
      _installation['title'],
      _installation['address'],
      _installation['city'],
      _installation['dp'],
      _installation['state'],
      _installation['powerinstalled'],
      _installation['comsumption'],
      _installation['facadeavailabiity'],
      _installation['orientation'],
      _installation['location'],
      _installation['image'],
    );
    Provider.of<Projects>(context, listen: false)
        .newProject(retValue[0], _installation['title'], retValue[1]);
//    Navigator.of(context).pop();
    Navigator.of(context).pushNamedAndRemoveUntil(
        ShowForecastedOfferScreen.routeName,
        ModalRoute.withName(InstallationsListScreen.routeName));
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
          title: Text('Añadir Instalación (2)'),
        ),
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
                        height: 230,
                        constraints: BoxConstraints(
                          minHeight: 200,
                        ),
                        child: Installation02Form(
                          data: _installation,
                          myData: (Map<dynamic, dynamic> data) {
                            _updateInstallation(data);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ImageInput(_selectImage),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonTheme(
                  minWidth: 150,
                  child: RaisedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, AddInstallation01Screen.routeName,
                          arguments: _installation);
                    },
                    icon: Icon(Icons.arrow_back),
                    label: Text('Datos Ubicación'),
                    elevation: 0,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                ButtonTheme(
                  minWidth: 150,
                  child: RaisedButton.icon(
                    onPressed: _saveInstallation,
                    icon: Icon(Icons.arrow_right),
                    label: Text('Añadir Nueva Instalación'),
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
