class CustomErrorException implements Exception {
  CustomErrorException(this.message);

  final dynamic message;

  @override
  String toString() {
    return message;
  }
}

/// Thrown if delete process failure occurs.
class DeleteFailed implements CustomErrorException {
  @override
  final dynamic message = 'Can not delete process: ERROR-D00';
}

/// Thrown if delete all process failure occurs.
class DeleteAllFailed implements CustomErrorException {
  @override
  final dynamic message = 'Can not delete all process: ERROR-D01';
}

class InsertFailed implements CustomErrorException {
  @override
  final dynamic message = 'Can not insert process: ERROR-D02';
}

/// Thrown if insert list process failure occurs.
class InsertListFailed implements CustomErrorException {
  @override
  final dynamic message = 'Can not insert list process: ERROR-D03';
}

/// Thrown if select process failure occurs.
class SelectFailed implements CustomErrorException {
  @override
  final dynamic message = 'Can not load process: ERROR-D04';
}

/// Thrown if select all process failure occurs.
class SelectAllFailed implements CustomErrorException {
  @override
  final dynamic message = 'Can not load all process: ERROR-D05';
}