import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'change_format.dart';

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
    if (userInput.text.isEmpty) {
      userInput.text = '1642811640';
    }
    return DateFormat(formatTimeString)
        .format(DateTime.fromMillisecondsSinceEpoch(int.parse(userInput.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Center(
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
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .9,
                      padding: const EdgeInsets.all(12.0),
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Theme.of(context).hoverColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: FittedBox(
                        child: Text(
                          epochCnv,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
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
                const SizedBox(
                  height: 20,
                ),
                ChangeFormat(
                  timeStamp: userInput.text,
                  changeTimePattern: changeTimeFormat,
                  nowTimePattern: formatTimeString,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
