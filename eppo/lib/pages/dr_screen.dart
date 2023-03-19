import 'dart:convert';

import 'package:flutter/material.dart';

class Doctor {
  final String name;
  final String speciality;
  final String location;
  final double rating;
  final String image;
  final String id;

  Doctor({
    required this.name,
    required this.speciality,
    required this.location,
    required this.rating,
    required this.image,
    required this.id,
  });
}

class DoctorListScreen extends StatefulWidget {
  final List<Doctor> doctors;

  const DoctorListScreen({Key? key, required this.doctors}) : super(key: key);

  @override
  _DoctorListScreenState createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  final TextEditingController _searchController = TextEditingController();

  late List<Doctor> _filteredDoctors;

  @override
  void initState() {
    super.initState();
    _filteredDoctors = widget.doctors;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor List'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final query = await showSearch<String>(
                context: context,
                delegate: _DoctorSearchDelegate(
                    _filteredDoctors, _searchController.text),
              );
              if (query != null) {
                _searchController.text = query;
                _searchController.selection =
                    TextSelection.collapsed(offset: query.length);
                _filterDoctors();
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _filteredDoctors.length,
        itemBuilder: (BuildContext context, int index) {
          final doctor = _filteredDoctors[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(doctor.image),
            ),
            title: Text(doctor.name),
            subtitle: Text('${doctor.speciality}, ${doctor.location}'),
            trailing: Text('${doctor.rating}'),
          );
        },
      ),
    );
  }

  void _filterDoctors() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredDoctors = widget.doctors
          .where((doctor) =>
              doctor.name.toLowerCase().contains(query) ||
              doctor.speciality.toLowerCase().contains(query) ||
              doctor.location.toLowerCase().contains(query))
          .toList();
    });
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
