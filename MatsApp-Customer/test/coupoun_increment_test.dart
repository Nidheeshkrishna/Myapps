import 'package:flutter_test/flutter_test.dart';

void main() {
  group("test", () {
    test("couponIncrementTest", () => expect(false, updateCoupon(4999, 4800, 4)));
    test("couponIncrementTest", () => expect(true, updateCoupon(4999, 4000, 5)));
    test("couponIncrementTest", () => expect(false, updateCoupon(4999, 5200, 4)));
  });
}

bool updateCoupon(
    double maximumDenomination, double couponValue, int multiplier) {
  return maximumDenomination >= (couponValue / multiplier) * (1 + multiplier);
}
