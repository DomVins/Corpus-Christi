
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../logic/compile_annual_results.dart';
import '../models/class_model.dart';
import '../store/colors.dart';
import '../store/store.dart';
import 'class_terms_inner/annual.dart';
import 'class_terms_inner/term_hub.dart';

class Term extends StatefulWidget {
  final String className;
  final int classKey;
  final int index;

  const Term({Key key, this.className, this.classKey, this.index})
      : super(key: key);

  @override
  State<Term> createState() => _TermState();
}

class _TermState extends State<Term> {
  String ftName = "";
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
      body: Column(
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
                    widget.className,
                    style: TextStyle(
                        color: textColors,
                        fontSize: 20,
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
          Expanded(
              child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Form Teacher's Name",
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
                                  ftName = value;
                                }),
                                cursorColor: Colors.black,
                                decoration: const InputDecoration.collapsed(
                                    hintText: "Enter Form Teacher's Name"),
                                initialValue:
                                    MainStore.classes[widget.index].ftName == ''
                                        ? ""
                                        : MainStore
                                            .classes[widget.index].ftName,
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
                                    MainStore.classes[widget.index].ftName =
                                        ftName;
                                    classBox.put(widget.classKey,
                                        MainStore.classes[widget.index]);
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
                          "You need to create atleast one Class before you can save the Head teacher's name."),
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
                            MainStore.classes[widget.index].ftName == ''
                                ? "No name yet"
                                : MainStore.classes[widget.index].ftName,
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
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 20, bottom: 10),
                    child: Text(
                      "Terms",
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClassPage(
                              name: widget.className,
                              classKey: widget.classKey,
                              classIndex: widget.index,
                              termName: "First Term",
                              termIndex: 0)));
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
                            spreadRadius: 0.5)
                      ],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: borderColors, width: 0.5),
                      color: Colors.white),
                  child: const Text(
                    "First Term",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClassPage(
                              name: widget.className,
                              classKey: widget.classKey,
                              classIndex: widget.index,
                              termName: "Second Term",
                              termIndex: 1)));
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
                            spreadRadius: 0.5)
                      ],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: borderColors, width: 0.5),
                      color: Colors.white),
                  child: const Text(
                    "Second Term",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClassPage(
                              name: widget.className,
                              classKey: widget.classKey,
                              classIndex: widget.index,
                              termName: "Third Term",
                              termIndex: 2)));
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
                            spreadRadius: 0.5)
                      ],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: borderColors, width: 0.5),
                      color: Colors.white),
                  child: const Text(
                    "Third Term",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (!checkNames(widget.index)) {
                    if (emptyField(widget.index)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Empty fields detected in one of the term's assessments. Please ensure that you fill in every required information before atempting to display results."),
                        ),
                      );
                    } else {
                      if (MainStore.annualCompiled == false) {
                        computeAnnualResults(widget.index);
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnnualPage(
                                    classIndex: widget.index,
                                  )));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "All terms must contain exactly the same students before annual results can be compiled. Please read the user manual of the app for more information ")));
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
                          spreadRadius: 0.5)
                    ],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: borderColors, width: 0.5),
                    color: Colors.white,
                  ),
                  child: const Text(
                    "Annual Results",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2),
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

 
}
