import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter FormBuilder Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormFieldState> _specifyTextFieldKey =
  GlobalKey<FormFieldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ValueChanged _onChanged = (val) => print(val);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("FormBuilder Example"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                // context,
                key: _fbKey,
                autovalidate: true,
                // readonly: true,
                child: Column(
                  children: <Widget>[
                    FormBuilderDateTimePicker(
                      attribute: "date",
                      onChanged: _onChanged,
                      inputType: InputType.date,
                      format: DateFormat("dd-MM-yyyy"),
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(
                        labelText: "Appointment Time",
                        icon: const Icon(Icons.calendar_today),
                        hintText: "Select hint",
                      ),
                      // readonly: true,
                    ),

                    FormBuilderDropdown(
                      attribute: "gender",
                      decoration: InputDecoration(
                        labelText: "Gender",
                        icon: const Icon(Icons.category),
                        hintText: "Select hint",
                      ),
                      // initialValue: 'Male',
                      onChanged: _onChanged,
                      hint: Text('Select Gender'),
                      validators: [FormBuilderValidators.required()],
                      items: ['Male', 'Female', 'Other']
                          .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text('$gender'),
                      ))
                          .toList(),
                    ),
                    FormBuilderTextField(
                      attribute: "age",
                      decoration: InputDecoration(
                        labelText: "Age",
                        icon: const Icon(Icons.accessibility),
                        hintText: "Select hint",
                      ),
                      onChanged: _onChanged,
                      valueTransformer: (text) => num.tryParse(text),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.required()
                      ],
                    ),
                    FormBuilderRadio(
                      decoration: InputDecoration(
                        labelText: 'My chosen language',
                        icon: const Icon(Icons.language),
                        hintText: "Select hint",
                      ),
                      attribute: "best_language",
                      leadingInput: true,
                      onChanged: _onChanged,
                      validators: [FormBuilderValidators.required()],
                      options: [
                        "Dart",
                        "Kotlin",
                        "Java",
                        "Swift",
                        "Objective-C"
                      ]
                          .map((lang) => FormBuilderFieldOption(value: lang))
                          .toList(growable: false),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _fbKey.currentState.save();
                        if (_fbKey.currentState.validate()) {
                          print(_fbKey.currentState.value);
                        } else {
                          print(_fbKey.currentState.value);
                          print("validation failed");
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text('Validation failed'),
                                duration: Duration(seconds: 3),
                              ));
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: MaterialButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Reset",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _fbKey.currentState.reset();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class Contact {
  final String name;
  final String email;
  final String imageUrl;

  const Contact(this.name, this.email, this.imageUrl);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Contact &&
              runtimeType == other.runtimeType &&
              name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name;
  }
}

const allCountries = [
  "Afghanistan",
  "Albania",
  "Algeria",
  "American Samoa",
  "Andorra",
  "Angola",
  "Anguilla",

];

const contacts = <Contact>[
  Contact('Andrew', 'stock@man.com',
      'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
  Contact('Paul', 'paul@google.com',
      'https://mbtskoudsalg.com/images/person-stock-image-png.png'),
  Contact('Fred', 'fred@google.com',
      'https://media.istockphoto.com/photos/feeling-great-about-my-corporate-choices-picture-id507296326'),
  Contact('Brian', 'brian@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),

];