import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class DropDownPowerInstalled extends StatelessWidget {
  final Function(String) getData;
  final String initialValue;
  final listPowerInstalled = [
    "5 kW/h",
    "10 kW/h",
    "15 kW/h",
    "20 kW/h",
    "25 kW/h",
    "25+ kW/h",
  ];

  DropDownPowerInstalled({
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
        items: listPowerInstalled,
        label: "Potencia Instalada",
        hint: "Seleccione la potencia nominal de su instalacion actual",
        onChanged: (value) {
          getData(value);
        },
        selectedItem: initialValue == '' ? '5 kW/h' : initialValue,
      ),
    );
  }
}
