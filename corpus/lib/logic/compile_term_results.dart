import '../models/student_model.dart';
import '../store/store.dart';

computeResults(int classIndex, int termIndex) {
    // Subjects total score . . .
    _subjectTotal(classIndex, termIndex);

    // Term total score . . .
    _termTotal(classIndex, termIndex);

    // Subject position . . .
    _subjectPosition(classIndex, termIndex);

    // Term position . . .
    _termPosition(classIndex, termIndex);

    // Term average . . .
    _termAverage(classIndex, termIndex);

    // Subject average . . .
    _subjectAverage(classIndex, termIndex);

    // Subject grade . . .
    _subjectGrade(classIndex, termIndex);

    // Highest in class . . .
    _highest(classIndex, termIndex);

    // Lowest in class . . .
    _lowest(classIndex, termIndex);

    // Term Remarks . . .
    _remarks(classIndex, termIndex);
  }

  _remarks(int classIndex, int termIndex) {
    for (int i = 0;
        i <
            MainStore.classes[classIndex].terms[termIndex]
                .students.length;
        i++) {
      if (MainStore.classes[classIndex].terms[termIndex]
                  .students[i].average >
              80 &&
          MainStore.classes[classIndex].terms[termIndex]
                  .students[i].average <=
              100) {
        MainStore.classes[classIndex].terms[termIndex].students[i]
            .remark = "An Outstanding result. Keep it up.";
      } else if (MainStore.classes[classIndex].terms[termIndex]
                  .students[i].average >
              74 &&
          MainStore.classes[classIndex].terms[termIndex]
                  .students[i].average <
              80) {
        MainStore.classes[classIndex].terms[termIndex].students[i]
            .remark = "An Excellent Performance. Keep it up.";
      } else if (MainStore.classes[classIndex].terms[termIndex]
                  .students[i].average >
              64 &&
          MainStore.classes[classIndex].terms[termIndex]
                  .students[i].average <
              75) {
        MainStore.classes[classIndex].terms[termIndex].students[i]
            .remark = "A very Good Result.";
      } else if (MainStore.classes[classIndex].terms[termIndex]
                  .students[i].average >
              49 &&
          MainStore.classes[classIndex].terms[termIndex]
                  .students[i].average <
              65) {
        MainStore.classes[classIndex].terms[termIndex].students[i]
            .remark = "A Good Performance. You can do better.";
      } else if (MainStore.classes[classIndex].terms[termIndex]
                  .students[i].average >
              40 &&
          MainStore.classes[classIndex].terms[termIndex]
                  .students[i].average <
              50) {
        MainStore.classes[classIndex].terms[termIndex].students[i]
            .remark = "A fair performance. Improve next time.";
      } else if (MainStore.classes[classIndex].terms[termIndex]
                  .students[i].average >=
              0 &&
          MainStore.classes[classIndex].terms[termIndex]
                  .students[i].average <=
              40) {
        MainStore.classes[classIndex].terms[termIndex].students[i]
            .remark = "Poor result. Sit up.";
      }
    }
  }

  _highest(int classIndex, int termIndex) {
    for (int i = 0;
        i <
            MainStore.classes[classIndex].terms[termIndex]
                .students.length;
        i++) {
      for (int j = 0;
          j <
              MainStore.classes[classIndex].terms[termIndex]
                  .subjects.length;
          j++) {
        for (int k = 0;
            k <
                MainStore.classes[classIndex].terms[termIndex]
                    .students.length;
            k++) {
          if (MainStore.classes[classIndex].terms[termIndex]
                  .students[k].subjects[j].pos ==
              1) {
            MainStore.classes[classIndex].terms[termIndex]
                    .students[i].subjects[j].highest =
                MainStore.classes[classIndex].terms[termIndex]
                    .students[k].subjects[j].total;
            break;
          }
        }
      }
    }
  }

  _lowest(int classIndex, int termIndex) {
    for (int i = 0;
        i <
            MainStore.classes[classIndex].terms[termIndex]
                .students.length;
        i++) {
      for (int j = 0;
          j <
              MainStore.classes[classIndex].terms[termIndex]
                  .subjects.length;
          j++) {
        for (int k = 0;
            k <
                MainStore.classes[classIndex].terms[termIndex]
                    .students.length;
            k++) {
          if (MainStore.classes[classIndex].terms[termIndex]
                  .students[k].subjects[j].pos ==
              MainStore.classes[classIndex].terms[termIndex]
                  .students.length) {
            MainStore.classes[classIndex].terms[termIndex]
                    .students[i].subjects[j].lowest =
                MainStore.classes[classIndex].terms[termIndex]
                    .students[k].subjects[j].total;
            break;
          }
        }
      }
    }
  }

  _subjectTotal(int classIndex, int termIndex) {
    int total = 0;
    for (int i = 0;
        i <
            MainStore.classes[classIndex].terms[termIndex]
                .students.length;
        i++) {
      for (int j = 0;
          j <
              MainStore.classes[classIndex].terms[termIndex]
                  .subjects.length;
          j++) {
        for (int k = 0; k < 3; k++) {
          total += MainStore.classes[classIndex].terms[termIndex]
              .students[i].subjects[j].ass[k];
        }
        MainStore.classes[classIndex].terms[termIndex].students[i]
            .subjects[j].total = total;
        total = 0;
      }
    }
  }

  _subjectPosition(int classIndex, int termIndex) {
    List<String> sortedNames = [];
    List<SubPosList> namedScores = [];

    for (int b = 0;
        b <
            MainStore.classes[classIndex].terms[termIndex]
                .subjects.length;
        b++) {
      for (int s = 0;
          s <
              MainStore.classes[classIndex].terms[termIndex]
                  .students.length;
          s++) {
        namedScores.add(SubPosList(
            MainStore.classes[classIndex].terms[termIndex]
                .students[s].name,
            MainStore.classes[classIndex].terms[termIndex]
                .students[s].subjects[b].total));
      }
      namedScores.sort(((a, b) => b.subTotal.compareTo(a.subTotal)));

      for (int s = 0;
          s <
              MainStore.classes[classIndex].terms[termIndex]
                  .students.length;
          s++) {
        sortedNames.add(namedScores[s].studentName);
      }

      for (int s = 0;
          s <
              MainStore.classes[classIndex].terms[termIndex]
                  .students.length;
          s++) {
        MainStore.classes[classIndex].terms[termIndex].students[s]
            .subjects[b]
            .setPos(sortedNames.indexOf(MainStore.classes[classIndex]
                    .terms[termIndex].students[s].name) +
                1);
      }
      namedScores.clear();
      sortedNames.clear();
    }
  }

  _termTotal(int classIndex, int termIndex) {
    int total = 0;
    for (int i = 0;
        i <
            MainStore.classes[classIndex].terms[termIndex]
                .students.length;
        i++) {
      for (int j = 0;
          j <
              MainStore.classes[classIndex].terms[termIndex]
                  .subjects.length;
          j++) {
        total += MainStore.classes[classIndex].terms[termIndex]
            .students[i].subjects[j].total;
      }
      MainStore.classes[classIndex].terms[termIndex].students[i]
          .total = total;
      total = 0;
    }
  }

  _termPosition(int classIndex, int termIndex) {
    List<Student> sorted = [];
    sorted.addAll(
        MainStore.classes[classIndex].terms[termIndex].students);

    List<String> sortedNames = [];
    sorted.sort(((a, b) => b.total.compareTo(a.total)));
    for (int i = 0; i < sorted.length; i++) {
      sortedNames.add(sorted[i].name);
    }

    for (int i = 0;
        i <
            MainStore.classes[classIndex].terms[termIndex]
                .students.length;
        i++) {
      MainStore.classes[classIndex].terms[termIndex].students[i]
          .position = sortedNames.indexOf(MainStore.classes[classIndex]
              .terms[termIndex].students[i].name) +
          1;
    }
  }

  _termAverage(int classIndex, int termIndex) {
    for (int i = 0;
        i <
            MainStore.classes[classIndex].terms[termIndex]
                .students.length;
        i++) {
      MainStore.classes[classIndex].terms[termIndex].students[i]
          .average = MainStore.classes[classIndex]
              .terms[termIndex].students[i].total
              .toDouble() /
          MainStore.classes[classIndex].terms[termIndex].subjects
              .length
              .toDouble();
    }
  }

  _subjectAverage(int classIndex, int termIndex) {
    double total = 0.0;
    for (int i = 0;
        i <
            MainStore.classes[classIndex].terms[termIndex]
                .subjects.length;
        i++) {
      for (int j = 0;
          j <
              MainStore.classes[classIndex].terms[termIndex]
                  .students.length;
          j++) {
        total += MainStore.classes[classIndex].terms[termIndex]
            .students[j].subjects[i].total;
      }
      for (int j = 0;
          j <
              MainStore.classes[classIndex].terms[termIndex]
                  .students.length;
          j++) {
        MainStore.classes[classIndex].terms[termIndex].students[j]
                .subjects[i].average =
            (total.toDouble() /
                MainStore.classes[classIndex].terms[termIndex]
                    .students.length
                    .toDouble());
      }

      total = 0.0;
    }
  }

  _subjectGrade(int classIndex, int termIndex) {
    for (int i = 0;
        i <
            MainStore.classes[classIndex].terms[termIndex]
                .students.length;
        i++) {
      for (int j = 0;
          j <
              MainStore.classes[classIndex].terms[termIndex]
                  .subjects.length;
          j++) {
        if (MainStore.classes[classIndex].terms[termIndex]
                    .students[i].subjects[j].total >=
                80 &&
            MainStore.classes[classIndex].terms[termIndex]
                    .students[i].subjects[j].total <=
                100) {
          MainStore.classes[classIndex].terms[termIndex]
              .students[i].subjects[j].grade = "A";
        } else if (MainStore.classes[classIndex].terms[termIndex]
                    .students[i].subjects[j].total >=
                70 &&
            MainStore.classes[classIndex].terms[termIndex]
                    .students[i].subjects[j].total <=
                79) {
          MainStore.classes[classIndex].terms[termIndex]
              .students[i].subjects[j].grade = "B";
        } else if (MainStore.classes[classIndex].terms[termIndex]
                    .students[i].subjects[j].total >=
                60 &&
            MainStore.classes[classIndex].terms[termIndex]
                    .students[i].subjects[j].total <=
                69) {
          MainStore.classes[classIndex].terms[termIndex]
              .students[i].subjects[j].grade = "C";
        } else if (MainStore.classes[classIndex].terms[termIndex]
                    .students[i].subjects[j].total >=
                50 &&
            MainStore.classes[classIndex].terms[termIndex]
                    .students[i].subjects[j].total <=
                59) {
          MainStore.classes[classIndex].terms[termIndex]
              .students[i].subjects[j].grade = "D";
        } else if (MainStore.classes[classIndex].terms[termIndex]
                    .students[i].subjects[j].total >=
                40 &&
            MainStore.classes[classIndex].terms[termIndex]
                    .students[i].subjects[j].total <=
                49) {
          MainStore.classes[classIndex].terms[termIndex]
              .students[i].subjects[j].grade = "E";
        } else if (MainStore.classes[classIndex].terms[termIndex]
                    .students[i].subjects[j].total >=
                0 &&
            MainStore.classes[classIndex].terms[termIndex]
                    .students[i].subjects[j].total <=
                39) {
          MainStore.classes[classIndex].terms[termIndex]
              .students[i].subjects[j].grade = "F";
        } else {}
      }
    }
  }

  bool emptyField(int classIndex, int termIndex) {
    bool isEmpty = false;
    if (MainStore.classes[classIndex].terms[termIndex].students
            .isEmpty ||
        MainStore.classes[classIndex].terms[termIndex].subjects
            .isEmpty) {
      isEmpty = true;
    } else {
      for (int i = 0;
          i <
              MainStore.classes[classIndex].terms[termIndex]
                  .students.length;
          i++) {
        if (isEmpty) {
          break;
        } else {
          if (MainStore.classes[classIndex].terms[termIndex]
              .students[i].subjects.isEmpty) {
            isEmpty = true;
            break;
          } else {
            for (int j = 0;
                j <
                    MainStore.classes[classIndex].terms[termIndex]
                        .subjects.length;
                j++) {
              if (isEmpty) {
                break;
              } else {
                for (int k = 0; k < 2; k++) {
                  if (MainStore
                          .classes[classIndex]
                          .terms[termIndex]
                          .students[i]
                          .subjects[j]
                          .ass[k] ==
                      -1) {
                    isEmpty = true;
                    break;
                  } else {}
                }
              }
            }
          }
        }
      }
    }
    return isEmpty;
  }