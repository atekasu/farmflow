import 'package:farmflow/model/entities/status.dart';

class DummyStatuses {
  static final List<Status> _dummyStatuses = [
    Status.create(name: 'SL400', no: 'No.1', entityType: 'machine'),
    Status.create(name: 'SL400', no: 'No.2', entityType: 'machine'),
    Status.create(name: 'SL400', no: 'No.3', entityType: 'machine'),
    Status.create(name: 'SL500', no: 'No.4', entityType: 'machine'),
    Status.create(name: 'SL500', no: 'No.5', entityType: 'machine'),
    Status.create(name: 'SL550', no: 'No.6', entityType: 'machine'),
    Status.create(name: 'MR700', no: 'No.7', entityType: 'machine'),
    Status.create(name: 'SL600', no: 'No.8', entityType: 'machine'),
  ];

  static List<Status> get all => _dummyStatuses;

  static Status? getByUuid(String uuid) {
    try {
      return _dummyStatuses.firstWhere((status) => status.uuid == uuid);
    } catch (e) {
      return null;
    }
  }
}
