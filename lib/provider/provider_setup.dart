// provider_setup.dart
import 'package:gclone/models/get_data.dart';
import 'package:gclone/models/provider_data.dart';
import 'package:provider/provider.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

List<SingleChildCloneableWidget> independentServices = [
  //ChangeNotifierProvider.value(value: GetDataPlugin()),
  ChangeNotifierProvider<GetDataPlugin>.value(value: GetDataPlugin()),
  ChangeNotifierProvider<ProviderData>.value(value: ProviderData()),
//  Provider.value(value: ProviderData()),
//  Provider.value(value: GetDataPlugin()),
];

List<SingleChildCloneableWidget> dependentServices = [];

List<ChangeNotifierProvider> uiConsumableProviders = [];
//
//ChangeNotifierProvider.value(value: getDataPlugin),
//ChangeNotifierProvider.value(value: providerData),
//ChangeNotifierProvider<GetDataPlugin>.value(value: GetDataPlugin()),
////ChangeNotifierProvider<ProviderData>.value(value: ProviderData()),
