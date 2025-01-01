import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoware/blocs/form_event.dart';
import 'package:infoware/blocs/form_state.dart';

class FormBloc extends Bloc<FormEvent, UserFormState> {
  FormBloc() : super(UserFormInitialState());

  @override
  Stream<UserFormState> mapEventToState(FormEvent event) async* {
    if (event is SubmitFormEvent) {
      yield UserFormSubmittingState(); // Indicating that the form is being submitted

      try {
        // Simulate form submission (e.g., sending data to an API)
        await Future.delayed(Duration(seconds: 2));

        // If successful, emit the submitted state
        yield UserFormSubmittedState();
      } catch (e) {
        // If there's an error during form submission, yield the error state
        yield UserFormSubmissionErrorState('Failed to submit form');
      }
    }
  }
}
