import 'dart:io';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as path;
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import '../entitites/employee_entity.dart';
part 'app_db.g.dart';

//specifying location to database
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, "employeeDb.sqlite"));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [
  Employee,
])
class AppDb extends _$AppDb {
  AppDb():super(_openConnection());

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;

  Stream<List<EmployeeData>> get getEmployees => select(employee).watch();

  Future<List<EmployeeData>> get  getEmployeesList => select(employee).get();

 // Stream<EmployeeData> get getEmployeesWatchSingle => select(employee).watchSingle();


  // Stream<EmployeeData> getEmployeesWatchSingle(int id) {
  //   return (select(employee)..where((t) => t.id.equals(id))).watchSingle();
  // }

  //Get a single employee
  Future<EmployeeData> getEmployee(int id) async {
    return await (select(employee)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  //update an exist employee
  Future<bool> updateEmployee(EmployeeCompanion companionEntity) async {
    return await update(employee).replace(companionEntity);
  }
  //you can write update query like below
 // Future updateEmployee(EmployeeCompanion employeeCompanion) => update(employee).replace(employeeCompanion);


  //add new employee
  Future<int> insertEmployee(EmployeeCompanion companionEntity) async {
    return await into(employee).insert(companionEntity);
  }
  //you can write the insert query like this
  //Future insertEmployee(EmployeeCompanion employeeCompanion) => into(employee).insert(employeeCompanion);

  //delete an employee
  // Future<int> deleteEmployee(int id) async {
  //   return await (delete(employee)..where((tbl) => tbl.id.equals(id))).go();
  // }
  //you can also write the delete query like below
  Future deleteEmployee(EmployeeCompanion employeeCompanion) => delete(employee).delete(employeeCompanion);
}
