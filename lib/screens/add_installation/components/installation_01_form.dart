import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:merge_map/merge_map.dart';

import 'package:emc2/models/installation.dart';
import 'package:emc2/providers/installation_set.dart';
import 'package:emc2/screens/add_installation/components/dropdown_search_provinces.dart';

class Installation01Form extends StatefulWidget {
  final Map data;
  final Map<String, TextEditingController> controllers;

  Installation01Form({Key key, this.data, this.controllers}) : super(key: key);

  @override
  _Installation01FormState createState() => _Installation01FormState();
}

class _Installation01FormState extends State<Installation01Form> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController _titleController;
  TextEditingController _addressController;
  TextEditingController _dpController;
  TextEditingController _cityController;
  TextEditingController _stateController;

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

  @override
  void dispose() {
    _titleController.dispose();
    _addressController.dispose();
    _dpController.dispose();
    _cityController.dispose();
    _stateController.dispose();

    super.dispose();
  }

  void _printLatestValueTitle() {
    print("_titleController: ${_titleController.text}");
  }

  void _printLatestValueAddress() {
    print("_addressController: ${_addressController.text}");
  }

  void _printLatestValueDP() {
    print("_dpController: ${_dpController.text}");
  }

  void _printLatestValueCity() {
    print("_cityController: ${_cityController.text}");
  }

  void _printLatestValueState() {
    print("_stateController: ${_stateController.text}");
  }

  @override
  void didUpdateWidget(Installation01Form oldWidget) {
    _installation = mergeMap([
      _installation,
      widget.data,
    ]);
    _addressController.text = _installation['address'];
    _cityController.text = _installation['city'];
    _dpController.text = _installation['dp'];
    _stateController.text = _installation['state'];
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    // Additional initialization of the State
    _installation = mergeMap([
      _installation,
      widget.data,
    ]);

    _titleController = TextEditingController(text: _installation['title']);
    _addressController = TextEditingController(text: _installation['address']);
    _dpController = TextEditingController(text: _installation['dp']);
    _cityController = TextEditingController(text: _installation['city']);
    _stateController = TextEditingController(text: _installation['state']);

    _titleController.addListener(_printLatestValueTitle);
    _addressController.addListener(_printLatestValueAddress);
    _dpController.addListener(_printLatestValueDP);
    _cityController.addListener(_printLatestValueCity);
    _stateController.addListener(_printLatestValueState);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nombre de la Instalación',
              ),
              controller: _titleController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Proporciene un nombre a la instalación!';
                }
                return null;
              },
              onSaved: (value) {
                print("Direccion New Value: $value");
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Dirección',
              ),
              controller: _addressController,
              maxLines: 2,
              validator: (value) {
                if (value.isEmpty) {
                  return 'La Dirección no existe!';
                }
                return null;
              },
              onSaved: (_) {},
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Municipio',
              ),
              controller: _cityController,
              maxLines: 2,
              validator: (value) {
                if (value.isEmpty) {
                  return 'El Municipio no existe!';
                }
                return null;
              },
              onSaved: (_) {},
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'D.P.'),
                    keyboardType: TextInputType.number,
                    controller: _dpController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'El Distrito Postal es invalido!';
                      }
                      return null;
                    },
                    onSaved: (newValue) {},
                  ),
                ),
                DropDownSearchProvinces(init: _installation['state']),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
