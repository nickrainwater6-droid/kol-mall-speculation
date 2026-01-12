/*
  Advanced Mall Price Jump Scanner
  Adds liquidity, volume proxy, and sudden spike detection

  Author: You
*/

int MIN_PRICE = 30000000;

// Trend thresholds
float LONG_TERM_GROWTH = 1.20;  // 7d vs 30d
float SHORT_TERM_SPIKE = 1.15;  // 1d vs 7d

// Liquidity thresholds
int MIN_LISTINGS = 3;
float MAX_SPREAD = 1.25; // 25%

void main()
{
	print("Scanning mall for liquid high-value price spikes...", "blue");

	foreach it in $items[]
	{
		if (!is_tradeable(it)) continue;

		int current = mall_price(it);
		if (current < MIN_PRICE) continue;

		// Historical prices
		int avg1  = historical_price(it, 1);
		int avg7  = historical_price(it, 7);
		int avg30 = historical_price(it, 30);

		if (avg1 <= 0 || avg7 <= 0 || avg30 <= 0) continue;

		float longGrowth  = avg7.to_float() / avg30.to_float();
		float shortGrowth = avg1.to_float() / avg7.to_float();

		// Trend requirements
		if (longGrowth < LONG_TERM_GROWTH) continue;
		if (shortGrowth < SHORT_TERM_SPIKE) continue;
		if (current < avg7) continue;

		// Liquidity checks
		int [int] prices = mall_prices(it);
		int listingCount = count(prices);
		if (listingCount < MIN_LISTINGS) continue;

		sort prices by value;

		int lowest = prices[0];
		int fifth  = prices[min(4, listingCount - 1)];

		float spread = fifth.to_float() / lowest.to_float();
		if (spread > MAX_SPREAD) continue;

		// Report
		print("==================================================", "gray");
		print(it, "green");
		print(" Current Price : " + current);
		print(" 1-day Avg     : " + avg1);
		print(" 7-day Avg     : " + avg7);
		print(" 30-day Avg    : " + avg30);
		print(" 7d/30d Growth : " + longGrowth);
		print(" 1d/7d Spike   : " + shortGrowth);
		print(" Listings      : " + listingCount);
		print(" Spread (5th)  : " + spread);
	}

	print("Scan complete.", "blue");
}
