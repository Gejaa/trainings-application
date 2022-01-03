import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mytrainingsapp/model/md_model.dart';
import 'package:mytrainingsapp/model/trainings_model.dart';

class FirebaseGet{
  static Future<MdModel> getMdData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = (await FirebaseFirestore.instance
        .collection('md')
        .get());
    MdModel mdModel=MdModel();
    snapshot.docs.forEach((element) {
      mdModel = MdModel.fromJson(element.data());
    });
    return mdModel;
  }

  static Future<List<TrainingsModel>> getCourosalData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = (await FirebaseFirestore.instance
        .collection('trainings').limit(5)
        .get());
    List<TrainingsModel> trainingsModel=[];
    snapshot.docs.forEach((element) {
      TrainingsModel trainingsIterativeData=TrainingsModel();
      trainingsIterativeData = TrainingsModel.fromJson(element.data());
      trainingsModel.add(trainingsIterativeData);
    });
    return trainingsModel;
  }
}