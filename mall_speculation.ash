void main() {
	int MIN_PRICE = 30000000;

	print("=== Mall Speculation Scan (Compatible Version) ===", "blue");

	foreach it in $items[] {
		if (!is_tradeable(it)) continue;

		int price = mall_price(it);
		if (price < MIN_PRICE) continue;

		// Ignore NPC-sold items
		if (npc_price(it) > 0) continue;

		int auto = autosell_price(it);

		// Only filter by high gap or high price
		if (auto > 0 && price > auto * 500) {
			print(
				it + " | price: " + price + " | autosell: " + auto,
				"green"
			);
		}
	}

	print("=== Scan Complete ===", "blue");
}
