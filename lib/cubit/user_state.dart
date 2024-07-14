
class UserState {}

final class UserInitial extends UserState {}

final class UserLoadingState extends UserState {}

final class UserFailureState extends UserState {
  final String errMessage;

  UserFailureState({required this.errMessage});
}

final class UserSuccessState extends UserState {}

