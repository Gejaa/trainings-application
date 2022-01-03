// To parse this JSON data, do
//
//     final trainingsModel = trainingsModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

TrainingsModel trainingsModelFromJson(String str) => TrainingsModel.fromJson(json.decode(str));

String trainingsModelToJson(TrainingsModel data) => json.encode(data.toJson());

class TrainingsModel {
  TrainingsModel({
    this.training,
    this.trainerName,
    this.location,
    this.mrp,
    this.discountedFinalAmount,
    this.trainerProfile,
    this.durationDate,
    this.durationTime,
    this.rating,
    this.offerOnGoing,
    this.createdAt,
  });

  String? training;
  String? trainerName;
  String? location;
  String? mrp;
  String? discountedFinalAmount;
  String? trainerProfile;
  String? durationDate;
  String? durationTime;
  String? rating;
  String? offerOnGoing;
  Timestamp? createdAt;

  factory TrainingsModel.fromJson(Map<String, dynamic> json) => TrainingsModel(
    training: json["Training"],
    trainerName: json["Trainer_Name"],
    location: json["Location"],
    mrp: json["MRP"],
    discountedFinalAmount: json["Discounted_Final_Amount"],
    trainerProfile: json["Trainer_Profile"],
    durationDate: json["Duration_date"],
    durationTime: json["Duration_Time"],
    rating: json["Rating"],
    offerOnGoing: json["Offer_On_Going"],
    createdAt: json["Created_At"],
  );

  Map<String, dynamic> toJson() => {
    "Training": training,
    "Trainer_Name": trainerName,
    "Location": location,
    "MRP": mrp,
    "Discounted_Final_Amount": discountedFinalAmount,
    "Trainer_Profile": trainerProfile,
    "Duration_date": durationDate,
    "Duration_Time": durationTime,
    "Rating": rating,
    "Offer_On_Going": offerOnGoing,
    "Created_At": createdAt,
  };
}
