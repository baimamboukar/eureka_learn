import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class Purchase extends StatelessWidget {
  const Purchase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Feature> features = [
      Feature(name: "Access i-Space", isPrenium: true),
      Feature(name: "Performance Monitoring", isPrenium: true),
      Feature(name: "Self evaluation", isPrenium: false),
      Feature(name: "Ask questions", isPrenium: false),
      Feature(name: "Acess ressources", isPrenium: true),
      Feature(name: "Download ressources", isPrenium: true),
    ];
    return Scaffold(
      body: Container(
          decoration:
              BoxDecoration(gradient: Palette.gradientWith(Palette.primary)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Purchase prenium',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(height: 4),
                Center(
                  child: Text(
                    'Coming soon!',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'We are working hard to bring you the best experience possible.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Palette.dark),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 8.0,
                  child: Container(
                    width: Screen.width(context) * 0.7,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          Text(
                            "Features",
                            style: Styles.designText(
                                color: Palette.primary, size: 22, bold: true),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Basic"),
                              SizedBox(width: 20),
                              Text("Prenium")
                            ],
                          ),
                          ...features,
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return WebViewPlus(
                                        initialUrl: "www.google.com/",
                                      );
                                    });
                              },
                              child: LottieBuilder.asset(
                                  "assets/animations/prenium.json"))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class Feature extends StatelessWidget {
  final String name;
  final bool isPrenium;
  const Feature({Key? key, required this.name, required this.isPrenium})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            LineIcons.dotCircle,
            size: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(name,
              style: GoogleFonts.alexBrush(
                color: Colors.amber,
                fontSize: 18,
              )),
          Expanded(
            child: Container(),
          ),
          Icon(
            isPrenium ? LineIcons.timesCircle : LineIcons.checkCircleAlt,
            color: isPrenium ? Palette.error : Palette.success,
          ),
          SizedBox(width: 35),
          Icon(
            LineIcons.checkCircleAlt,
            color: Palette.success,
          ),
        ],
      ),
    );
  }
}
