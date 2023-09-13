import 'package:endproject/model/class.dart';
import 'package:gsheets/gsheets.dart';

class ClassSheetsApi {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "endproject-f1c0b",
  "private_key_id": "65b3a9bf18062ab20a09cb37db4301efa2220f3d",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDeZ6Obf0gMliGU\ncotPFw7KPnxjYy8lDhR/sR/NpozGT//y8RmhEeAOI7sDNFLTU1/8XEB5ERO30XOW\nHQzCo4F8n4LZcFLlIQwHno+gZFioXhnrHc8fWXlS3Q5rMN/W+baYcfSOMW/mEzmv\ncxzph/OdI9RV8zdcnZWEp0l/TWpDpJI+GmSgGvORV/LOqCYDbazw+sDRYz/K9zOL\n7jnoCUlPxOrpFK6dN6kUZ+UlB8AU5gCr+uiIkgsqrS96JsFK56r2p8p0HB5rwdZ/\n3+LfvOjV7jXa0XX7HgVklO6xOMWZF97TKahXDGyKIG9PMxXkvXQqae5OFZ2O+kMv\nhr++3TIPAgMBAAECggEAJnKRMIT47iAYDwMcPSB10JWryDyxvjyoY4i5wEH+DRxw\nWU2/yf3+l0MrBbtKZDkCG2zRQnymxXzCeB1ugslkTah/pNpLokurujd5idc/EmAu\nJ9yf3UII/L+1SeeJkq7Zl5H/noNCXmpNaxzBz0dO4If8oZ0poWummOeYh5bY+3dJ\nqJtiJDo3a4zAJBBERx6mJn+FEXKK/lpTqS2tZ1kKD5jMTSk7UKAQLZce3S0VW1sZ\n4/DKQ23nsY8BWEKF4tAYAtZR3l+R4+/rTHh0Z4iW6vdyUq0YlJzzusFE2qyEySlp\nAFulisjsF2yTn3hP8rijZzqQjDrjvEn2QJG8QglE7QKBgQD7uoXvU8HYeTtJQrxc\n508tXMzJOfmY0FhG4dROCjwdbEJbrVFtEQv/4aGPNAX20BWX+WyR1H2xn8qpWFEc\nhMlV9knbH0qNZHRhAA0suBB1a2IXxfi9D+G875Vj0Ks/sKzrYHtQyY/3zClLLIoQ\nTaVwTwAicGYLYa59O4AHvKiO4wKBgQDiLby6z9v6UvtOdJqrgwW9DC6zNK1w9GCJ\ndQb2KIQZMudfkYCFCIqAEgPpFyOCgt0DDIo+hVjv0TXE9DpOE8UJf7W3GNyh7hnm\nsiNtRbFA6cPjjippdKyWjhRlYW5o0qoxceu0D88GLxOZf1DsH7fD3ln5Fb9jjr9f\nckImXFnr5QKBgQDnmwPj4QI3M8OSci5wo/m7WOiqNAcrzHWMMfduHgiVYafkRaDn\nYonR0j0dTtY18doMS9bSjdlf9g82pCVswdekmcf2LeIgGU7ieHOms2uhPT2xddqX\nyOb/OMgQYEtPfDR9E/YhrHIjodpUahRVT7tpi6YqCZQ54JP0cSwo8jF71QKBgQDb\nu11wDAIFBlsZVFTzLT4E9HHmLdYWN4QV5niV6rSzGm4HvX6jP7H2TAo6h/06jNIU\nZTllFf1aNuDK8A44ziINYWHzeJbYRk4pfoTGYv+aNcDWMMZpXy1QssWD3Iz8DzXD\nBY7chsM0mcWryTGfxAyuoDS+tW8TVJn9Ky6yv+OoNQKBgQCVmesl5cO5cgWFworY\n10MdHBU83X9mjZj8+swrdZwNtMZQFsCgdQjH79hib6XhN/pruz0Ih1wz0l1yUxqC\nYgMyATMRgEzygCkSZ8onBmRM/oMvzEIepf4sTbZ47760vWYpLidTlXKQLCHlD1R/\nB0+DCOVva2x3T2BpDtMiGuO01w==\n-----END PRIVATE KEY-----\n",
  "client_email": "endproject@endproject-f1c0b.iam.gserviceaccount.com",
  "client_id": "106205118751103293136",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/endproject%40endproject-f1c0b.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';
  static final _spreadsheetId = '1vgxNnS3rS0rIIR0epq0vsNpeyQWEmIseYLOZwjPS06c';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _classSheet;
  static Worksheet? _classNum;
  static Worksheet? _classtime;
  static Worksheet? _users;
  static Worksheet? _request;
  static Worksheet? _confirm;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _classSheet = await _getWorkSheet(spreadsheet, title: 'AllClass');
      _classNum = await _getWorkSheet(spreadsheet, title: 'Class');
      _classtime = await _getWorkSheet(spreadsheet, title: 'Time');
      _users = await _getWorkSheet(spreadsheet, title: 'Users');
      _request = await _getWorkSheet(spreadsheet, title: 'Request');
      _confirm = await _getWorkSheet(spreadsheet, title: 'Confirm');

      final firstRow = ClassFields.getFields();
      _classSheet!.values.insertRow(1, firstRow);
      final firstClassRow = ClassNumFields.getFields();
      _classNum!.values.insertRow(1, firstClassRow);
      final firstTimeRow = ClassTimeFields.getFields();
      _classtime!.values.insertRow(1, firstTimeRow);
      final usersRow = UsersFields.getFields();
      _users!.values.insertRow(1, usersRow);
      final requestRow = RequestFields.getFields();
      _request!.values.insertRow(1, requestRow);
      final confirmRow = ConfirmFields.getFields();
      _confirm!.values.insertRow(1, confirmRow);
    } catch (e) {
      print('Init Error : $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
      required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<int> getRowCount() async {
    if(_request == null) return 0;

    final lastRow = await _request!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_request == null) return;

    _request!.values.map.appendRows(rowList);
  }

  static Future<bool> deleteByID(int id) async {
    if(_request == null) return false;

    final index = await _request!.values.rowIndexOf(id);
    if(index == -1) return false;

    return _request!.deleteRow(index);
  }



  static Future<int> getRowCountConfirm() async {
    if(_confirm == null) return 0;

    final lastRow = await _confirm!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future insertConfirm(List<Map<String, dynamic>> rowList) async {
    if (_confirm == null) return;

    _confirm!.values.map.appendRows(rowList);
  }

  static Future<bool> deleteByIDConfirm(int id) async {
    if(_confirm == null) return false;

    final index = await _confirm!.values.rowIndexOf(id);
    if(index == -1) return false;

    return _confirm!.deleteRow(index);
  }

  static Future<bool> updateCell({
    required int id,
    required String key,
    required dynamic value,
  }) async {
    if(_users == null) return false;

    return _users!.values.insertValueByKeys(
      value, 
      columnKey: key, 
      rowKey: id
    );
  }

  static Future<List<ClassTeacher>> getAlls() async {
    if (_classSheet == null) return <ClassTeacher>[];

    final classes = await _classSheet!.values.map.allRows();
    return classes == null ? <ClassTeacher>[] : classes.map(ClassTeacher.fromJson).toList();
  }

  static Future<ClassTeacher?> getByIds(int id) async {
    if (_classSheet == null) return null;

    final json = await _classSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : ClassTeacher.fromJson(json);
  }

  static Future<List<ClassNum>> getAll() async {
    if (_classNum == null) return <ClassNum>[];

    final classes = await _classNum!.values.map.allRows();
    return classes == null ? <ClassNum>[] : classes.map(ClassNum.fromJson).toList();
  }

  static Future<ClassNum?> getById(int id) async {
    if (_classNum == null) return null;

    final json = await _classNum!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : ClassNum.fromJson(json);
  }

  static Future<List<ClassTime>> getTime() async {
    if (_classtime == null) return <ClassTime>[];

    final classes = await _classtime!.values.map.allRows();
    return classes == null ? <ClassTime>[] : classes.map(ClassTime.fromJson).toList();
  }

  static Future<ClassTime?> getByTimeId(int id) async {
    if (_classtime == null) return null;

    final json = await _classtime!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : ClassTime.fromJson(json);
  }

  static Future<List<Users>> getUser() async {
    if (_users == null) return <Users>[];

    final user = await _users!.values.map.allRows();
    return user == null ? <Users>[] : user.map(Users.fromJson).toList();
  }

  static Future<Users?> getByUserId(int id) async {
    if (_users == null) return null;

    final json = await _users!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : Users.fromJson(json);
  }

  static Future<List<Requests>> getRequests() async {
    if (_request == null) return <Requests>[];

    final request = await _request!.values.map.allRows();
    return request == null ? <Requests>[] : request.map(Requests.fromJson).toList();
  }

  static Future<Requests?> getByRequestId(int id) async {
    if (_request == null) return null;

    final json = await _request!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : Requests.fromJson(json);
  }

  static Future<List<Confirms>> getConfirms() async {
    if (_confirm == null) return <Confirms>[];

    final confirm = await _confirm!.values.map.allRows();
    return confirm == null ? <Confirms>[] : confirm.map(Confirms.fromJson).toList();
  }

  static Future<Confirms?> getByConfirmId(int id) async {
    if (_confirm == null) return null;

    final json = await _confirm!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : Confirms.fromJson(json);
  }
}