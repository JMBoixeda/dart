import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class DropDownOrientation extends StatelessWidget {
  final Function(String) getData;
  final String initialValue;
  final listOrientation = [
    "Norte",
    "Sur",
    "Este",
    "Oeste",
  ];

  DropDownOrientation({
    Key key,
    this.getData,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      child: DropdownSearch<String>(
        mode: Mode.MENU,
        showSelectedItem: true,
        items: listOrientation,
        label: "Orientacion",
        hint: "Seleccione la orientacion de su fachada",
        onChanged: (value) {
          getData(value);
        },
        selectedItem: initialValue == '' ? 'Norte' : initialValue,
      ),
    );
  }
}
