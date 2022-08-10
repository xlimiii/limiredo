import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:limiredo/pages/question_page.dart';
import 'package:limiredo/utils/app_colors.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widthOfScreen = MediaQuery.of(context).size.width;
    var heighOfScreen = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).viewPadding;
    double realHeight = heighOfScreen - padding.top - kToolbarHeight;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        //  backgroundColor: Colors.white,
        backgroundColor: AppColors.myPrimaryColor,
        foregroundColor: AppColors.myBlackColor,
        toolbarHeight: 50,
        centerTitle: true,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'lib/asset/image/135077.png',
                  width: 40,
                  height: 40,
                ),
              ),
              Text(
                "Limiredo",
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont('Asap', fontSize: 35),
              )
            ]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              width: double.infinity,
              child: Text(
                "Train your ears to be better musician!",
                textAlign: TextAlign.left,
                style: GoogleFonts.novaRound(
                    textStyle:
                        const TextStyle(color: Colors.black, fontSize: 30)),
              ),
            ),
            Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: Image.asset(
                  'lib/asset/image/train.png',
                  width: 5 * widthOfScreen / 6,
                )),
            Container(
                alignment: Alignment.topCenter,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuestionPage()),
                      );
                    },
                    child: const Text('Start workout!'),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                        primary: AppColors.myPrimaryColor,
                        onPrimary: AppColors.myBlackColor,
                        textStyle: const TextStyle(fontSize: 30)))),
          ],
        ),
      ),
    );
  }
}
