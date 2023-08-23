import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../../store/store.dart';
import '../../../store/colors.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';

class ShowResult extends StatefulWidget {
  final int index;
  final int termIndex;
  const ShowResult({Key key, this.index, this.termIndex}) : super(key: key);

  @override
  State<ShowResult> createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {
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
    // final ByteData byte = await rootBundle.load('assets/stamp.jpg');
    // final Uint8List list = byte.buffer.asUint8List();

    final ByteData byte1 = await rootBundle.load('assets/logo.png');
    final Uint8List list1 = byte1.buffer.asUint8List();

    for (int i = 0;
        i <
            MainStore
                .classes[widget.index].terms[widget.termIndex].students.length;
        i++) {
      doc.addPage(
        pw.Page(
          build: (context) {
            return pw.Padding(
              padding: const pw.EdgeInsets.only(
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
                                  "TERMLY CONTINOUS ASSESSMENT DOSSIER FOR PRIMARY SCHOOL",
                                  style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.bold,
                                  )),
                            ])
                      ]),
                  pw.SizedBox(height: 10),
                  pw.Text(
                      'NAME: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].name.toUpperCase()}'),
                  pw.SizedBox(height: 2),
                  pw.Text(
                      "CONTINOUS ASSESSMENT FOR: ${MainStore.classes[widget.index].terms[widget.termIndex].termName.toUpperCase()}"),
                  pw.SizedBox(height: 4),
                  pw.Row(children: [pw.Text('1. ATTENDANCE')]),
                  pw.Row(children: [
                    pw.Column(children: [
                      pw.Row(children: [
                        pw.Container(
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            height: 10,
                            width: 120,
                            child: pw.Center(
                              child: pw.Text('FREQUENCIES',
                                  style: pw.TextStyle(
                                    fontSize: 8,
                                    fontWeight: pw.FontWeight.bold,
                                  )),
                            )),
                        pw.Container(
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            height: 10,
                            width: 100,
                            child: pw.Center(
                              child: pw.Text('SCHOOL ATTENDANCE',
                                  style: pw.TextStyle(
                                    fontSize: 8,
                                    fontWeight: pw.FontWeight.bold,
                                  )),
                            )),
                      ]),
                      pw.Row(children: [
                        pw.Container(
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            height: 10,
                            width: 120,
                            child: pw.Center(
                              child: pw.Text('No. of times School opened',
                                  style: pw.TextStyle(
                                    fontSize: 8,
                                    fontWeight: pw.FontWeight.bold,
                                  )),
                            )),
                        pw.Container(
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          height: 10,
                          width: 100,
                        ),
                      ]),
                      pw.Row(children: [
                        pw.Container(
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            height: 10,
                            width: 120,
                            child: pw.Center(
                              child: pw.Text('No. of times present',
                                  style: pw.TextStyle(
                                    fontSize: 8,
                                    fontWeight: pw.FontWeight.bold,
                                  )),
                            )),
                        pw.Container(
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          height: 10,
                          width: 100,
                        ),
                      ]),
                      pw.Row(children: [
                        pw.Container(
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            height: 10,
                            width: 120,
                            child: pw.Center(
                              child: pw.Text('No. of times punctual',
                                  style: pw.TextStyle(
                                    fontSize: 8,
                                    fontWeight: pw.FontWeight.bold,
                                  )),
                            )),
                        pw.Container(
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          height: 10,
                          width: 100,
                        ),
                      ]),
                    ]),
                    pw.Expanded(child: pw.Container()),
                    pw.Column(children: [
                      pw.Text(
                          'TOTAL SCORE: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].total}',
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold)),
                      pw.Text(
                          'Next Term Begins: ${MainStore.classes[widget.index].date}')
                    ])
                  ]),

                  // Results ...
                  pw.SizedBox(height: 2),
                  pw.Row(children: [pw.Text('2. COGNITIVE ABILITY')]),
                  pw.SizedBox(height: 2),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(children: [
                          pw.Container(
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            height: 30,
                            width: 120,
                            child: pw.Center(
                                child: pw.Text("SUBJECTS",
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    ))),
                          ),
                          pw.Column(children: [
                            pw.Row(children: [
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 15,
                                  width: 40,
                                  child: pw.Center(
                                    child: pw.Text('1ST CA',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 15,
                                  width: 40,
                                  child: pw.Center(
                                    child: pw.Text('2ND C.A',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 15,
                                  width: 40,
                                  child: pw.Center(
                                    child: pw.Text('EXAM',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                            ]),
                            pw.Row(children: [
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 15,
                                  width: 40,
                                  child: pw.Center(
                                    child: pw.Text('20%',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 15,
                                  width: 40,
                                  child: pw.Center(
                                    child: pw.Text('20%',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 15,
                                  width: 40,
                                  child: pw.Center(
                                    child: pw.Text('60%',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                            ]),
                          ]),
                          pw.Column(children: [
                            pw.Row(children: [
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 15,
                                  width: 40,
                                  child: pw.Center(
                                    child: pw.Text('TOTAL',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 15,
                                  width: 45,
                                  child: pw.Center(
                                    child: pw.Text('POSITION',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 15,
                                  width: 40,
                                  child: pw.Center(
                                    child: pw.Text('GRADE',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                            ]),
                            pw.Row(children: [
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 15,
                                width: 40,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 15,
                                width: 45,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 15,
                                width: 40,
                              ),
                            ]),
                          ]),
                          pw.Container(
                              padding: const pw.EdgeInsets.only(left: 2),
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              height: 30,
                              width: 50,
                              child: pw.Center(
                                child: pw.Text('CLASS AVERAGE MARK',
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      fontWeight: pw.FontWeight.bold,
                                    )),
                              )),
                          pw.Container(
                              padding: const pw.EdgeInsets.only(left: 2),
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              height: 30,
                              width: 50,
                              child: pw.Center(
                                child: pw.Text("TEACHER'S REMARK",
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      fontWeight: pw.FontWeight.bold,
                                    )),
                              )),
                        ]),
                        pw.Column(
                          children: _listWidgets(i),
                        ),
                        pw.SizedBox(height: 5),

                        // Psychomotor skills ...
                        pw.Row(children: [
                          pw.Column(children: [
                            pw.Row(children: [
                              pw.Container(
                                  // decoration:
                                  //     pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 100,
                                  child: pw.Center(
                                    child: pw.Text('3. PSYCHOMOTOR SKILLS',
                                        style: pw.TextStyle(
                                          fontSize: 7,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 20,
                                  child: pw.Center(
                                    child: pw.Text('5',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 20,
                                  child: pw.Center(
                                    child: pw.Text('4',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 20,
                                  child: pw.Center(
                                    child: pw.Text('3',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 20,
                                  child: pw.Center(
                                    child: pw.Text('2',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 20,
                                  child: pw.Center(
                                    child: pw.Text('1',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                            ]),
                            pw.Row(children: [
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 100,
                                  child: pw.Center(
                                    child: pw.Text('Hand Writing',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                            ]),
                            pw.Row(children: [
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 100,
                                  child: pw.Center(
                                    child: pw.Text('Sports',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                            ]),
                            pw.Row(children: [
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 100,
                                  child: pw.Center(
                                    child: pw.Text('Handling Tools',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                            ]),
                            pw.Row(children: [
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 100,
                                  child: pw.Center(
                                    child: pw.Text('Drawing and Painting',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                            ]),
                            pw.Row(children: [
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 100,
                                  child: pw.Center(
                                    child: pw.Text('Musical Skills',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                            ]),
                            pw.Row(children: [
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 100,
                                  child: pw.Center(
                                    child: pw.Text('Hand Writing',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                            ]),
                            pw.SizedBox(height: 5),
                            pw.Text(
                                'SCALE: 5 - Excellent, 4 - Good\n     3 - Fair, 2 - Poor, 1 - V. Poor',
                                style: pw.TextStyle(
                                  fontSize: 8,
                                  fontWeight: pw.FontWeight.bold,
                                )),
                            pw.SizedBox(height: 5),
                            pw.Text('Passed /Failed: __________',
                                style: pw.TextStyle(
                                  fontSize: 8,
                                  fontWeight: pw.FontWeight.bold,
                                )),
                          ]),
                          pw.Expanded(child: pw.Container()),
                          pw.Column(children: [
                            pw.Row(children: [
                              pw.Container(
                                height: 10,
                                width: 100,
                              ),
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 20,
                                  child: pw.Center(
                                    child: pw.Text('5',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 20,
                                  child: pw.Center(
                                    child: pw.Text('4',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 20,
                                  child: pw.Center(
                                    child: pw.Text('3',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 20,
                                  child: pw.Center(
                                    child: pw.Text('2',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 20,
                                  child: pw.Center(
                                    child: pw.Text('1',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                            ]),
                            pw.Row(children: [
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 100,
                                  child: pw.Center(
                                    child: pw.Text('Punctuality',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                            ]),
                            pw.Row(children: [
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 100,
                                  child: pw.Center(
                                    child: pw.Text('Neatness',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                            ]),
                            pw.Row(children: [
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 100,
                                  child: pw.Center(
                                    child: pw.Text('Politeness',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                            ]),
                            pw.Row(children: [
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 100,
                                  child: pw.Center(
                                    child: pw.Text('Honesty',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                            ]),
                            pw.Row(children: [
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 100,
                                  child: pw.Center(
                                    child: pw.Text('Cooperation with others',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                            ]),
                            pw.Row(children: [
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 100,
                                  child: pw.Center(
                                    child: pw.Text('Leadership',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                            ]),
                            pw.Row(children: [
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 100,
                                  child: pw.Center(
                                    child: pw.Text('Helping Others',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                            ]),
                            pw.Row(children: [
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 100,
                                  child: pw.Center(
                                    child: pw.Text('Emotional Stability',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                            ]),
                            pw.Row(children: [
                              pw.Container(
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  height: 10,
                                  width: 100,
                                  child: pw.Center(
                                    child: pw.Text('Health',
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          fontWeight: pw.FontWeight.bold,
                                        )),
                                  )),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                              pw.Container(
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                height: 10,
                                width: 20,
                              ),
                            ]),
                          ]),
                        ]),

                        pw.SizedBox(height: 8),
                        pw.Row(children: [
                          pw.Text(
                              'NUMBER OF PUPILS IN CLASS: ${MainStore.classes[widget.index].terms[widget.termIndex].students.length}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'POSITION IN CLASS: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].position}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 5),
                        pw.Row(children: [
                          pw.Text(
                              "CLASS TEACHER'S COMMENT:  ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].ftRem}   ",
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text('SIGNATURE:           ',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 5),
                        pw.Row(children: [
                          pw.Text(
                              "HEADMASTER / HEADMISTRESS COMMENT: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].remark}",
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text('SIGN / STAMP:              ',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 5),
                        pw.Text(
                            'FEES FOR NEXT TERM: NGN ${MainStore.classes[widget.index].fees}   ',
                            style: pw.TextStyle(
                              fontSize: 8,
                              fontWeight: pw.FontWeight.bold,
                            )),
                      ]),
                  pw.SizedBox(height: 5),
                  pw.Text(
                      'KEY TO GRADING: Final Assessment(A = Distinction, B = V. Good, C = Good, D = Fair, E = Poor',
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: pw.FontWeight.bold,
                      )),
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
        i <
            MainStore
                .classes[widget.index].terms[widget.termIndex].subjects.length;
        i++) {
      temp.add(_sujectRow(i, stdIndex));
    }
    return temp;
  }

  _sujectRow(int sub, int stdIndex) {
    return pw.Row(children: [
      // Subject name ...
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 15,
        width: 120,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].terms[widget.termIndex]
                    .students[stdIndex].subjects[sub].name,
                style: pw.TextStyle(
                  fontSize: 8.5,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // 1st CA ...
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 15,
        width: 40,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].terms[widget.termIndex]
                    .students[stdIndex].subjects[sub].ass[0]
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // 2nd CA ...
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 15,
        width: 40,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].terms[widget.termIndex]
                    .students[stdIndex].subjects[sub].ass[1]
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Exam ...
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 15,
        width: 40,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].terms[widget.termIndex]
                    .students[stdIndex].subjects[sub].ass[2]
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Total ...
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 15,
        width: 40,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].terms[widget.termIndex]
                    .students[stdIndex].subjects[sub].total
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Position ...
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 15,
        width: 45,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].terms[widget.termIndex]
                    .students[stdIndex].subjects[sub].pos
                    .toString(),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Grade ...
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 15,
        width: 40,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].terms[widget.termIndex]
                    .students[stdIndex].subjects[sub].grade,
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Class Average Mark ...
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 15,
        width: 50,
        child: pw.Center(
            child: pw.Text(
                MainStore.classes[widget.index].terms[widget.termIndex]
                    .students[stdIndex].subjects[sub].average
                    .toStringAsFixed(2),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
      // Teacher's Remark ...
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: 15,
        width: 50,
        child: pw.Center(
            child: pw.Text(
                remarkHelper(MainStore
                    .classes[widget.index]
                    .terms[widget.termIndex]
                    .students[stdIndex]
                    .subjects[sub]
                    .total),
                style: pw.TextStyle(
                  fontSize: 8,
                  fontWeight: pw.FontWeight.bold,
                ))),
      ),
    ]);
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
