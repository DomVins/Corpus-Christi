import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../store/colors.dart';
import '../../../store/store.dart';

class Annual extends StatefulWidget {
  final int index;
  const Annual({Key key, this.index}) : super(key: key);

  @override
  State<Annual> createState() => _AnnualState();
}

class _AnnualState extends State<Annual> {
  final String dash =
      '.....................................................................................................';
  final String dash1 =
      '.........................................................................................';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        title: const Text('Results PDF Preview'),
      ),
      body: FutureBuilder<Uint8List>(
        future: generateDocument(),
        builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
          if (snapshot.hasData) {
            return PdfPreview(
              dynamicLayout: false,
              canChangePageFormat: false,
              canDebug: false,
              maxPageWidth: 700,
              build: (format) => snapshot.data,
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Future<Uint8List> generateDocument() async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);

    final ByteData byte1 = await rootBundle.load('assets/logo.png');
    final Uint8List list1 = byte1.buffer.asUint8List();

    for (int i = 0;
        i < MainStore.classes[widget.index].studentsAnnual.length;
        i++) {
      doc.addPage(
        pw.Page(
          build: (context) {
            return pw.Padding(
              padding: const pw.EdgeInsets.only(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.center,
                            children: [
                              pw.SizedBox(
                                height: 60,
                                width: 60,
                                child: pw.Image(pw.MemoryImage(list1)),
                              ),
                              pw.SizedBox(height: 0.5),
                              pw.Text('CATHOLIC DIOCESE OF OTUKPO',
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                      fontStyle: pw.FontStyle.italic)),
                              pw.Text('CORPUS CHRISTI',
                                  style: pw.TextStyle(
                                      fontSize: 16,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text(
                                  "NURSERY AND PRIMARY SCHOOL, ANWULE-OGLEWU",
                                  style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.bold,
                                  )),
                              pw.Text(
                                  "ANNUAL CONTINOUS ASSESSMENT DOSSIER FOR PRIMARY SCHOOL",
                                  style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.bold,
                                  )),
                            ])
                      ]),
                  pw.SizedBox(height: 4),
                  pw.Text(
                      'Name of Pupil: ${MainStore.classes[widget.index].studentsAnnual[i].name}',
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                      )),
                  pw.SizedBox(height: 4),
                  pw.Row(children: [
                    pw.Text('Year: ${MainStore.classes[widget.index].session}',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        )),
                    pw.Expanded(child: pw.Container()),
                    pw.Text('Sex:...........',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        )),
                  ]),
                  pw.Row(children: [
                    pw.Text('L.G.A:$dash',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        )),
                    pw.Expanded(child: pw.Container()),
                    pw.Text('Age:...........',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        )),
                  ]),
                  pw.Row(children: [
                    pw.Text(
                        'Class: ${MainStore.classes[widget.index].className}',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        )),
                    pw.Expanded(child: pw.Container()),
                    pw.Text('Admission No.:..................................',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        )),
                    pw.Expanded(child: pw.Container()),
                    pw.Text(
                        'No. in Class: ${MainStore.classes[widget.index].terms[2].students.length}',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        )),
                  ]),
                  pw.SizedBox(height: 4),
                  pw.Row(children: [
                    pw.Text("Attendance: ",
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        )),
                    pw.Expanded(child: pw.Container()),
                    pw.Text("Days out of: ",
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        )),
                    pw.Expanded(child: pw.Container()),
                    pw.Text("))):...............",
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        )),
                  ]),
                  pw.SizedBox(height: 4),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(children: [
                          pw.Container(
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            height: 45,
                            width: 140,
                            child: pw.Center(
                                child: pw.Text("SUBJECTS",
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    ))),
                          ),
                          pw.Container(
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              height: 45,
                              width: 35,
                              child: pw.Transform.rotate(
                                angle: pi / 2,
                                child: pw.Center(
                                    child: pw.Text('TERM 1\nTOTAL',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        ))),
                              )),
                          pw.Container(
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              height: 45,
                              width: 35,
                              child: pw.Transform.rotate(
                                angle: pi / 2,
                                child: pw.Center(
                                    child: pw.Text('TERM 2\nTOTAL',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        ))),
                              )),
                          pw.Container(
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              height: 45,
                              width: 35,
                              child: pw.Transform.rotate(
                                angle: pi / 2,
                                child: pw.Center(
                                    child: pw.Text('TERM 3\nTOTAL',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        ))),
                              )),
                          pw.Container(
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              height: 45,
                              width: 35,
                              child: pw.Transform.rotate(
                                angle: pi / 2,
                                child: pw.Center(
                                    child: pw.Text('YEARLY\nTOTAL',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        ))),
                              )),
                          pw.Container(
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              height: 45,
                              width: 35,
                              child: pw.Transform.rotate(
                                angle: pi / 2,
                                child: pw.Center(
                                    child: pw.Text('CLASS\nAVERAGE',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        ))),
                              )),
                          pw.Container(
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              height: 45,
                              width: 35,
                              child: pw.Transform.rotate(
                                angle: pi / 2,
                                child: pw.Center(
                                    child: pw.Text('HIGHEST\nIN CLASS',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        ))),
                              )),
                          pw.Container(
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              height: 45,
                              width: 35,
                              child: pw.Transform.rotate(
                                angle: pi / 2,
                                child: pw.Center(
                                    child: pw.Text('LOWEST\nIN CLASS',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        ))),
                              )),
                          pw.Container(
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              height: 45,
                              width: 35,
                              child: pw.Transform.rotate(
                                angle: pi / 2,
                                child: pw.Center(
                                    child: pw.Text('POSITION\nIN CLASS',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        ))),
                              )),
                          pw.Container(
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              height: 45,
                              width: 35,
                              child: pw.Transform.rotate(
                                angle: pi / 2,
                                child: pw.Center(
                                    child: pw.Text('GRADE',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        ))),
                              )),
                          pw.Container(
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            height: 45,
                            width: 50,
                            child: pw.Center(
                                child: pw.Text('REMARK\n& SIGNATURE',
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      fontWeight: pw.FontWeight.bold,
                                    ))),
                          )
                        ]),
                        pw.Column(
                          children: _listWidgets(i),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Row(children: [
                          pw.Text(
                              'No. of subjects: ${MainStore.classes[widget.index].studentsAnnual[i].subjects.length}',
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'Total obtainable marks: ${(MainStore.classes[widget.index].studentsAnnual[i].subjects.length * 300).toString()}',
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'Marks obtained: ${MainStore.classes[widget.index].studentsAnnual[i].overAllTotal}',
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 8),
                        pw.Row(children: [
                          pw.Text(
                              'Average: ${MainStore.classes[widget.index].studentsAnnual[i].overAllAverage.toStringAsFixed(2)}',
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'Position in Class: ${MainStore.classes[widget.index].studentsAnnual[i].overAllPosition}',
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'Out of: ${MainStore.classes[widget.index].studentsAnnual.length}     PASSED / FAILED',
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 5),
                        pw.Text("Class Teacher's Remark:$dash",
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                            )),
                        pw.SizedBox(height: 4),
                        pw.Row(children: [
                          pw.Text("Name: ",
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text("Signature: ",
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text("Date:           ",
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 4),
                        pw.Text("House Master's Remark:$dash",
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                            )),
                        pw.SizedBox(height: 4),
                        pw.Row(children: [
                          pw.Text("Name: ",
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text("Signature: ",
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text("Date:           ",
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 4),
                        pw.Text("Guidance councellor's Remark:$dash1",
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                            )),
                        pw.SizedBox(height: 4),
                        pw.Row(children: [
                          pw.Text("Name: ",
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text("Signature: ",
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text("Date:           ",
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 4),
                        pw.Text("Head Teacher's Remark:$dash",
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                            )),
                        pw.SizedBox(height: 4),
                        pw.Row(children: [
                          pw.Text("Name:                                   ",
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text("Signature: ",
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text("Stamp: ",
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text("Date:           ",
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 4),
                        pw.Text(
                            'KEY TO GRADING: Final Assessment(A = Distinction, B = V. Good, C = Good, D = Fair, E = Poor',
                            style: pw.TextStyle(
                              fontSize: 8,
                              fontWeight: pw.FontWeight.bold,
                            )),
                      ])
                ],
              ),
            );
          },
        ),
      );
      clearCache();
    }

    return await doc.save();
  }

  Future<void> clearCache() async {
    final directory = await getTemporaryDirectory();
    final files = directory.listSync();
    for (FileSystemEntity file in files) {
      if (file is File) await file.delete();
    }
  }

  _listWidgets(int stdIndex) {
    List<pw.Widget> temp = [];
    for (int i = 0;
        i < MainStore.classes[widget.index].terms[0].subjects.length;
        i++) {
      temp.add(_sujectRow(i, stdIndex));
    }
    return temp;
  }

  _sujectRow(int sub, int stdIndex) {
    return pw.Row(children: [
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 140,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].studentsAnnual[stdIndex]
                    .subjects[sub].name,
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Term 1 total ...
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 35,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].studentsAnnual[stdIndex]
                    .subjects[sub].termTotal[0]
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      //Term 2 total ...
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 35,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].studentsAnnual[stdIndex]
                    .subjects[sub].termTotal[1]
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Term 3 total ...
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 35,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].studentsAnnual[stdIndex]
                    .subjects[sub].termTotal[2]
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Yearly total ...
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 35,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].studentsAnnual[stdIndex]
                    .subjects[sub].yearTotal
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Class Average ...
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 35,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].studentsAnnual[stdIndex]
                    .subjects[sub].average
                    .toStringAsFixed(2),
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Highest in class ...
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 35,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].studentsAnnual[stdIndex]
                    .subjects[sub].higestInClass
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Lowest in class ...
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 35,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].studentsAnnual[stdIndex]
                    .subjects[sub].loswetInClass
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Position in class ...
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 35,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].studentsAnnual[stdIndex]
                    .subjects[sub].position
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Grade ...
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 35,
        child: pw.Center(
            child: pw.Text(
                gradeHelper(MainStore.classes[widget.index]
                    .studentsAnnual[stdIndex].subjects[sub].average),
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Remark ...
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 16,
        width: 50,
        child: pw.Center(
            child: pw.Text(
                remarkHelper(MainStore.classes[widget.index]
                    .studentsAnnual[stdIndex].subjects[sub].average),
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
    ]);
  }
}

String gradeHelper(score) {
  if (score <= 100 && score >= 80) {
    return "A";
  } else {
    if (score < 80 && score >= 70) {
      return "B";
    } else {
      if (score < 70 && score >= 60) {
        return "C";
      } else {
        if (score < 60 && score >= 50) {
          return "D";
        } else {
          if (score < 50 && score >= 40) {
            return "E";
          } else if (score < 40 && score >= 0) {
            return "F";
          } else {
            return "Null";
          }
        }
      }
    }
  }
}

String remarkHelper(score) {
  if (score <= 100 && score >= 80) {
    return "Distinction";
  } else {
    if (score < 80 && score >= 70) {
      return "Very Good";
    } else {
      if (score < 70 && score >= 60) {
        return "Good";
      } else {
        if (score < 60 && score >= 50) {
          return "Fair";
        } else {
          if (score < 50 && score >= 40) {
            return "Poor";
          } else if (score < 40 && score >= 0) {
            return "Poor";
          } else {
            return "Null";
          }
        }
      }
    }
  }
}
