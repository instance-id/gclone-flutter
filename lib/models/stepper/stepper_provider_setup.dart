import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gclone_flutter/models/provider_data.dart';
import 'package:gclone_flutter/models/stepper/stepper_settings.dart';
import 'package:gclone_flutter/routes/provider_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'demo_data.dart';

class ProviderSetup extends StatefulWidget {
  final ProviderData selectedProvider = currentProvider;

  ProviderSetup({Key key}) : super(key: key);

  @override
  _ProviderSetupState createState() => _ProviderSetupState();
}

class _ProviderSetupState extends State<ProviderSetup> {
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormFieldState> _specifyTextFieldKey =
      GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    var stepperData = Provider.of<StepperSetting>(context);
    var selectedProvider = stepperData.getSelectedProvider();

    ValueChanged _onChanged = (val) => print(val);

    return Container(
      // height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(120, 20, 120, 0),
        child: Column(
          children: <Widget>[
            FormBuilder(
              // context,
              key: _fbKey,
              autovalidate: true,
              initialValue: {
                'movie_rating': 5,
              },
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
                  FormBuilderChipsInput(
                    decoration: InputDecoration(labelText: "Chips"),
                    attribute: 'chips_test',
                    // readonly: true,
                    onChanged: _onChanged,
                    // valueTransformer: (val) => val.length > 0 ? val[0] : null,
                    initialValue: [
                      Contact('Andrew', 'stock@man.com',
                          'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
                    ],
                    maxChips: 5,
                    findSuggestions: (String query) {
                      if (query.length != 0) {
                        var lowercaseQuery = query.toLowerCase();
                        return mockResults.where((profile) {
                          return profile.name
                                  .toLowerCase()
                                  .contains(query.toLowerCase()) ||
                              profile.email
                                  .toLowerCase()
                                  .contains(query.toLowerCase());
                        }).toList(growable: false)
                          ..sort((a, b) => a.name
                              .toLowerCase()
                              .indexOf(lowercaseQuery)
                              .compareTo(b.name
                                  .toLowerCase()
                                  .indexOf(lowercaseQuery)));
                      } else {
                        return const <Contact>[];
                      }
                    },
                    chipBuilder: (context, state, profile) {
                      return InputChip(
                        key: ObjectKey(profile),
                        label: Text(profile.name),
                        avatar: CircleAvatar(
                          backgroundImage: NetworkImage(profile.imageUrl),
                        ),
                        onDeleted: () => state.deleteChip(profile),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      );
                    },
                    suggestionBuilder: (context, state, profile) {
                      return ListTile(
                        key: ObjectKey(profile),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(profile.imageUrl),
                        ),
                        title: Text(profile.name),
                        subtitle: Text(profile.email),
                        onTap: () => state.selectSuggestion(profile),
                      );
                    },
                  ),
                  FormBuilderDateTimePicker(
                    attribute: "date",
                    onChanged: _onChanged,
                    inputType: InputType.date,
                    format: DateFormat("yyyy-MM-dd"),
                    decoration: InputDecoration(labelText: "Appointment Time"),
                    // readonly: true,
                  ),
                  FormBuilderSlider(
                    attribute: "slider",
                    validators: [FormBuilderValidators.min(6)],
                    onChanged: _onChanged,
                    min: 0.0,
                    max: 10.0,
                    initialValue: 7.0,
                    divisions: 20,
                    activeColor: Colors.red,
                    inactiveColor: Colors.pink[100],
                    decoration: InputDecoration(
                      labelText: "Number of things",
                    ),
                  ),
                  FormBuilderRangeSlider(
                    attribute: "range_slider",
                    validators: [FormBuilderValidators.min(6)],
                    onChanged: _onChanged,
                    min: 0.0,
                    max: 100.0,
                    initialValue: RangeValues(4, 7),
                    divisions: 20,
                    activeColor: Colors.red,
                    inactiveColor: Colors.pink[100],
                    decoration: InputDecoration(
                      labelText: "Price Range",
                    ),
                  ),
                  FormBuilderCheckbox(
                    attribute: 'accept_terms',
                    initialValue: false,
                    onChanged: _onChanged,
                    leadingInput: true,
                    // label: Text("I have read and agree to the terms and conditions"),
                    label: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'I have read and agree to the ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print("launch url");
                              },
                          ),
                        ],
                      ),
                    ),
                    validators: [
                      FormBuilderValidators.requiredTrue(
                        errorText:
                            "You must accept terms and conditions to continue",
                      ),
                    ],
                  ),
                  FormBuilderDropdown(
                    attribute: "gender",
                    decoration: InputDecoration(labelText: "Gender"),
                    initialValue: 'Male',
                    readOnly: true,
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
                    decoration: InputDecoration(labelText: "Age"),
                    onChanged: _onChanged,
                    valueTransformer: (text) => num.tryParse(text),
                    validators: [
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.max(70),
                    ],
                  ),
                  FormBuilderTypeAhead(
                    // initialValue: "Canada",
                    decoration: InputDecoration(labelText: "Country"),
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
                          return country.toLowerCase().contains(lowercaseQuery);
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
                    decoration:
                        InputDecoration(labelText: 'My chosen language'),
                    attribute: "best_language",
                    leadingInput: true,
                    onChanged: _onChanged,
                    validators: [FormBuilderValidators.required()],
                    options: ["Dart", "Kotlin", "Java", "Swift", "Objective-C"]
                        .map((lang) => FormBuilderFieldOption(value: lang))
                        .toList(growable: false),
                  ),
                  FormBuilderSegmentedControl(
                    decoration:
                        InputDecoration(labelText: "Movie Rating (Archer)"),
                    attribute: "movie_rating",
                    options: List.generate(5, (i) => i + 1)
                        .map((number) => FormBuilderFieldOption(value: number))
                        .toList(),
                    onChanged: _onChanged,
                  ),
                  FormBuilderSwitch(
                    label: Text('I Accept the tems and conditions'),
                    attribute: "accept_terms_switch",
                    initialValue: true,
                    onChanged: _onChanged,
                  ),
                  FormBuilderStepper(
                    decoration: InputDecoration(labelText: "Stepper"),
                    attribute: "stepper",
                    initialValue: 10,
                    step: 1,
                    onChanged: (data) {
                      //_fbKey.currentState.fields['age'].currentState.didChange("$data");
                      //_fbKey.currentState.setAttributeValue("age", "$data");
                    },
                    validators: [
                      (val) {
                        if (!_fbKey.currentState.fields["accept_terms_switch"]
                                .currentState.value &&
                            val >= 10) {
                          return "You can only put more than 10 if you've accepted terms";
                        }
                        return null;
                      }
                    ],
                  ),
                  FormBuilderRate(
                    decoration: InputDecoration(labelText: "Rate this form"),
                    attribute: "rate",
                    iconSize: 32.0,
                    initialValue: 1,
                    max: 5,
                    onChanged: _onChanged,
                  ),
                  FormBuilderCheckboxList(
                    decoration:
                        InputDecoration(labelText: "The language of my people"),
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
                              labelText: "What's your preferred language?"),
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
                                                      key: _specifyTextFieldKey,
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
                    decoration: InputDecoration(labelText: "Signature"),
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
      ), //Text('Selected Provider: ${selectedProvider.name}'),
    );
  }
}
