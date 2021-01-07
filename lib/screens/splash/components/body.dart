import 'package:emc2/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:emc2/constants.dart';
import 'package:emc2/screens/auth_screen.dart';
import 'package:emc2/size_config.dart';
import 'package:emc2/components/default_button.dart';
import 'package:emc2/providers/auth.dart';
import 'package:emc2/screens/installations_list_screen.dart';
import 'package:emc2/screens/splash_emc2_screen.dart';
import 'package:emc2/providers/config_provider.dart';

// This is the best practice
import '../components/splash_content.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text":
          "Bienvenido a EMC2. \nLa aplicación que le ayuda a gestionar su energía",
      "image": "assets/images/splash_1.png"
    },
    {
      "text":
          "Ayudamos a las personas a instalar y explotar sus proyectos de energías renovables",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "Gestione sus excedentes de producción eléctrica.",
      "image": "assets/images/splash_3.png"
    },
  ];

  void _onFollow(ctx, config) async {
    await config.addConfig(false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Consumer<ConfigProvider>(
                builder: (ctx, config, _) => Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => buildDot(index: index),
                        ),
                      ),
                      Spacer(flex: 3),
                      DefaultButton(
                        text: "Continuar",
                        press: () {
                          _onFollow(context, config);
                          MyApp();
                        },
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
