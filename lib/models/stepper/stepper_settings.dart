import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gclone/helpers/params.dart';

import '../provider_data.dart';

class StepperSetting extends ChangeNotifier {
  final Value<List<Step>> steps;
  final Value<StepperType> type;
  int currentStep;
  ProviderData selectedProvider;
  final Value<ValueChanged<int>> onStepTapped;
  final Value<VoidCallback> onStepContinue;
  final Value<VoidCallback> onStepCancel;

  StepperSetting({
    this.steps,
    this.type,
    this.currentStep,
    this.selectedProvider,
    this.onStepTapped,
    this.onStepContinue,
    this.onStepCancel,
  });

  setInitialSelectedProvider(value) {
    this.selectedProvider = value;
  }

  setSelectedProvider(value) {
    this.selectedProvider = value;
    notifyListeners();
  }

  getSelectedProvider() {
    return selectedProvider;
  }

  setCurrentStep(value) {
    this.currentStep = value;
    notifyListeners();
  }

  getCurrentStep() {
    return this.currentStep;
  }

  stepContinue() {
    this.onStepContinue?.value;
    notifyListeners();
  }

  stepCancel() {
    return this.onStepCancel;
  }

  StepperSetting copyWith({
    Value<List<Step>> steps,
    Value<StepperType> type,
    int currentStep,
    Value<ValueChanged<int>> onStepTapped,
    Value<VoidCallback> onStepContinue,
    Value<VoidCallback> onStepCancel,
  }) {
    return StepperSetting(
      steps: steps ?? this.steps,
      type: type ?? this.type,
      currentStep: currentStep ?? this.currentStep,
      onStepTapped: onStepTapped ?? this.onStepTapped,
      onStepContinue: onStepContinue ?? this.onStepContinue,
      onStepCancel: onStepCancel ?? this.onStepCancel,
    );
  }
}
