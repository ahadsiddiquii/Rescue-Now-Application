class ModelChecker {
  bool returnBoolChecker(dynamic variable) {
    if (variable != null && variable.runtimeType.toString() == 'bool') {
      return variable as bool;
    } else {
      return false;
    }
  }
}
