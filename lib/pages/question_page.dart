import 'package:limiredo/datasources/limiredo_api.dart';
import 'package:limiredo/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final player = AudioPlayer();
  String nameOfFile = "";
  String choice = "?";
  Color colorOfCard = Colors.transparent;
  Response? pairOfSounds;

  var intervals = {
    0: "1",
    1: "2>",
    2: "2",
    3: "3>",
    4: "3",
    5: "4",
    6: "4<",
    7: "5",
    8: "6>",
    9: "6",
    10: "7",
    11: "7<",
    12: "8"
  };

  Future<void> generateInterval() async {
    pairOfSounds = await LimiredoApi().getInterval();
    var headers = pairOfSounds!.headers;
    var indexOfFilename = headers["content-disposition"]!.indexOf("filename=");
    nameOfFile = headers["content-disposition"]![indexOfFilename + 9];
    player.playBytes(pairOfSounds!.bodyBytes);
  }

  bool checkAnswer(int buttonValue) {
    if (buttonValue.toString() == nameOfFile) {
      return true;
    } else {
      return false;
    }
  }

  void answerIsCorrectOperation(int buttonValue) {
    setState(() {
      choice = intervals[buttonValue] == null ? "?" : intervals[buttonValue]!;
      colorOfCard = Colors.green;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        choice = "?";
        colorOfCard = Colors.transparent;
      });
    });
    generateInterval();
  }

  void answerIsNotCorrectOperation() {
    if (pairOfSounds != null) player.playBytes(pairOfSounds!.bodyBytes);
  }

  @override
  void initState() {
    generateInterval();
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
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
              width: double.infinity,
              child: Text(
                "What interval do you hear?",
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont('Asap', fontSize: 25),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: colorOfCard, width: 5),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  choice,
                  style: const TextStyle(fontSize: 70),
                ),
                width: widthOfScreen / 2,
                height: widthOfScreen / 2,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: widthOfScreen,
                height: realHeight / 2,
                alignment: Alignment.center,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: intervals.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: ElevatedButton(
                        onPressed: () => {
                          if (checkAnswer(index) == true)
                            {answerIsCorrectOperation(index)}
                          else
                            {answerIsNotCorrectOperation()}
                        },
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.myGrayColor),
                        child: Center(
                            child: Text(
                                intervals[index] != null
                                    ? intervals[index]!
                                    : "?",
                                style: GoogleFonts.novaRound(fontSize: 30))),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
