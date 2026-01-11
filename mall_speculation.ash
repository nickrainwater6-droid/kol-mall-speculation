void main() {
	int MIN_PRICE = 30000000;

	print("=== Mall Speculation Scan ===", "blue");

	foreach it in $items[] {
		if (!is_tradeable(it)) continue;

		int price = mall_price(it);
		if (price < MIN_PRICE) continue;

		// Ignore NPC-sold items
		if (npc_price(it) > 0) continue;

		int auto = autosell_price(it);
		int listings = mall_listing_count(it);

		boolean low_supply = (listings > 0 && listings <= 5);
		boolean big_gap = (auto > 0 && price > auto * 500);

		if (!low_supply && !big_gap) continue;

		print(
			it +
			" | price: " + price +
			" | autosell: " + auto +
			" | listings: " + listings,
			"green"
		);
	}

	print("=== Scan Complete ===", "blue");
}

