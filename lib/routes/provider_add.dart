import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gclone_flutter/animations/animate_provider.dart';
import 'package:gclone_flutter/helpers/params.dart';
import 'package:gclone_flutter/models/get_data.dart';
import 'package:gclone_flutter/models/stepper/stepper_add_provider.dart';
import 'package:gclone_flutter/models/stepper/stepper_provider_setup.dart';
import 'package:gclone_flutter/models/stepper/stepper_settings.dart';
import 'package:gclone_flutter/routes/provider_list.dart';
import 'package:provider/provider.dart';

class ProviderAdd extends StatefulWidget {
  @override
  _ProviderAddState createState() => _ProviderAddState();
}

class _ProviderAddState extends State<ProviderAdd>
    with SingleTickerProviderStateMixin {
  StepperSetting settings;

  AddProviderStepper addProviderStepper = new AddProviderStepper();

  AnimationController _controller;
  int _currentStep = 0;

//  get onStepContinue => _onStepContinue();
//  get onStepCancel => _onStepCancel();

  void initState() {
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<GetDataPlugin>(context);
    var stepperData = Provider.of<StepperSetting>(context);

    var animation = new ProviderAnimation(_controller);

    Widget stepHeader(String header) {
      return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        width: MediaQuery.of(context).size.width * 0.92,
        height: 55,
        decoration: BoxDecoration(color: Color(0xFF424242), boxShadow: [
          BoxShadow(
              color: Colors.black26,
              spreadRadius: 1,
              offset: Offset(0, -1),
              blurRadius: 3)
        ]),
        child: Container(
          // ----------------------------------------------------------- Page Title
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Center(
            child: Text(
              header,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w300,
                fontSize: 22,
              ),
            ),
          ),
        ),
      );
    }

    stepperData = StepperSetting(
      steps: Value(
        value: <Step>[
          Step(
              title: stepHeader("Select a provider"),
              content: ProviderList(),
              isActive: true),
          Step(
              title: stepHeader("Configure Provider"),
              content:
                  ProviderSetup(), //new Text("${() {var provider = stepperData.getSelectedProvider();return provider.name;}}"), //
              state: StepState.editing,
              isActive: true),
          Step(
              title: new Text("Results"),
              content: new Text("Setup Complete!"),
              state: StepState.complete,
              isActive: true),
        ],
      ),
      currentStep: _currentStep,
      type: stepperTypeValue[0],
//      onStepTapped: Value(value: (value) {
//        setState(() {
//          settings = settings.copyWith(
//            currentStep: Value(
//              name: '$value',
//              value: value,
//              label: '$value',
//            ),
//          );
//        });
//        print("onStepTapped : " + _currentStep.toString());
//      }),
      onStepCancel: Value(value: () {
        setState(() {
          if (_currentStep != 0) {
            _currentStep--;
          }
        });
        print("onStepCancel : " + _currentStep.toString());
      }),
      onStepContinue: Value(
        value: () {
          setState(() {
            if (_currentStep != 2) {
              _currentStep++;
            }
          });

          //todo click the continue button
          print("onStepContinue : " + _currentStep.toString());
        },
      ),
    );

    Widget topContent() {
      return Stack(
        children: <Widget>[
          // ------------------------------------------------------------------- Content
          new Stepper(
            steps: stepperData.steps?.value,
            type: stepperData.type?.value,
            currentStep: _currentStep,
            onStepTapped: stepperData.onStepTapped?.value,
            onStepContinue: stepperData.onStepContinue?.value,
            onStepCancel: stepperData.onStepCancel?.value,
            controlsBuilder: (BuildContext context,
                {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
              return Container();
            },
          ),

//          Positioned(
//            left: 15.0,
//            top: 17.0,
//            child: InkWell(
//              onTap: () {
//                Navigator.of(context).pop();
//              },
//              child: Icon(Icons.arrow_back, color: Colors.white),
//            ),
//          )
        ],
      );
    }

    Widget _buildAnimation() {
      return new Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Container(
              height: MediaQuery.of(context).size.height * .5,
              child: topContent(),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Row(
                children: <Widget>[
                  if (_currentStep == 0)
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('CANCEL'),
                    ),
                  if (_currentStep >= 1)
                    FlatButton(
                      onPressed: stepperData.onStepCancel?.value,
                      child: const Text('BACK'),
                    ),
                  FlatButton(
                    onPressed: stepperData.onStepContinue?.value,
                    child: const Text('CONTINUE'),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        body: _buildAnimation(),
      ),
    );
  }

  stepHeader(String header) {
    return;
  }
}
