// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, library_private_types_in_public_api, file_names, use_super_parameters

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spareparts/Serves/CustomDropdown.dart';
import 'package:spareparts/navigationPages/SearchFilter/Results.dart';
import 'package:spareparts/navigationPages/SharePostNav/enums.dart';

class SearchParameters extends StatefulWidget {
  final Function(Map<String, dynamic>) onSearch;

  const SearchParameters({required this.onSearch, Key? key}) : super(key: key);

  @override
  _SearchParametersState createState() => _SearchParametersState();
}

class _SearchParametersState extends State<SearchParameters> {
  String? selectedManufacturer;
  String? selectedModel;
  String? selectedYear;
  String? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'חיפוש',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        // backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDropdownField(
              label: "יצרן",
              value: selectedManufacturer,
              items: selectedCardModel,
              onChanged: (value) {
                setState(() {
                  selectedManufacturer = value;
                  selectedModel = null; // Reset model when manufacturer changes
                });
              },
            ),
            SizedBox(height: 30),
            _buildDropdownField(
              label: "דגם",
              value: selectedModel,
              items: selectedManufacturer != null
                  ? makeOptions[selectedManufacturer] ?? []
                  : [],
              onChanged: (value) {
                if (selectedManufacturer != null) {
                  setState(() {
                    selectedModel = value;
                  });
                }
              },
              enabled: selectedManufacturer != null,
            ),
            SizedBox(height: 30),
            _buildDropdownField(
              label: "שנה",
              value: selectedYear,
              items: dates,
              onChanged: (value) {
                if (selectedModel != null) {
                  setState(() {
                    selectedYear = value;
                  });
                }
              },
              enabled: selectedModel != null,
            ),
            SizedBox(height: 30),
            _buildDropdownField(
              label: "מיקום",
              value: selectedLocation,
              items: LocationsArea,
              onChanged: (value) {
                setState(() {
                  selectedLocation = value;
                });
              },
              enabled: selectedModel != null,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Color.fromARGB(13, 169, 169, 169),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                Query query = FirebaseFirestore.instance.collection('Cars');

                if (selectedManufacturer != null) {
                  query = query.where('manufacturer',
                      isEqualTo: selectedManufacturer);
                }
                if (selectedModel != null) {
                  query = query.where('types', isEqualTo: selectedModel);
                }
                if (selectedYear != null) {
                  query = query.where('Dates', isEqualTo: selectedYear);
                }
                if (selectedLocation != null) {
                  query = query.where('Locations', isEqualTo: selectedLocation);
                }

                QuerySnapshot querySnapshot = await query.get();

                if (selectedManufacturer!.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchResultsPage(
                        results: querySnapshot.docs,
                        category: '',
                      ),
                    ),
                  );
                }
              },
              child: Text(
                "חפש",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    bool enabled = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: enabled ? Colors.white : Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: enabled ? const Color.fromARGB(255, 33, 33, 33) : Colors.grey,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: CustomDropdownButtonFormField(
        labelText: label,
        value: value,
        items: items,
        onChanged: enabled ? onChanged : null, // Only enable if enabled is true
        enabled: enabled,
      ),
    );
  }
}
