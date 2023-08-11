import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_care_app/components/home_screen_drawer.dart';
import 'package:student_care_app/resources/assets_manager.dart';
import 'package:student_care_app/resources/color_manager.dart';
import 'package:student_care_app/resources/styles_manager.dart';

import 'controllers/location_controller.dart';
import 'models/location_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Governorate> _dropDownLocations = [
  Governorate(governorateId: 4, governorateName: 'دمشق')
];

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _dropDownLocations.addAll(
        Provider.of<LocationController>(context, listen: false).locations);
    ;
    super.initState();
  }

  Governorate? _valueLocation = _dropDownLocations[0];
  int? _dropDownValue1Location;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(ImageAssetsManager.profileImage),
            ),
          ],
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButton(
                  value: _valueLocation,
                  style: StylesManager.medium16Black(),
                  underline: const SizedBox(),
                  dropdownColor: ColorManager.lightGrey,
                  iconEnabledColor: ColorManager.costumeBlack,
                  isExpanded: true,
                  items: _dropDownLocations.map<DropdownMenuItem<Governorate>>(
                      (Governorate location) {
                    return DropdownMenuItem<Governorate>(
                      value: location,
                      child: Text(location.governorateName.toString()),
                    );
                  }).toList(),
                  onChanged: (Governorate? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      _dropDownValue1Location = value?.governorateId;
                      _valueLocation = value;
                    });
                  }),
            ),
          ),
          iconTheme: const IconThemeData(
            size: 40, //change size on your need
            color: const Color(0xff242837),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: HomeScreenDrawer(),
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
