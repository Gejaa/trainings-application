import 'package:flutter/material.dart';
import 'package:mytrainingsapp/model/trainings_model.dart';
import 'package:mytrainingsapp/utils/color_utils.dart';
import 'package:mytrainingsapp/utils/image_utils.dart';
import 'package:mytrainingsapp/utils/string_utils.dart';

class TrainingDetailsScreen extends StatefulWidget {
  TrainingsModel trainingsModel = TrainingsModel();

  TrainingDetailsScreen({Key? key, required this.trainingsModel})
      : super(key: key);

  @override
  State<TrainingDetailsScreen> createState() => _TrainingDetailsScreenState();
}

class _TrainingDetailsScreenState extends State<TrainingDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorUtils.appPrimaryColor,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: Text(
            StringUtils().detailView,
            style: const TextStyle(
                color: Colors.white, fontSize: 19, letterSpacing: 0.5),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage(ImageUtils().scrumImage),
                    backgroundColor: Colors.black,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(ImageUtils().scrumlogo),
                        radius: 15,
                      ),
                    )),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  widget.trainingsModel.training.toString() +
                      " (${widget.trainingsModel.rating})",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.trainingsModel.trainerName.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.trainingsModel.trainerProfile.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.trainingsModel.durationDate.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.trainingsModel.durationTime.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.trainingsModel.location.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.trainingsModel.offerOnGoing.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: ColorUtils.appPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringUtils().dollarSymbolText +
                          widget.trainingsModel.mrp.toString(),
                      style: TextStyle(
                          color: ColorUtils.appPrimaryColor,
                          fontSize: 18,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      StringUtils().dollarSymbolText +
                          widget.trainingsModel.discountedFinalAmount
                              .toString(),
                      style: TextStyle(
                          color: ColorUtils.appPrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
