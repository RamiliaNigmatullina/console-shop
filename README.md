# Console Shop

Console Shop is a console-based application tailored for purchasing products while offering the added advantage of promotional discounts. This app features exclusive deals on items, including 'Buy One, Get One Free' (BOGO) and bulk purchase discounts for orders of three or more products

## Requirements

- Ruby version 3.3.0

## Getting Started

1. Clone the repository:

```bash
git clone git@github.com:RamiliaNigmatullina/console-shop.git && cd console-shop
```

2. Run the setup script:
```bash
bin/setup
```

## Usage
To start shopping, open your terminal, navigate to the application directory, and run:

```bash
bin/shop_cli
```

Upon starting, a list of available products will be displayed along with a prompt to enter the codes of the products you wish to purchase, separated by commas. Enter the codes and press Enter. The total amount, considering all discounts, will be displayed in the console.

## Testing
To run the tests, use the command:

```bash
bin/rspec
```

## Existing Promotions Descriptions
* BOGO (Buy One Get One): This promotion is customizable, allowing you to specify how many items must be purchased (the `buy` field in `Promotion`) to receive a certain number of items for free (the `get` field in `Promotion`). For example, for a Buy One Get One promotion, both `buy` and `get` would be set to one.
* Bulk Discount: When a certain quantity of a product is purchased, all items are sold at a discount:
  * all items at a fixed price (e.g. "4.50€"), or
  * a percentage discount is applied to them (e.g. 66.66%).

## Additional Comments
  * To simplify the logic, the money gem for handling monetary values was not used in the application.
  * Each product can only participate in one promotion. If multiple promotions apply to a product, only the first one is applied. This behavior is designed for simplicity but can be easily modified to evaluate multiple promotions and apply the most beneficial one.
