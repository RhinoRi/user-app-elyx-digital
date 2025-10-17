abstract class UserEvent {}

class UserFetchDataEvent extends UserEvent {
  UserFetchDataEvent();
}

class UserSearchDataEvent extends UserEvent {
  final String query;
  UserSearchDataEvent(this.query);
}

class RefreshUsersEvent extends UserEvent {}

class LoadMoreUsersEvent extends UserEvent {}
