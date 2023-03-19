import 'dart:convert';

import 'package:eppo/pages/dr_screen.dart';
import 'package:eppo/pages/home_page.dart';
import 'package:eppo/pages/sliver_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../theme/colors.dart';
import '../theme/style.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key, this.user});
  final List<Doctor>? user;

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  late List<Doctor> _filteredDoctors;
  @override
  void initState() {
    // TODO: implement initState
    _filteredDoctors = widget.user!;
    super.initState();
  }

  final TextEditingController _searchController = TextEditingController();
  List<Map> categories = [
    {'icon': "assets/heart.png", 'text': 'Cardiologist'},
    {'icon': "assets/bone.png", 'text': 'Ortho'},
    {'icon': "assets/brain.png", 'text': 'Neuro'},
  ];

  void _filterDoctors() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredDoctors = widget.user!
          .where((doctor) =>
              doctor.name.toLowerCase().contains(query) ||
              doctor.speciality.toLowerCase().contains(query) ||
              doctor.location.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 245, 245, 245),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              SearchInput(
                hint: "Search for a doctor",
                color: 0xff56f3fe,
                text: _searchController,
                onTap: () async {
                  final query = await showSearch<String>(
                    context: context,
                    delegate: _DoctorSearchDelegate(
                        _filteredDoctors, _searchController.text),
                  );
                  if (query != null) {
                    setState(() {
                      _searchController.text = query;
                      _searchController.selection =
                          TextSelection.collapsed(offset: query.length);
                      _filterDoctors();
                    });
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var category in categories)
                    CategoryIcon(
                      image: category['icon'],
                      text: category['text'],
                      decide: false,
                    ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommended for you',
                    style: kTitleStyle,
                  ),
                  TextButton(
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: Color(MyColors.yellow01),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _filteredDoctors.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final doctor = _filteredDoctors[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SliverDoctorDetail(
                              decide: false,
                              doc: doctor,
                            ),
                          ));
                        },
                        child: Container(
                          width: 200,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(doctor.name),
                                    Text(doctor.speciality),
                                    Row(
                                      children: [
                                        for (int i = 0; i < 5; i++)
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 12,
                                          ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text("Experience"),
                                    Text("8 Years"),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text("Patients"),
                                    Text("1.02K"),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: Image.asset(doctor.image),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                //           ListView.builder(
                //
                //   itemBuilder: (BuildContext context, int index) {
                //
                //     return ListTile(
                //       leading: CircleAvatar(
                //         backgroundImage: AssetImage(doctor.image),
                //       ),
                //       title: Text(doctor.name),
                //       subtitle: Text('${doctor.speciality}, ${doctor.location}'),
                //       trailing: Text('${doctor.rating}'),
                //     );
                //   },
                // ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Doctors Near You',
                    style: kTitleStyle,
                  ),
                  TextButton(
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: Color(MyColors.yellow01),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _filteredDoctors.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final doctor = _filteredDoctors[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SliverDoctorDetail(
                              decide: false,
                              doc: doctor,
                            ),
                          ));
                        },
                        child: Container(
                          width: 200,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(doctor.name),
                                    Text(doctor.speciality),
                                    Row(
                                      children: [
                                        for (int i = 0; i < 5; i++)
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 12,
                                          ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text("Experience"),
                                    Text("8 Years"),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text("Patients"),
                                    Text("1.02K"),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: Image.asset(doctor.image),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                //           ListView.builder(
                //
                //   itemBuilder: (BuildContext context, int index) {
                //
                //     return ListTile(
                //       leading: CircleAvatar(
                //         backgroundImage: AssetImage(doctor.image),
                //       ),
                //       title: Text(doctor.name),
                //       subtitle: Text('${doctor.speciality}, ${doctor.location}'),
                //       trailing: Text('${doctor.rating}'),
                //     );
                //   },
                // ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _DoctorSearchDelegate extends SearchDelegate<String> {
  final List<Doctor> doctors;
  final String initialQuery;

  _DoctorSearchDelegate(this.doctors, this.initialQuery);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredDoctors = doctors
        .where((doctor) =>
            doctor.name.toLowerCase().contains(query) ||
            doctor.speciality.toLowerCase().contains(query) ||
            doctor.location.toLowerCase().contains(query))
        .toList();

    return ListView.builder(
      itemCount: filteredDoctors.length,
      itemBuilder: (BuildContext context, int index) {
        final doctor = filteredDoctors[index];
        return ListTile(
          title: Text(doctor.name),
          subtitle: Text('${doctor.speciality}, ${doctor.location}'),
          onTap: () {
            close(context, doctor.name);
          },
        );
      },
    );
  }
}
