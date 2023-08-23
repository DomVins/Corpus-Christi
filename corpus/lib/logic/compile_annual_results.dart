import 'dart:collection';

import '../models/annual_students_model.dart';
import '../models/annual_subjects_model.dart';
import '../store/store.dart';

computeAnnualResults(int index) {
  MainStore.annualCompiled = true;
  _addStudentsAnnualToClass(index);
  _addSubjectsAnnualToEachStudent(index);
  _setTermTotalForESubPStud(index);
  _computeYearTotalForESubPStud(index);
  _computeYearAverageForESubPStud(index);
  _computeYearPositionForESubPStud(index);
  _computeHighestForESubPStud(index);
  _computeLowestForESubPStud(index);
  _computeoverAllTotalForEStud(index);
  _computeoverAllAverageForEStud(index);
  _computeoverAllPositionForEStud(index);
}

_addStudentsAnnualToClass(int index) {
  // Just to be sure
  MainStore.classes[index].studentsAnnual.clear();

  List<String> annualStudentNames = [];

  List<StudentAnnual> annualStudents = [];

  for (int i = 0; i < MainStore.classes[index].terms[2].students.length; i++) {
    annualStudentNames.add(MainStore.classes[index].terms[2].students[i].name);
  }

  List<String> annualStudentNamesTrimmed =
      LinkedHashSet<String>.from(annualStudentNames).toList();

  for (int i = 0; i < annualStudentNamesTrimmed.length; i++) {
    annualStudents.add(StudentAnnual(annualStudentNamesTrimmed[i]));
  }

  MainStore.classes[index].studentsAnnual.addAll(annualStudents);
}

_addSubjectsAnnualToEachStudent(int index) {
  for (int i = 0; i < MainStore.classes[index].studentsAnnual.length; i++) {
    for (int j = 0;
        j < MainStore.classes[index].terms[2].subjects.length;
        j++) {
      MainStore.classes[index].studentsAnnual[i].subjects
          .add(SubjectAnnual(MainStore.classes[index].terms[2].subjects[j]));
    }
  }
}

_setTermTotalForESubPStud(int index) {
  for (int i = 0; i < MainStore.classes[index].studentsAnnual.length; i++) {
    for (int j = 0;
        j < MainStore.classes[index].studentsAnnual[i].subjects.length;
        j++) {
      for (int k = 0; k < 3; k++) {
        MainStore.classes[index].studentsAnnual[i].subjects[j].termTotal[k] =
            MainStore.classes[index].terms[k].students[i].subjects[j].total;
      }
    }
  }
}

_computeYearTotalForESubPStud(int index) {
  int yearTotal = 0;
  for (int i = 0; i < MainStore.classes[index].studentsAnnual.length; i++) {
    for (int j = 0;
        j < MainStore.classes[index].studentsAnnual[i].subjects.length;
        j++) {
      for (int k = 0; k < 3; k++) {
        yearTotal +=
            MainStore.classes[index].studentsAnnual[i].subjects[j].termTotal[k];
      }
      MainStore.classes[index].studentsAnnual[i].subjects[j].yearTotal =
          yearTotal;
      yearTotal = 0;
    }
  }
}

_computeYearAverageForESubPStud(int index) {
  for (int i = 0; i < MainStore.classes[index].studentsAnnual.length; i++) {
    for (int j = 0;
        j < MainStore.classes[index].studentsAnnual[i].subjects.length;
        j++) {
      MainStore.classes[index].studentsAnnual[i].subjects[j].average = MainStore
              .classes[index].studentsAnnual[i].subjects[j].yearTotal
              .toDouble() /
          3.0;
    }
  }
}

_computeYearPositionForESubPStud(int index) {
  List<String> sortedNames = [];
  List<SubPosList> namedScores = [];

  for (int b = 0;
      b < MainStore.classes[index].studentsAnnual[0].subjects.length;
      b++) {
    for (int s = 0; s < MainStore.classes[index].studentsAnnual.length; s++) {
      namedScores.add(SubPosList(
          MainStore.classes[index].studentsAnnual[s].name,
          MainStore.classes[index].studentsAnnual[s].subjects[b].yearTotal));
    }
    namedScores.sort(((a, b) => b.subTotal.compareTo(a.subTotal)));

    for (int s = 0; s < MainStore.classes[index].studentsAnnual.length; s++) {
      sortedNames.add(namedScores[s].studentName);
    }

    for (int s = 0; s < MainStore.classes[index].studentsAnnual.length; s++) {
      MainStore.classes[index].studentsAnnual[s].subjects[b].position =
          sortedNames.indexOf(MainStore.classes[index].studentsAnnual[s].name) +
              1;
    }
    namedScores.clear();
    sortedNames.clear();
  }
}

_computeHighestForESubPStud(int index) {
  for (int i = 0; i < MainStore.classes[index].studentsAnnual.length; i++) {
    for (int j = 0;
        j < MainStore.classes[index].studentsAnnual[0].subjects.length;
        j++) {
      for (int k = 0; k < MainStore.classes[index].studentsAnnual.length; k++) {
        if (MainStore.classes[index].studentsAnnual[k].subjects[j].position ==
            1) {
          MainStore.classes[index].studentsAnnual[i].subjects[j].higestInClass =
              MainStore.classes[index].studentsAnnual[k].subjects[j].yearTotal;
          break;
        }
      }
    }
  }
}

_computeLowestForESubPStud(int index) {
  for (int i = 0; i < MainStore.classes[index].studentsAnnual.length; i++) {
    for (int j = 0;
        j < MainStore.classes[index].studentsAnnual[0].subjects.length;
        j++) {
      for (int k = 0; k < MainStore.classes[index].studentsAnnual.length; k++) {
        if (MainStore.classes[index].studentsAnnual[k].subjects[j].position ==
            MainStore.classes[index].studentsAnnual.length) {
          MainStore.classes[index].studentsAnnual[i].subjects[j].loswetInClass =
              MainStore.classes[index].studentsAnnual[k].subjects[j].yearTotal;
          break;
        }
      }
    }
  }
}

_computeoverAllTotalForEStud(int index) {
  int overAllTotal = 0;
  for (int i = 0; i < MainStore.classes[index].studentsAnnual.length; i++) {
    for (int j = 0;
        j < MainStore.classes[index].studentsAnnual[0].subjects.length;
        j++) {
      overAllTotal +=
          MainStore.classes[index].studentsAnnual[i].subjects[j].yearTotal;
    }
    MainStore.classes[index].studentsAnnual[i].overAllTotal = overAllTotal;
    overAllTotal = 0;
  }
}

_computeoverAllAverageForEStud(int index) {
  for (int i = 0; i < MainStore.classes[index].studentsAnnual.length; i++) {
    MainStore.classes[index].studentsAnnual[i].overAllAverage = MainStore
            .classes[index].studentsAnnual[i].overAllTotal
            .toDouble() /
        (MainStore.classes[index].studentsAnnual[0].subjects.length.toDouble() *
            3);
  }
}

_computeoverAllPositionForEStud(int index) {
  List<StudentAnnual> sorted = [];
  sorted.addAll(MainStore.classes[index].studentsAnnual);

  List<String> sortedNames = [];
  sorted.sort(((a, b) => b.overAllTotal.compareTo(a.overAllTotal)));
  for (int i = 0; i < sorted.length; i++) {
    sortedNames.add(sorted[i].name);
  }

  for (int i = 0; i < MainStore.classes[index].studentsAnnual.length; i++) {
    MainStore.classes[index].studentsAnnual[i].overAllPosition =
        sortedNames.indexOf(MainStore.classes[index].studentsAnnual[i].name) +
            1;
  }
}

bool emptyField(int index) {
  bool isEmpty = false;
  for (int v = 0; v < 3; v++) {
    if (isEmpty) {
      break;
    } else {
      if (MainStore.classes[index].terms[v].students.isEmpty ||
          MainStore.classes[index].terms[v].subjects.isEmpty) {
        isEmpty = true;
      } else {
        for (int i = 0;
            i < MainStore.classes[index].terms[v].students.length;
            i++) {
          if (isEmpty) {
            break;
          } else {
            if (MainStore
                .classes[index].terms[v].students[i].subjects.isEmpty) {
              isEmpty = true;
              break;
            } else {
              for (int j = 0;
                  j < MainStore.classes[index].terms[v].subjects.length;
                  j++) {
                if (isEmpty) {
                  break;
                } else {
                  for (int k = 0; k < 2; k++) {
                    if (MainStore.classes[index].terms[v].students[i]
                            .subjects[j].ass[k] ==
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
    }
  }
  return isEmpty;
}

bool checkNames(int index) {
  bool violation = true;
  if (MainStore.classes[index].terms[0].students.length ==
          MainStore.classes[index].terms[1].students.length &&
      MainStore.classes[index].terms[1].students.length ==
          MainStore.classes[index].terms[2].students.length) {
    for (int i = 0;
        i < MainStore.classes[index].terms[0].students.length;
        i++) {
      if (MainStore.classes[index].terms[0].students[i].name ==
              MainStore.classes[index].terms[1].students[i].name &&
          MainStore.classes[index].terms[1].students[i].name ==
              MainStore.classes[index].terms[2].students[i].name) {
        violation = false;
      } else {
        violation = true;
        break;
      }
    }
    return violation;
  } else {
    return violation;
  }
}
