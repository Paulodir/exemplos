
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
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
                    FormBuilderCustomField(
                      attribute: "name",
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                      formField: FormField(
                        // key: _fieldKey,
                        enabled: true,
                        builder: (FormFieldState<dynamic> field) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              icon: const Icon(Icons.laptop),
                              hintText: "Select hint",
                              labelText: "Select option",
                              contentPadding:
                              EdgeInsets.only(top: 10.0, bottom: 0.0),
                              border: InputBorder.none,
                              errorText: field.errorText,
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              items: ["One", "Two"].map((option) {
                                return DropdownMenuItem(
                                  child: Text("$option"),
                                  value: option,
                                );
                              }).toList(),
                              value: field.value,
                              onChanged: (value) {
                                field.didChange(value);
                              },
                            ),
                          );
                        },
                      ),
                    ),
//                    FormBuilderChipsInput(
//                      decoration: InputDecoration(
//                        labelText: "Chips",
//                        icon: const Icon(Icons.person),
//                        hintText: "Select hint",
//                      ),
//                      attribute: 'chips_test',
//                      // readonly: true,
//                      onChanged: _onChanged,
//                      // valueTransformer: (val) => val.length > 0 ? val[0] : null,
//                      initialValue: [
//                        Contact('Andrew', 'stock@man.com',
//                            'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
//                      ],
//                      maxChips: 5,
//                      findSuggestions: (String query) {
//                        if (query.length != 0) {
//                          var lowercaseQuery = query.toLowerCase();
//                          return mockResults.where((profile) {
//                            return profile.name
//                                .toLowerCase()
//                                .contains(query.toLowerCase()) ||
//                                profile.email
//                                    .toLowerCase()
//                                    .contains(query.toLowerCase());
//                          }).toList(growable: false)
//                            ..sort((a, b) => a.name
//                                .toLowerCase()
//                                .indexOf(lowercaseQuery)
//                                .compareTo(b.name
//                                .toLowerCase()
//                                .indexOf(lowercaseQuery)));
//                        } else {
//                          return const <Contact>[];
//                        }
//                      },
//                      chipBuilder: (context, state, profile) {
//                        return InputChip(
//                          key: ObjectKey(profile),
//                          label: Text(profile.name),
//                          avatar: CircleAvatar(
//                            backgroundImage: NetworkImage(profile.imageUrl),
//                          ),
//                          onDeleted: () => state.deleteChip(profile),
//                          materialTapTargetSize:
//                          MaterialTapTargetSize.shrinkWrap,
//                        );
//                      },
//                      suggestionBuilder: (context, state, profile) {
//                        return ListTile(
//                          key: ObjectKey(profile),
//                          leading: CircleAvatar(
//                            backgroundImage: NetworkImage(profile.imageUrl),
//                          ),
//                          title: Text(profile.name),
//                          subtitle: Text(profile.email),
//                          onTap: () => state.selectSuggestion(profile),
//                        );
//                      },
//                    ),
                    FormBuilderDateTimePicker(
                      attribute: "date",
                      onChanged: _onChanged,
                      inputType: InputType.date,
                      format: DateFormat("dd-MM-yyyy"),
                      decoration: InputDecoration(
                        labelText: "Appointment Time",
                        icon: const Icon(Icons.calendar_today),
                        hintText: "Select hint",
                      ),
                      // readonly: true,
                    ),
                    FormBuilderSlider(
                      attribute: "slider",
                      validators: [FormBuilderValidators.min(6)],
                      onChanged: _onChanged,
                      min: 0.0,
                      max: 10.0,
                      initialValue: 1.0,
                      divisions: 20,
                      decoration: InputDecoration(
                        labelText: "Number of somethings",
                        icon: const Icon(Icons.snooze),
                        hintText: "Select hint",
                      ),
                    ),
                    FormBuilderCheckbox(
                      decoration: InputDecoration(
                        labelText: "terms",
                        icon: const Icon(Icons.subject),
                        hintText: "Select hint",
                      ),
                      attribute: 'accept_terms',
                      initialValue: false,
                      onChanged: _onChanged,
                      leadingInput: true,
                      label: Text(
                          "I have read and agree to the terms and conditions"),
                      validators: [
                        FormBuilderValidators.requiredTrue(
                          errorText:
                          "You must accept terms and conditions to continue",
                        ),
                      ],
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
                        FormBuilderValidators.max(70),
                      ],
                    ),
                    FormBuilderTypeAhead(
                      // initialValue: "Canada",
                      decoration: InputDecoration(
                        labelText: "Country",
                        icon: const Icon(Icons.golf_course),
                        hintText: "Select hint",
                      ),
                      attribute: 'country',
                      onChanged: _onChanged,
                      itemBuilder: (context, country) {
                        return ListTile(
                          title: Text(country),
                        );
                      },
                      suggestionsCallback: (query) {
                        if (query.length != 0) {
                          var lowercaseQuery = query.toLowerCase();
                          return allCountries.where((country) {
                            return country
                                .toLowerCase()
                                .contains(lowercaseQuery);
                          }).toList(growable: false)
                            ..sort((a, b) => a
                                .toLowerCase()
                                .indexOf(lowercaseQuery)
                                .compareTo(
                                b.toLowerCase().indexOf(lowercaseQuery)));
                        } else {
                          return allCountries;
                        }
                      },
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
                    FormBuilderSegmentedControl(
                      decoration: InputDecoration(
                        labelText: "Movie Rating (Archer)",
                        icon: const Icon(Icons.crop_rotate),
                        hintText: "Select hint",
                      ),
                      attribute: "movie_rating",
                      options: List.generate(5, (i) => i + 1)
                          .map(
                              (number) => FormBuilderFieldOption(value: number))
                          .toList(),
                      onChanged: _onChanged,
                    ),
                    FormBuilderSwitch(
                      decoration: InputDecoration(
                        labelText: "conditions",
                        icon: const Icon(Icons.dashboard),
                        hintText: "Select hint",
                      ),
                      label: Text('I Accept the tems and conditions'),
                      attribute: "accept_terms_switch",
                      initialValue: true,
                      onChanged: _onChanged,
                    ),
                    FormBuilderStepper(
                      decoration: InputDecoration(
                        labelText: "Stepper",
                        icon: const Icon(Icons.account_box),
                        hintText: "Select hint",
                      ),
                      attribute: "stepper",
                      initialValue: 10,
                      step: 1,
                      validators: [
                            (val) {
                          if (!_fbKey.currentState.fields["accept_terms_switch"]
                              .currentState.value &&
                              val >= 10) {
                            return "You can only put more than 10 if you've accepted terms";
                          }
                        }
                      ],
                    ),
                    FormBuilderRate(
                      decoration: InputDecoration(
                        labelText: "Rate this form",
                        icon: const Icon(Icons.branding_watermark),
                        hintText: "Select hint",
                      ),
                      attribute: "rate",
                      iconSize: 32.0,
                      initialValue: 1,
                      max: 5,
                      onChanged: _onChanged,
                    ),
                    FormBuilderCheckboxList(
                      decoration: InputDecoration(
                        labelText: "The language of my people",
                        icon: const Icon(Icons.collections),
                        hintText: "Select hint",
                      ),
                      attribute: "languages",
                      initialValue: ["Dart"],
                      leadingInput: true,
                      options: [
                        FormBuilderFieldOption(value: "Dart"),
                        FormBuilderFieldOption(value: "Kotlin"),
                        FormBuilderFieldOption(value: "Java"),
                        FormBuilderFieldOption(value: "Swift"),
                        FormBuilderFieldOption(value: "Objective-C"),
                      ],
                      onChanged: _onChanged,
                    ),
                    FormBuilderCustomField(
                      attribute: 'custom',
                      valueTransformer: (val) {
                        if (val == "Other")
                          return _specifyTextFieldKey.currentState.value;
                        return val;
                      },
                      formField: FormField(
                        builder: (FormFieldState<String> field) {
                          var languages = [
                            "English",
                            "Spanish",
                            "Somali",
                            "Other"
                          ];
                          return InputDecorator(
                            decoration: InputDecoration(
                              labelText: "What's your preferred language?",
                              icon: const Icon(Icons.bug_report),
                              hintText: "Select hint",
                            ),
                            child: Column(
                              children: languages
                                  .map(
                                    (lang) => Row(
                                  children: <Widget>[
                                    Radio<dynamic>(
                                      value: lang,
                                      groupValue: field.value,
                                      onChanged: (dynamic value) {
                                        field.didChange(lang);
                                      },
                                    ),
                                    lang != "Other"
                                        ? Text(lang)
                                        : Expanded(
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            lang,
                                          ),
                                          SizedBox(width: 20),
                                          Expanded(
                                            child: TextFormField(
                                              key:
                                              _specifyTextFieldKey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                                  .toList(growable: false),
                            ),
                          );
                        },
                      ),
                    ),
                    FormBuilderSignaturePad(
                      decoration: InputDecoration(
                        labelText: "Signature",
                        icon: const Icon(Icons.card_travel),
                        hintText: "Select hint",
                      ),
                      attribute: "signature",
                      // height: 250,
                      clearButtonText: "Start Over",
                      onChanged: _onChanged,
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