enum CFDataType {
  int64(1),
  float64(2),
  boolean(3),
  string(4),
  map(5),
  list(6); // <-- တိုးလိုက်တာ

  final int value;
  const CFDataType(this.value);

  static CFDataType getNumber(int type) {
    return switch (type) {
      1 => int64,
      2 => float64,
      3 => boolean,
      4 => string,
      5 => map,
      6 => list, // <-- တိုးလိုက်တာ
      _ => throw Exception('TypeNumber: `$type` Not Found Type!'),
    };
  }
}
