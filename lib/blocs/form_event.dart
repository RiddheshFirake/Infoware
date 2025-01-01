abstract class FormEvent {}

class SubmitFormEvent extends FormEvent {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String country;
  final String state;
  final String city;

  SubmitFormEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.country,
    required this.state,
    required this.city,
  });
}
