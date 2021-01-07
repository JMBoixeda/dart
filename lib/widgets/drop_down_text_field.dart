import 'package:flutter/material.dart';

class DropDownTextField extends StatelessWidget {
  final _controller = TextEditingController();
  final List<String> items;
  final String title;

  DropDownTextField({Key key, this.items, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: title,
        suffixIcon: PopupMenuButton<String>(
          icon: const Icon(Icons.arrow_drop_down),
          onSelected: (String value) {
            _controller.text = value;
          },
          itemBuilder: (BuildContext context) {
            return items.map<PopupMenuItem<String>>((String value) {
              return new PopupMenuItem(child: new Text(value), value: value);
            }).toList();
          },
        ),
      ),
    );
  }
}
