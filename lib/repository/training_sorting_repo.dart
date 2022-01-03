import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mytrainingsapp/model/sort_array_list_model.dart';
import 'package:mytrainingsapp/model/trainings_model.dart';

class TrainingRepository {
  final CollectionReference _trainingCollectionReference =
      FirebaseFirestore.instance.collection('trainings');

  final StreamController<List<TrainingsModel>> _trainingMasController =
      StreamController<List<TrainingsModel>>.broadcast();

  List<List<TrainingsModel>> _allPagedResults =
      List<List<TrainingsModel>>.empty(growable: true);

  static const int Limit = 15;
  var _lastDocument;

  Stream listenToRealTime(
      {required bool scrolled,
      required SortArrayListModel sortArrayListModel}) {
    _requestData(scrolled: scrolled, sortArrayListModel: sortArrayListModel);
    return _trainingMasController.stream;
  }

  void _requestData(
      {required bool scrolled,
      required SortArrayListModel sortArrayListModel}) {
    Query pageQuery = sortArrayListModel.trainerList.isEmpty
        ? _trainingCollectionReference
            .where("Training", isEqualTo: sortArrayListModel.trainingNameList)
            .where("Location", isEqualTo: sortArrayListModel.locationList)
            .orderBy('Created_At')
            .limit(Limit)
        : _trainingCollectionReference
            .where("Trainer_Name", whereIn: (sortArrayListModel.trainerList))
            .where("Training", isEqualTo: sortArrayListModel.trainingNameList)
            .where("Location", isEqualTo: sortArrayListModel.locationList)
            .orderBy('Created_At')
            .limit(Limit);
    if (_lastDocument != null && scrolled == true) {
      pageQuery = pageQuery.startAfterDocument(_lastDocument);
    }
    if (scrolled == false) {
      _allPagedResults = [];
    }
    var currentRequestIndex = _allPagedResults.length;

    pageQuery.get().then(
      (snapshot) {
        if (snapshot.docs.isNotEmpty) {
          snapshot as QuerySnapshot<Map<String, dynamic>>;
          var generalData = snapshot.docs
              .map((snapshot) => TrainingsModel.fromJson(snapshot.data()))
              .toList();

          var pageExists = currentRequestIndex < _allPagedResults.length;

          if (pageExists) {
            _allPagedResults[currentRequestIndex] = generalData;
          } else {
            if (scrolled == true) {
              _allPagedResults.add(generalData);
            } else {
              _allPagedResults = [generalData];
            }
          }

          var allData = _allPagedResults.fold<List<TrainingsModel>>(
              List<TrainingsModel>.empty(growable: true),
              (initialValue, pageItems) => initialValue..addAll(pageItems));

          _trainingMasController.add(allData);

          if (currentRequestIndex == _allPagedResults.length - 1) {
            _lastDocument = snapshot.docs.last;
          }
        } else {
          var allData = _allPagedResults.fold<List<TrainingsModel>>(
              List<TrainingsModel>.empty(growable: true),
              (initialValue, pageItems) => initialValue..addAll(pageItems));

          _trainingMasController.add(allData);
        }
      },
    );
  }

  void requestMoreData(
          {required bool scrolled,
          required SortArrayListModel sortArrayListModel}) =>
      _requestData(scrolled: scrolled, sortArrayListModel: sortArrayListModel);
}
