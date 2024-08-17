import 'package:hawala/shared/enums.dart';
import 'package:sembast/sembast.dart';


class DataBaseFilter {
  final DataBaseFilterType type;
  final String filedName;
  final dynamic value;
  DataBaseFilter({
    required this.type,
    required this.filedName,
    required this.value,
  });
}

Finder getFilterFinder(List<DataBaseFilter> filters) {
  final filer = filters.map((e) {
    if (e.type == DataBaseFilterType.Equal) {
      return Filter.equals(e.filedName, e.value);
    } else if (e.type == DataBaseFilterType.NotEqual) {
      return Filter.notEquals(e.filedName, e.value);
    } else if (e.type == DataBaseFilterType.GreaterThan) {
      return Filter.greaterThan(e.filedName, e.value);
    } else if (e.type == DataBaseFilterType.GreaterOrEqual) {
      return Filter.greaterThanOrEquals(e.filedName, e.value);
    } else if (e.type == DataBaseFilterType.LessThan) {
      return Filter.lessThan(e.filedName, e.value);
    } else if (e.type == DataBaseFilterType.LessOrEqual) {
      return Filter.lessThanOrEquals(e.filedName, e.value);
    } else if (e.type == DataBaseFilterType.NotInList) {
      return Filter.inList(e.filedName, e.value);
    }
    return Filter.or([]);
  }).toList();
  return Finder(filter: Filter.and(filer));
}
