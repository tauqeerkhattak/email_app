abstract class MailPageState {}

class InitialMailPageState extends MailPageState {}

class LoadingMailPageState extends MailPageState {}

class LoadedMailPageState extends MailPageState {}

class ErrorMailPageState extends MailPageState {
  final String error;

  ErrorMailPageState(this.error);
}
