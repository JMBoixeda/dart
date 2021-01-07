import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class DropDownPowerComsumption extends StatelessWidget {
  final Function(String) getData;
  final String initialValue;
  final listPower = [
    "0 - 5 kW/h",
    "5 - 10 kW/h",
    "10 - 15 kW/h",
    "15 -20 kW/h",
    "20 - 25 kW/h",
    "25+ kW/h",
  ];

  DropDownPowerComsumption({
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
        items: listPower,
        label: "Consumo",
        hint: "Seleccione el rango de consumo de su instalacion actual",
        onChanged: (value) {
          getData(value);
        },
        selectedItem: initialValue == '' ? '0 - 5 kW/h'  : initialValue,
      ),
    );
  }
}
