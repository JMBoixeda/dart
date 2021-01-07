import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:provider/provider.dart';

import 'package:emc2/models/province.dart';
import 'package:emc2/providers/province_set.dart';

class DropDownSearchProvinces extends StatelessWidget {
  final String init;
  final listProvinces = [
    "Alava",
    "Barcelona",
    "Almeria",
    "Albacete",
    "Badajoz",
    "Madrid",
  ];

  DropDownSearchProvinces({Key key, this.init}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: DropdownSearch<String>(
          mode: Mode.MENU,
          showSelectedItem: true,
          items: listProvinces,
          label: "Provincia",
          hint: "Seleccione una Provincia",
          popupItemDisabled: (String s) => s.startsWith('J'),
          onChanged: print,
          selectedItem: init == '' ? 'Almeria' : init),
    );
  }
}
