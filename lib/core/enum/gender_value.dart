enum GenderValue {
  male,
  female;

  bool isFemale() {
    return this == GenderValue.female;
  }
}

extension GenderValueExtension on String {
  GenderValue get toGenderValue {
    switch (this) {
      case 'female':
        return GenderValue.female;
      case 'male':
        return GenderValue.male;
      default:
        throw Exception('Gender not found');
    }
  }
}
