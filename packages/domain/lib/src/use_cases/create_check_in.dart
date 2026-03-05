import 'package:domain/src/entities/check_in_event.dart';
import 'package:domain/src/repositories/check_in_repository.dart';

class CreateCheckIn {
  const CreateCheckIn(this._repository);

  final CheckInRepository _repository;

  Future<void> call(CheckInEvent event) => _repository.recordEvent(event);
}
