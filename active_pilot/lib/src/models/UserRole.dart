enum Role { admin, instructor, pilot, student, registered }

T enumFromString<T>(List<T> values, String value) {
  return values.firstWhere((v) => v.toString().split('.')[1] == value,
        orElse: null);
}

String enumValueToString(Object o) => o.toString().split('.').last;

