import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Epoch Readable',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Epoch Readable'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController userInput = TextEditingController();
  String formatTimeString = 'yyyy-MM-dd – kk:mm:ss';

  void changeTimeFormat(String pattern) {
    if (pattern.isNotEmpty) {
      setState(() {
        formatTimeString = pattern;
      });
    }
  }

  String get epochCnv {
    userInput.text = userInput.text.isEmpty ? '1642811640' : userInput.text;
    return DateFormat(formatTimeString)
        .format(DateTime.fromMillisecondsSinceEpoch(int.parse(userInput.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: userInput,
                onChanged: (value) => setState(() {
                  epochCnv;
                }),
                decoration: const InputDecoration(
                    label: Text("Enter Epoch Timestamp"),
                    border: OutlineInputBorder()),
              ),
            ),
            const Text(
              'Human Readable Form',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  epochCnv,
                  style: Theme.of(context).textTheme.headline4,
                ),

                // IconButton(
                //     onPressed: () {
                //       showModalBottomSheet(
                //           context: context,
                //           builder: (txt) {
                //             return ChangeFormat(
                //               timeStamp: userInput.text,
                //               changeTimePattern: changeTimeFormat,
                //               nowTimePattern: formatTimeString,
                //             );
                //           });
                //     },
                //     icon: Icon(Icons.edit),)
              ],
            ),
            ChangeFormat(
              timeStamp: userInput.text,
              changeTimePattern: changeTimeFormat,
              nowTimePattern: formatTimeString,
            ),
          ],
        ),
      ),
    );
  }
}

class ChangeFormat extends StatelessWidget {
  TextEditingController timeStringContoler = TextEditingController();
  Function changeTimePattern;
  final String nowTimePattern;
  final String timeStamp;
  ChangeFormat({
    required this.changeTimePattern,
    required this.nowTimePattern,
    required this.timeStamp,
    Key? key,
  }) : super(key: key);

  List<String> timePattern = [
    "yMd",
    "yMEd",
    "yMMMd",
    "yMMMEd",
    "yMMMMd",
    "yMMMMEEEEd",
    "EEE, MMM d, ''yy",
    "EEE, MMM d, ''yy",
    "yyyy-MM-dd – kk:mm:ss",
    "yyyy-MM-dd",
    "yyyy.MM.dd G 'at' HH:mm:ss",
  ];

  void changePNow([String? e]) {
    changeTimePattern(e ?? timeStringContoler.text);
  }

  @override
  Widget build(BuildContext context) {
    timeStringContoler.text = timeStringContoler.text.isEmpty
        ? nowTimePattern
        : timeStringContoler.text;
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Column(
        children: [
          Text(
            "Change Format",
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            onChanged: (_) {
              changePNow();
            },
            onSubmitted: (_) {
              changePNow();
            },
            controller: timeStringContoler,
            decoration: const InputDecoration(
                label: Text("ICU/JDK date/time pattern"),
                border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            children: [
              ...timePattern.map(
                (e) => Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(150, 230, 255, .6))),
                    onPressed: () {
                      changePNow(e);
                    },
                    child: Text(
                      DateFormat(e).format(
                        DateTime.fromMillisecondsSinceEpoch(
                          int.parse(timeStamp),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          // ElevatedButton(
          //     onPressed: changePNow, child: const Text("Change Pattern"))
        ],
      ),
    );
  }
}
