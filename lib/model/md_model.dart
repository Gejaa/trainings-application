// To parse this JSON data, do
//
//     final mdModel = mdModelFromJson(jsonString);

import 'dart:convert';

MdModel mdModelFromJson(String str) => MdModel.fromJson(json.decode(str));

class MdModel {
  MdModel({
    this.trainingName,
    this.trainer,
    this.location,
  });

  List<String>? trainingName=[];
  List<String>? trainer=[];
  List<String>? location=[];

  factory MdModel.fromJson(Map<String, dynamic> json) => MdModel(
    trainingName: List<String>.from(json["Training_Name"].map((x) => x)),
    trainer: List<String>.from(json["Trainer"].map((x) => x)),
    location: List<String>.from(json["Location"].map((x) => x)),
  );

}
