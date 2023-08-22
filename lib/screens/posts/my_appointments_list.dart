// ignore_for_file: avoid_print, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_care_app/controllers/student_controller.dart';
import 'package:student_care_app/models/appointment_model.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class MyAppointmentsList extends StatefulWidget {
  const MyAppointmentsList({
    super.key,
    required Future<List<Appointment>> appointments,
  }) : _appointments = appointments;

  final Future<List<Appointment>> _appointments;

  @override
  State<MyAppointmentsList> createState() =>
      _MyAppointmentsListState(_appointments);
}

class _MyAppointmentsListState extends State<MyAppointmentsList> {
  final Future<List<Appointment>> appointments;
  //late Future<List<Post>> _loadedPosts; // Initialize it here

  _MyAppointmentsListState(this.appointments);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentController>(
        builder: (context, studentController, child) {
      return FutureBuilder<List<Appointment>>(
          future: studentController
              .getCurrentPostAppointmentsList(), // Use the provider here
          builder: (BuildContext context,
              AsyncSnapshot<List<Appointment>> snapshot) {
            if (snapshot.hasData) {
              // Existing code...
              List<Appointment> appointments = snapshot.data!;
              return SizedBox(
                //width: 90.w,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                  scrollDirection: Axis.vertical,
                  itemCount: appointments.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AppointmentCard(appointment: appointments[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 10);
                  },
                ).build(context),
              );
            } else if (snapshot.data!.isEmpty) {
              return CircularProgressIndicator();
            } else {
              return CircularProgressIndicator();
            }
          });
    });
  }
}

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.appointment,
  });

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: ColorManager.lightGrey,
      elevation: 0.5,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListTile(
        title: Text(
          appointment.appointmentPatientName!,
          textAlign: TextAlign.right,
          style: StylesManager.medium17Black(),
        ),
      ),
    );
  }
}
