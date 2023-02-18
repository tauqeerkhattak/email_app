import 'package:email_client/services/api_service.dart';
import 'package:email_client/services/firestore_service.dart';
import 'package:get_it/get_it.dart';

GetIt serviceGetter = GetIt.instance;

void initGetIt() {
  serviceGetter.registerSingleton(FirebaseService());
  serviceGetter.registerSingleton(ApiService());
}
