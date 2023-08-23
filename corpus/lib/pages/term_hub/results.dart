import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../logic/compile_term_results.dart';
import '../../models/class_model.dart';
import '../../store/colors.dart';
import '../../store/store.dart';
import 'results_inner/master_score_sheet.dart';
import 'results_inner/show_result.dart';

class Results extends StatefulWidget {
  final String className;
  final int classKey;
  final int classIndex;
  final int termIndex;

  const Results(
      {Key key, this.className, this.classKey, this.classIndex, this.termIndex})
      : super(key: key);

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  String date = "";
  String fees = "";
  Box<Class> classBox;

  @override
  void initState() {
    super.initState();
    classBox = Hive.box<Class>("name");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBackground,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 20, left: 15, bottom: 20, right: 5),
                            child: Icon(
                              Icons.arrow_back,
                              color: iconColor,
                              size: 24,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Results",
                          style: TextStyle(
                              color: textColors,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5),
                        ),
                        Expanded(child: Container()),
                        /*  const Icon(
                      Icons.more_vert_rounded,
                      size: 24,
                    ), */
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 0.5,
                  width: double.maxFinite,
                  color: const Color.fromARGB(255, 37, 29, 107),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    if (emptyField(widget.classIndex, widget.termIndex)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Empty fields detected. Please ensure that you fill in every required information before atempting to display results.'),
                        ),
                      );
                    } else {
                      computeResults(widget.classIndex, widget.termIndex);
                      classBox.put(widget.classKey,
                          MainStore.classes[widget.classIndex]);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Master(
                                    index: widget.classIndex,
                                    termIndex: widget.termIndex,
                                  )));
                    }
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.5,
                              spreadRadius: 0.5)
                        ],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: borderColors, width: 0.5),
                        color: Colors.white),
                    child: const Text(
                      "Master Score Sheet",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (emptyField(widget.classIndex, widget.termIndex)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Empty fields detected. Please ensure that you fill in every required information before atempting to display results.'),
                        ),
                      );
                    } else {
                      computeResults(widget.classIndex, widget.termIndex);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowResult(
                                    index: widget.classIndex,
                                    termIndex: widget.termIndex,
                                  )));
                    }
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.5,
                              spreadRadius: 0.5)
                        ],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: borderColors, width: 0.5),
                        color: Colors.white),
                    child: const Text(
                      "Preview Students Results",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Next Term Begins",
                        style: TextStyle(
                          color: textColors,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    if (MainStore.classes.isNotEmpty) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(43, 173, 172, 172),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: borderColors)),
                                child: TextFormField(
                                  onChanged: ((value) {
                                    date = value;
                                  }),
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration.collapsed(
                                      hintText: "Enter next term start date"),
                                  initialValue: MainStore
                                              .classes[widget.classIndex]
                                              .date ==
                                          ''
                                      ? ""
                                      : MainStore
                                          .classes[widget.classIndex].date,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'CANCEL',
                                    style: TextStyle(color: popTextColors),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      MainStore.classes[widget.classIndex]
                                          .date = date;
                                      classBox.put(widget.classKey,
                                          MainStore.classes[widget.classIndex]);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'SAVE',
                                    style: TextStyle(color: popTextColors),
                                  ),
                                ),
                              ],
                            );
                          });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "You need to create atleast one Class before you can save the next term start date"),
                      ));
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 0.5,
                              spreadRadius: 0.3)
                        ],
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: borderColors, width: 0.3),
                        color: Colors.white),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              MainStore.classes[widget.classIndex].date == ''
                                  ? "No date set yet"
                                  : MainStore.classes[widget.classIndex].date,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.0),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "Tap to change",
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.8),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        InkWell(
                          onTap: () {
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(color: borderColors),
                                color: borderColors,
                                borderRadius: BorderRadius.circular(20)),
                            child: Icon(
                              Icons.refresh_rounded,
                              color: iconColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Next Term Fees",
                        style: TextStyle(
                          color: textColors,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    if (MainStore.classes.isNotEmpty) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(43, 173, 172, 172),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: borderColors)),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  onChanged: ((value) {
                                    fees = value;
                                  }),
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration.collapsed(
                                      hintText: "Enter next term fees"),
                                  initialValue: MainStore
                                              .classes[widget.classIndex]
                                              .fees ==
                                          ''
                                      ? ""
                                      : MainStore
                                          .classes[widget.classIndex].fees,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'CANCEL',
                                    style: TextStyle(color: popTextColors),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      MainStore.classes[widget.classIndex]
                                          .fees = fees;
                                      classBox.put(widget.classKey,
                                          MainStore.classes[widget.classIndex]);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'SAVE',
                                    style: TextStyle(color: popTextColors),
                                  ),
                                ),
                              ],
                            );
                          });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "You need to create atleast one Class before you can save the next term fees"),
                      ));
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 0.5,
                              spreadRadius: 0.3)
                        ],
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: borderColors, width: 0.3),
                        color: Colors.white),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              MainStore.classes[widget.classIndex].fees == ''
                                  ? "No fees set yet"
                                  : MainStore.classes[widget.classIndex].fees,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.0),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "Tap to change",
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.8),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        InkWell(
                          onTap: () {
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(color: borderColors),
                                color: borderColors,
                                borderRadius: BorderRadius.circular(20)),
                            child: Icon(
                              Icons.refresh_rounded,
                              color: iconColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
