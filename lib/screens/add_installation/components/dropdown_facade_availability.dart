import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class DropDownFacadeAvailability extends StatelessWidget {
  final Function(String) getData;
  final String initialValue;
  final listAvailability = [
    "0 - 5 m2",
    "5 - 10 m2",
    "10 - 15 m2",
    "15 -20 m2",
    "20 - 25 m2",
    "25+ m2",
  ];

  DropDownFacadeAvailability({
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
        items: listAvailability,
        label: "Disponibilidad de Fachada",
        hint: "Seleccione los metros cuadrados disponibles en su fachada",
        onChanged: (value) {
          getData(value);
        },
        selectedItem: initialValue == '' ? '0 - 5 m2' : initialValue,
      ),
    );
  }
}
