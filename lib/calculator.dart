class CalculatorTools {
  // Input: number of dollars (positive double)
  // Output: number of dollars to BTC
  //1 United States Dollar equals
  //0.000018 Bitcoin

  static double usdToBtcCalculator(double usd) {
    if (usd <= 0) {
      throw ArgumentError();
    }
    return usd * .000018;
  }

  // Input: number of BTC (positive double)
  // Output: number of BTC to Dollars
  //1 Bitcoin equals
  //57,232.80 United States Dollar
  static double btcToUsdCalculator(double btc) {
    if (btc <= 0) {
      throw ArgumentError();
    }
    return btc * 57232.80;
  }
}
