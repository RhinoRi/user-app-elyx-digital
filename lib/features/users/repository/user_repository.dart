import 'package:elyx_digital_user_app/features/users/models/user_model.dart';

import '../../../core/services/api_services.dart';
import '../cached_data_shared_pref/models/cache_data_funct.dart';

class UserRepository {
  final ApiServices apiServices = ApiServices();

  // get all data...
  Future<List<UserModel>> fetchUsersData({int page = 1}) async {
    // try getting datafrom cache
    final cachedUsers = await getCachedUsers(page);
    if (cachedUsers != null && cachedUsers.isNotEmpty) {
      return cachedUsers;
    }

    // 2. If cache is empty or expired, fetch from API
    try {
      final data = await apiServices.fetchData(page);

      final output = data.map((item) => UserModel.fromJson(item)).toList();

      // 3. Save to cache
      await saveUsersToCache(page, data);

      return output;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  // get the searched data... TESTING Purpose code..
  // Future<List<UserModel>> fetchSearchedData(String query) async {
  //   try {
  //     final data = await apiServices.searchedData();
  //     final allUsers = data.map((item) => UserModel.fromJson(item)).toList();

  //     final searchedUsers = allUsers.where((user) {
  //       final fullName = '${user.firstName} ${user.lastName}'.toLowerCase();
  //       return fullName.contains(query.toLowerCase());
  //     }).toList();

  //     return searchedUsers;
  //   } catch (err) {
  //     throw Exception(err.toString());
  //   }
  // }
}
