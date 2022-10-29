Easily convert various time formats to milliseconds. This is the go-to library for manipulating milliseconds.

## Features

- If a number is supplied to `ms`, a string with a unit is returned
- If a string that contains the number is supplied, it returns it as a number (e.g.: it returns `100` for `'100'`)
- If you pass a string with a number and a valid unit, the number of equivalent milliseconds is returned

## Usage

- Just call the **ms** function and pass an argument, if you pass two arguments then the second argument is for how the result you want to display.
- If you pass `true` as the second argument, it means to show the *long* format value.

```dart
import 'package:ultimate_milliseconds/ultimate_milliseconds.dart';

void main() {
  // Convert to Milliseconds
  print(ms('2 days')); // 172800000
  print(ms('1d')); // 86400000
  print(ms('10h')); // 36000000
  print(ms('2.5 hrs')); // 9000000
  print(ms('2h')); // 7200000
  print(ms('1m')); // 60000
  print(ms('5s')); // 5000
  print(ms('1y')); // 31557600000
  print(ms('100')); // 100
  print(ms('-3 days')); // -259200000
  print(ms('-1h')); // -3600000
  print(ms('-200')); // -200

  // Convert from Milliseconds
  print(ms(60000)); // "1m"
  print(ms(2 * 60000)); // "2m"
  print(ms(-3 * 60000)); // "-3m"
  print(ms(ms('10 hours'))); // "10h"

  // Time Format Written-Out
  print(ms(60000, true)); // "1 minute"
  print(ms(2 * 60000, true)); // "2 minutes"
  print(ms(-3 * 60000, true)); // "-3 minutes"
  print(ms(ms('10 hours'), true)); // "10 hours"
}
```

## Additional information
- Origin: [vercel/msr](https://github.com/vercel/ms)
- As always, you can run the tests using: `dart test`
- For any concerns send an email to *jahidurnadim@gmail.com*