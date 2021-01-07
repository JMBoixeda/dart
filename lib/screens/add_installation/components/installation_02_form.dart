import 'package:flutter/material.dart';
import 'package:merge_map/merge_map.dart';

import 'package:emc2/screens/add_installation/components/dropdown_power_comsumption.dart';
import 'package:emc2/screens/add_installation/components/dropdown_power_installed.dart';
import 'package:emc2/screens/add_installation/components/dropdown_facade_availability.dart';
import 'package:emc2/screens/add_installation/components/dropdown_orientation.dart';

class Installation02Form extends StatefulWidget {
  final Map data;
  final Function(Map) myData;

  Installation02Form({Key key, this.data, this.myData})
      : super(key: key);

  @override
  _Installation02FormState createState() => _Installation02FormState();
}

class _Installation02FormState extends State<Installation02Form> {
  final GlobalKey<FormState> _formKey = GlobalKey();

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
  void initState() {
    super.initState();
    _installation = mergeMap([
      _installation,
      widget.data,
    ]);

    // Additional initialization of the State
    if (_installation['powerinstalled'] == '') {
      _installation['powerinstalled'] = '5 kW/h';
    }
    if (_installation['comsumption'] == '') {
      _installation['comsumption'] = '0 - 5 kW/h';
    }
    if (_installation['facadeavailabiity'] == '') {
      _installation['facadeavailabiity'] = '0 - 5 m2';
    }
    if (_installation['orientation'] == '') {
      _installation['orientation'] = 'Norte';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                DropDownPowerInstalled(
                  initialValue: _installation['powerinstalled'],
                  getData: (String val) {
                    setState(() {
                      _installation['powerinstalled'] = val;
                    });
                    widget.myData(_installation);
                  },
                ),
                DropDownPowerComsumption(
                  initialValue: _installation['comsumption'],
                  getData: (String val) {
                    setState(() {
                      _installation['comsumption'] = val;
                    });
                    widget.myData(_installation);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                DropDownFacadeAvailability(
                  initialValue: _installation['facadeavailabiity'],
                  getData: (String val) {
                    setState(() {
                      _installation['facadeavailabiity'] = val;
                    });
                    widget.myData(_installation);
                  },
                ),
                DropDownOrientation(
                  initialValue: _installation['orientation'],
                  getData: (String val) {
                    setState(() {
                      _installation['orientation'] = val;
                    });
                    widget.myData(_installation);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
