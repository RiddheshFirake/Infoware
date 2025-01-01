import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoware/blocs/form_state.dart';
import 'package:infoware/blocs/form_event.dart';
import 'package:infoware/blocs/form_bloc.dart';

class UserFormPage extends StatefulWidget {
  @override
  _UserFormPageState createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedGender;
  String? _selectedCountry;
  String? _selectedState;
  String? _selectedCity;

  bool _isSubmitting = false; // Track form submission status

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _countries = ['India', 'USA', 'Canada'];
  final Map<String, List<String>> _states = {
    'India': ['Maharashtra', 'Gujarat', 'Delhi'],
    'USA': ['California', 'Texas', 'Florida'],
    'Canada': ['Ontario', 'Quebec', 'British Columbia'],
  };
  final Map<String, List<String>> _cities = {
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur'],
    'Gujarat': ['Ahmedabad', 'Surat', 'Vadodara'],
    'Delhi': ['New Delhi', 'Dwarka'],
    'California': ['Los Angeles', 'San Francisco'],
    'Texas': ['Houston', 'Dallas'],
    'Florida': ['Miami', 'Orlando'],
    'Ontario': ['Toronto', 'Ottawa'],
    'Quebec': ['Montreal', 'Quebec City'],
    'British Columbia': ['Vancouver', 'Victoria'],
  };

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Form',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Color(0xFF003366),
        elevation: 4,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // White back arrow
          onPressed: () {
            Navigator.pop(context); // Pop to go back
          },
        ),
      ),
        body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Phone Field
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Gender Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: _genders
                      .map((gender) => DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your gender';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Country Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedCountry,
                  decoration: InputDecoration(
                    labelText: 'Country',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: _countries
                      .map((country) => DropdownMenuItem(
                    value: country,
                    child: Text(country),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCountry = value;
                      _selectedState = null; // Reset state and city
                      _selectedCity = null;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your country';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // State Dropdown
                if (_selectedCountry != null)
                  DropdownButtonFormField<String>(
                    value: _selectedState,
                    decoration: InputDecoration(
                      labelText: 'State',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items: _states[_selectedCountry]!
                        .map((state) => DropdownMenuItem(
                      value: state,
                      child: Text(state),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedState = value;
                        _selectedCity = null; // Reset city
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your state';
                      }
                      return null;
                    },
                  ),
                SizedBox(height: 16),

                // City Dropdown
                if (_selectedState != null)
                  DropdownButtonFormField<String>(
                    value: _selectedCity,
                    decoration: InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items: _cities[_selectedState]!
                        .map((city) => DropdownMenuItem(
                      value: city,
                      child: Text(city),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCity = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your city';
                      }
                      return null;
                    },
                  ),
                SizedBox(height: 16),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isSubmitting = true; // Start submitting
                        });

                        // Simulate form submission (e.g., API call)
                        await Future.delayed(Duration(seconds: 2));

                        setState(() {
                          _isSubmitting = false; // Stop submitting
                        });

                        // Show success Snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Form submitted successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      primary: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Submit', style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 16),

                // Show CircularProgressIndicator if submitting
                if (_isSubmitting) Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
