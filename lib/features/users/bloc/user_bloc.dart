import 'package:elyx_digital_user_app/features/users/bloc/user_event.dart';
import 'package:elyx_digital_user_app/features/users/bloc/user_state.dart';
import 'package:elyx_digital_user_app/features/users/models/user_model.dart';
import 'package:elyx_digital_user_app/features/users/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_strings.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserFetchDataEvent>(_fetchUserData);
    on<RefreshUsersEvent>(_refreshUserData);
    on<LoadMoreUsersEvent>(_loadMoreUserData);
    on<UserSearchDataEvent>(_fetchSearchData);
  }

  UserRepository userRepository = UserRepository();

  int currentPage = 1;
  bool isFetchingMore = false;
  List<UserModel> allUsers = [];

  ///...
  _fetchUserData(UserFetchDataEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      currentPage = 1;
      final data = await userRepository.fetchUsersData(page: currentPage);
      final hasReachedEnd = data.isEmpty;
      allUsers.addAll(data);
      emit(UserLoaded(data: data, hasReachedEnd: hasReachedEnd));
    } catch (e) {
      // print("bloc eror: $e");
      if (e.toString().contains('SocketException')) {
        emit(UserError(message: networkErrorText));
      } else if (e.toString().contains('TimeoutException')) {
        emit(UserError(message: timeoutErrorText));
      } else {
        emit(UserError(message: errorText));
      }
    }
  }

  ///...
  _refreshUserData(RefreshUsersEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      currentPage = 1;
      final data = await userRepository.fetchUsersData(page: currentPage);
      final hasReachedEnd = data.isEmpty;
      allUsers.addAll(data);
      emit(UserLoaded(data: data, hasReachedEnd: hasReachedEnd));
    } catch (e) {
      emit(UserError(message: '$errorText: $e'));
    }
  }

  ///...
  _loadMoreUserData(LoadMoreUsersEvent event, Emitter<UserState> emit) async {
    if (state is UserLoaded && !isFetchingMore) {
      final currentState = state as UserLoaded;
      if (currentState.hasReachedEnd) return;

      isFetchingMore = true;
      // emit(UserLoading());

      try {
        final nextPage = currentPage + 1;

        final data = await userRepository.fetchUsersData(page: nextPage);

        if (data.isEmpty) {
          emit(UserLoaded(data: currentState.data, hasReachedEnd: true));
        } else {
          currentPage = nextPage;
          final allData = List<UserModel>.from(currentState.data)..addAll(data);
          allUsers.addAll(data);
          emit(UserLoaded(data: allData, hasReachedEnd: false));
        }
      } catch (e) {
        emit(UserError(message: 'Error loading more: $e'));
      } finally {
        isFetchingMore = false;
      }
    }
  }

  ///...
  _fetchSearchData(UserSearchDataEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      // print("bloc Users: ${allUsers.length}");
      currentPage = 1;
      // final data = await userRepository.fetchSearchedData(event.query);
      final data = allUsers.where((user) {
        final fullName = '${user.firstName} ${user.lastName}'.toLowerCase();
        return fullName.contains(event.query.toLowerCase());
      }).toList();
      final hasReachedEnd = data.isEmpty;
      emit(UserLoaded(data: data, hasReachedEnd: hasReachedEnd));
    } catch (e) {
      emit(UserError(message: '$errorText: $e'));
    }
  }
}
