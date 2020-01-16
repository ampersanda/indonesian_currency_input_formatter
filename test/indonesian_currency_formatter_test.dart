import 'package:flutter_test/flutter_test.dart';
import 'package:indonesian_currency_formatter/indonesian_currency_formatter.dart';

void main() {
  test('parse', () {
    expect(IndonesianCurrencyInputFormatter.parse(null), null);
    expect(IndonesianCurrencyInputFormatter.parse(''), null);
    expect(IndonesianCurrencyInputFormatter.parse('     '), null);
    expect(IndonesianCurrencyInputFormatter.parse('ABC'), null);

    expect(IndonesianCurrencyInputFormatter.parse('123456789'), 123456789.0);
    expect(
        IndonesianCurrencyInputFormatter.parse('123456789.12'), 12345678912.0);
    expect(
        IndonesianCurrencyInputFormatter.parse('123456789,12'), 123456789.12);
    expect(
        IndonesianCurrencyInputFormatter.parse('123.456.789,12'), 123456789.12);

    expect(IndonesianCurrencyInputFormatter.parse('-123456789'), -123456789.0);
    expect(IndonesianCurrencyInputFormatter.parse('-123456789.12'),
        -12345678912.0);
    expect(
        IndonesianCurrencyInputFormatter.parse('-123456789,12'), -123456789.12);
    expect(IndonesianCurrencyInputFormatter.parse('-123.456.789,12'),
        -123456789.12);

    expect(
        IndonesianCurrencyInputFormatter.parse(
          '1000.12',
          '.',
          ',',
        ),
        1000.12);
  });
}
