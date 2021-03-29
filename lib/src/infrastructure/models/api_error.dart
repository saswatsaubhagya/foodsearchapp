import 'dart:convert';

class ApiError {
  final String error;
  final int errorCode;
  ApiError({
    this.error,
    this.errorCode,
  });

  ApiError copyWith({
    String error,
    int errorCode,
  }) {
    return ApiError(
      error: error ?? this.error,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'error': error,
      'errorCode': errorCode,
    };
  }

  factory ApiError.fromMap(Map<String, dynamic> map) {
    return ApiError(
      error: map['error'],
      errorCode: map['errorCode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiError.fromJson(String source) =>
      ApiError.fromMap(json.decode(source));

  @override
  String toString() => 'ApiError(error: $error, errorCode: $errorCode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApiError &&
        other.error == error &&
        other.errorCode == errorCode;
  }

  @override
  int get hashCode => error.hashCode ^ errorCode.hashCode;
}
