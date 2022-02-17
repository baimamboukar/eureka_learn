import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          LottieBuilder.asset("assets/animations/loading.json"),
          SizedBox(
            height: 25.0,
          ),
          Text("Loading...Please wait", style: Styles.subtitle)
        ],
      ),
    );
  }
}
