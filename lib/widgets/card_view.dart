import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mytrainingsapp/model/trainings_model.dart';
import 'package:mytrainingsapp/screens/training_details_screen.dart';
import 'package:mytrainingsapp/utils/color_utils.dart';
import 'package:mytrainingsapp/utils/image_utils.dart';
import 'package:mytrainingsapp/utils/string_utils.dart';

class CardView extends StatefulWidget {
  List<TrainingsModel> trainingList=[];
  CardView({Key? key,required this.trainingList}) : super(key: key);

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  StringUtils stringUtils = StringUtils();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: widget.trainingList.length,
        shrinkWrap: true,
        physics:const NeverScrollableScrollPhysics(),
        itemBuilder: (context, snapshot) {
          return Padding(
            padding:const EdgeInsets.all(12.0),
            child: InkWell(
              child: Card(
                elevation: 2.0,
                color: Colors.white,
                shape:const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
                child: SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding:const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.trainingList[snapshot].durationDate.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    widget.trainingList[snapshot].durationTime.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Text(
                                widget.trainingList[snapshot].location.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                       const SizedBox(
                          width: 10,
                        ),
                       const DottedLine(
                          direction: Axis.vertical,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: Colors.black,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        ),
                       const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               Text(
                                 widget.trainingList[snapshot].offerOnGoing.toString(),
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width /
                                              2.2),
                                  child:Text(
                                    widget.trainingList[snapshot].training.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width /
                                              2.02),
                                  child: ListTile(
                                    title: Text(
                                      widget.trainingList[snapshot].trainerProfile.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      widget.trainingList[snapshot].trainerName.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    leading: CircleAvatar(
                                        radius: 25,
                                        backgroundImage:
                                            AssetImage(ImageUtils().scrumImage),
                                        backgroundColor: Colors.black,
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            backgroundImage: AssetImage(
                                                ImageUtils().scrumlogo),
                                            radius: 10,
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.0),
                                    color: ColorUtils.appPrimaryColor),
                                child: Padding(
                                  padding:const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 15, right: 15),
                                  child: Text(
                                    stringUtils.enrollNow,
                                    style:const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Fluttertoast.showToast(
                                    msg: stringUtils.thanksResponse,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.black);
                                }
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(
                        builder: (context) =>
                        new TrainingDetailsScreen(trainingsModel: widget.trainingList[snapshot],)));
              },
            ),
          );
        });
  }
}
