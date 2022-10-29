// Helpers.
const int s = 1000;
final int m = s * 60;
final int h = m * 60;
final int d = h * 24;
final int w = d * 7;
final double y = d * 365.25;

// Pluralization helper.
String plural(num ms, num msAbs, num n, String name) {
  bool isPlural = msAbs >= n * 1.5;
  int rounded = (ms / n).round();

  return '$rounded $name${isPlural ? 's' : ''}';
}

// Short format for `ms`.
String fmtShort(num ms) {
  num msAbs = ms.abs();

  if (msAbs >= d) return '${(ms / d).round()}d';
  if (msAbs >= h) return '${(ms / h).round()}h';
  if (msAbs >= m) return '${(ms / m).round()}m';
  if (msAbs >= s) return '${(ms / s).round()}s';

  return '${ms}ms';
}

// Long format for `ms`.
String fmtLong(num ms) {
  num msAbs = ms.abs();

  if (msAbs >= d) return plural(ms, msAbs, d, 'day');
  if (msAbs >= h) return plural(ms, msAbs, h, 'hour');
  if (msAbs >= m) return plural(ms, msAbs, m, 'minute');
  if (msAbs >= s) return plural(ms, msAbs, s, 'second');

  return '$ms ms';
}

// Parse string
double parse(String str) {
  if (str.length > 100) {
    throw Exception('Value exceeds the maximum length of 100 characters.');
  }

  const String pattern = r'^(?<value>-?(?:\d+)?\.?\d+) *(?<type>milliseconds?|msecs?|ms|seconds?|secs?|s|minutes?|mins?|m|hours?|hrs?|h|days?|d|weeks?|w|years?|yrs?|y)?$';

  final regExp = RegExp(
    pattern,
    caseSensitive: false,
  );

  var match = regExp.firstMatch(str);
  var matchedValue = match?.namedGroup('value'); // exempli gratia: 3
  var matchedType = match?.namedGroup('type'); // exempli gratia: m

  if (matchedValue == null) return double.nan;

  double n = double.parse(matchedValue);
  String type = matchedType != null ? matchedType.toLowerCase() : 'ms';

  switch (type) {
    case 'years':
    case 'year':
    case 'yrs':
    case 'yr':
    case 'y':
      return n * y;

    case 'weeks':
    case 'week':
    case 'w':
      return n * w;

    case 'days':
    case 'day':
    case 'd':
      return n * d;

    case 'hours':
    case 'hour':
    case 'hrs':
    case 'hr':
    case 'h':
      return n * h;

    case 'minutes':
    case 'minute':
    case 'mins':
    case 'min':
    case 'm':
      return n * m;

    case 'seconds':
    case 'second':
    case 'secs':
    case 'sec':
    case 's':
      return n * s;

    case 'milliseconds':
    case 'millisecond':
    case 'msecs':
    case 'msec':
    case 'ms':
      return n;

    default:
      // This should never occur.
      throw Exception('The unit $type was matched, but no matching case exists.');
  }
}

// The main milliseconds function.
ms(dynamic value, [bool long = false]) {
  if (value is String && value.isNotEmpty) {
    try {
      num parsed = parse(value);

      if (!parsed.isNaN) {
        String decimalValue = parsed.toString().split('.')[1];

        if (decimalValue == '0') return parsed.toInt();
      }

      return parsed;
    } catch (e) {
      print(e);
    }
  } else if (value is num && value.isFinite) {
    return long ? fmtLong(value) : fmtShort(value);
  }

  throw ArgumentError('Please pass a valid number or string.');
}
