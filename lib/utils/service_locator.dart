import 'package:food_truck/utils/dio_client.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  // DioClient
  getIt.registerFactory<DioClient>(() => DioClient('https://food-truck-latest.onrender.com/api'));
}
