import 'package:eppo/pages/dr_screen.dart';
import 'package:eppo/pages/person.dart';
import 'package:eppo/screens/book_slot.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import "package:latlong2/latlong.dart" as latLng;

import '../theme/colors.dart';
import '../theme/style.dart';

class SliverDoctorDetail extends StatelessWidget {
  const SliverDoctorDetail({Key? key, this.details, this.decide, this.doc})
      : super(key: key);
  final Map<dynamic, dynamic>? details;
  final bool? decide;
  final Doctor? doc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text('Business Details'),
            backgroundColor: Color(MyColors.primary),
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                image: decide!
                    ? AssetImage(details!['img'])
                    : AssetImage(doc!.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DetailBody(details: details, decide: decide, doc: doc),
          )
        ],
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  const DetailBody({
    Key? key,
    this.details,
    this.decide,
    this.doc,
  }) : super(key: key);
  final Map<dynamic, dynamic>? details;
  final bool? decide;
  final Doctor? doc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DetailDoctorCard(
              name: decide! ? details!['doctorName'] : doc!.name,
              desc: decide! ? details!['doctorTitle'] : doc!.speciality,
              asset: "assets/salon.png"),
          SizedBox(
            height: 15,
          ),
          DoctorInfo(),
          SizedBox(
            height: 30,
          ),
          Text(
            'About the store',
            style: kTitleStyle,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Stylo Salon is open for appointments, in order to book new appointments check below options.',
            style: TextStyle(
              color: Color(MyColors.purple01),
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'Location',
            style: kTitleStyle,
          ),
          SizedBox(
            height: 25,
          ),
          DoctorLocation(),
          SizedBox(
            height: 25,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Color(MyColors.primary),
              ),
            ),
            child: Text('Book Appointment'),
            onPressed: () => {
              Navigator.of(context).pushNamed('/book',
                  arguments:
                      BookArguments(doc?.id ?? '64157b99303ac48fb69cd12e')),
            },
          )
        ],
      ),
    );
  }
}

class DoctorLocation extends StatefulWidget {
  const DoctorLocation({
    Key? key,
  }) : super(key: key);

  @override
  State<DoctorLocation> createState() => _DoctorLocationState();
}

class _DoctorLocationState extends State<DoctorLocation> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 200,
        // child: PeopleWalkingOnLine(
        //   percentage1: 10,
        //   percentage2: 60,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(18.9682, 72.8313),
              zoom: 12,
            ),
            markers: {
              Marker(
                markerId: MarkerId('marker_id'),
                position: LatLng(18.9682, 72.8313),
                infoWindow: InfoWindow(
                  title: 'Stylo Salon',
                  snippet: 'Salon',
                ),
              ),
            },
          ),
        )
        // child: FlutterMap(
        //   options: MapOptions(
        //     center: latLng.LatLng(19.2952, 72.8544),
        //     zoom: 13.0,
        //   ),
        //   layers: [
        //     TileLayerOptions(
        //       urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
        //       subdomains: ['a', 'b', 'c'],
        //     ),
        //   ],
        // ),
        // ),
        );
  }
}

class DoctorInfo extends StatelessWidget {
  const DoctorInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        NumberCard(
          label: 'Visitors',
          value: '100+',
        ),
        SizedBox(width: 15),
        NumberCard(
          label: 'Experiences',
          value: '10 years',
        ),
        SizedBox(width: 15),
        NumberCard(
          label: 'Rating',
          value: '4.0',
        ),
      ],
    );
  }
}

class AboutDoctor extends StatelessWidget {
  final String title;
  final String desc;
  const AboutDoctor({
    Key? key,
    required this.title,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class NumberCard extends StatelessWidget {
  final String label;
  final String value;

  const NumberCard({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(MyColors.bg03),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 15,
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: Color(MyColors.grey02),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              value,
              style: TextStyle(
                color: Color(MyColors.header01),
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailDoctorCard extends StatelessWidget {
  const DetailDoctorCard({
    Key? key,
    this.name,
    this.desc,
    this.asset,
  }) : super(key: key);
  final String? name;
  final String? desc;
  final String? asset;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: EdgeInsets.all(15),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name!,
                      style: TextStyle(
                          color: Color(MyColors.header01),
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      desc!,
                      style: TextStyle(
                        color: Color(MyColors.grey02),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Image(
                image: AssetImage(asset!),
                width: 60,
              )
            ],
          ),
        ),
      ),
    );
  }
}
