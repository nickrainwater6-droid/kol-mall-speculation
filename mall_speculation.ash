// mall_search.ash
// Usage: call mall_search.ash item name here

void main(string searchTerm)
{
    if (searchTerm == "")
    {
        print("Please provide an item name.", "red");
        return;
    }

    print("Searching the Mall for: " + searchTerm, "blue");

    // Search up to 50 results (KoLmafia limit is usually 50–100)
    record mallResult {
        int price;
        int quantity;
        string shop;
    };

    mallResult [int] results;

    int count = mall_search(results, searchTerm, 50);

    if (count == 0)
    {
        print("No results found.", "red");
        return;
    }

    // Sort results by price ascending
    sort results by value.price;

    print("Found " + count + " result(s):", "green");

    foreach i, r in results
    {
        string priceStr = r.price.to_string();
        string qtyStr   = r.quantity.to_string();

        print(
            "Price: " + priceStr + " meat | " +
            "Qty: " + qtyStr + " | " +
            "Shop: " + r.shop,
            "black"
        );
    }
}
