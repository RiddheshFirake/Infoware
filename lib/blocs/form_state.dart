// form_state.dart

abstract class UserFormState {}

class UserFormInitialState extends UserFormState {}

class UserFormSubmittingState extends UserFormState {}

class UserFormSubmittedState extends UserFormState {}

class UserFormSubmissionErrorState extends UserFormState {
  final String errorMessage;

  UserFormSubmissionErrorState(this.errorMessage);
}
