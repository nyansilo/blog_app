import 'package:date_format/date_format.dart';

String dateFormatter(String dateString) {
  var parsedDate = DateTime.parse(dateString);

  final formattedDate =
      formatDate(parsedDate, [dd, ' ', M, ' ', yyyy, ' ', HH, ':', nn]);

  return formattedDate;
}
