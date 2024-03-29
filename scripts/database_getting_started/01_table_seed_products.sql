/*
    Intended for testing purpose
*/


-- Table Products 
-- DROP TABLE products

create table public.products (
    id bigint generated by default as identity not null primary key,
    code text null,
    name text null,
    description text null,
    image text null,
    path text null,
    price text null,
    category text null,
    quantity text null,
    inventory_status text null,
    rating text null
  );

-- seed
INSERT INTO "products" (id, code, name, description, image, path, price, category, quantity, inventory_status, rating) VALUES
	('1000', 'f230fh0g3', 'Bamboo Watch', 'Product Description', 'bamboo-watch.jpg', 'product', '65', 'Accessories', '24', 'INSTOCK', '5'),
	('1001', 'nvklal433', 'Black Watch', 'Product Description', 'black-watch.jpg', 'product', '72', 'Accessories', '61', 'INSTOCK', '4'),
	('1002', 'zz21cz3c1', 'Blue Band', 'Product Description', 'blue-band.jpg', 'product', '79', 'Fitness', '2', 'LOWSTOCK', '3'),
	('1003', '244wgerg2', 'Blue T-Shirt', 'Product Description', 'blue-t-shirt.jpg', 'product', '29', 'Clothing', '25', 'INSTOCK', '5'),
	('1004', 'h456wer53', 'Bracelet', 'Product Description', 'bracelet.jpg', 'product', '15', 'Accessories', '73', 'INSTOCK', '4'),
	('1005', 'av2231fwg', 'Brown Purse', 'Product Description', 'brown-purse.jpg', 'product', '120', 'Accessories', '', 'OUTOFSTOCK', '4'),
	('1006', 'bib36pfvm', 'Chakra Bracelet', 'Product Description', 'chakra-bracelet.jpg', 'product', '32', 'Accessories', '5', 'LOWSTOCK', '3'),
	('1007', 'mbvjkgip5', 'Galaxy Earrings', 'Product Description', 'galaxy-earrings.jpg', 'product', '34', 'Accessories', '23', 'INSTOCK', '5'),
	('1008', 'vbb124btr', 'Game Controller', 'Product Description', 'game-controller.jpg', 'product', '99', 'Electronics', '2', 'LOWSTOCK', '4'),
	('1009', 'cm230f032', 'Gaming Set', 'Product Description', 'gaming-set.jpg', 'product', '299', 'Electronics', '63', 'INSTOCK', '3'),
	('1010', 'plb34234v', 'Gold Phone Case', 'Product Description', 'gold-phone-case.jpg', 'product', '24', 'Accessories', '', 'OUTOFSTOCK', '4'),
	('1011', '4920nnc2d', 'Green Earbuds', 'Product Description', 'green-earbuds.jpg', 'product', '89', 'Electronics', '23', 'INSTOCK', '4'),
	('1012', '250vm23cc', 'Green T-Shirt', 'Product Description', 'green-t-shirt.jpg', 'product', '49', 'Clothing', '74', 'INSTOCK', '5'),
	('1013', 'fldsmn31b', 'Grey T-Shirt', 'Product Description', 'grey-t-shirt.jpg', 'product', '48', 'Clothing', '', 'OUTOFSTOCK', '3'),
	('1014', 'waas1x2as', 'Headphones', 'Product Description', 'headphones.jpg', 'product', '175', 'Electronics', '8', 'LOWSTOCK', '5'),
	('1015', 'vb34btbg5', 'Light Green T-Shirt', 'Product Description', 'light-green-t-shirt.jpg', 'product', '49', 'Clothing', '34', 'INSTOCK', '4'),
	('1016', 'k8l6j58jl', 'Lime Band', 'Product Description', 'lime-band.jpg', 'product', '79', 'Fitness', '12', 'INSTOCK', '3'),
	('1017', 'v435nn85n', 'Mini Speakers', 'Product Description', 'mini-speakers.jpg', 'product', '85', 'Clothing', '42', 'INSTOCK', '4'),
	('1018', '09zx9c0zc', 'Painted Phone Case', 'Product Description', 'painted-phone-case.jpg', 'product', '56', 'Accessories', '41', 'INSTOCK', '5'),
	('1019', 'mnb5mb2m5', 'Pink Band', 'Product Description', 'pink-band.jpg', 'product', '79', 'Fitness', '63', 'INSTOCK', '4'),
	('1020', 'r23fwf2w3', 'Pink Purse', 'Product Description', 'pink-purse.jpg', 'product', '110', 'Accessories', '', 'OUTOFSTOCK', '4'),
	('1021', 'pxpzczo23', 'Purple Band', 'Product Description', 'purple-band.jpg', 'product', '79', 'Fitness', '6', 'LOWSTOCK', '3'),
	('1022', '2c42cb5cb', 'Purple Gemstone Necklace', 'Product Description', 'purple-gemstone-necklace.jpg', 'product', '45', 'Accessories', '62', 'INSTOCK', '4'),
	('1023', '5k43kkk23', 'Purple T-Shirt', 'Product Description', 'purple-t-shirt.jpg', 'product', '49', 'Clothing', '2', 'LOWSTOCK', '5'),
	('1024', 'lm2tny2k4', 'Shoes', 'Product Description', 'shoes.jpg', 'product', '64', 'Clothing', '', 'INSTOCK', '4'),
	('1025', 'nbm5mv45n', 'Sneakers', 'Product Description', 'sneakers.jpg', 'product', '78', 'Clothing', '52', 'INSTOCK', '4'),
	('1026', 'zx23zc42c', 'Teal T-Shirt', 'Product Description', 'teal-t-shirt.jpg', 'product', '49', 'Clothing', '3', 'LOWSTOCK', '3'),
	('1027', 'acvx872gc', 'Yellow Earbuds', 'Product Description', 'yellow-earbuds.jpg', 'product', '89', 'Electronics', '35', 'INSTOCK', '3'),
	('1028', 'tx125ck42', 'Yoga Mat', 'Product Description', 'yoga-mat.jpg', 'product', '20', 'Fitness', '15', 'INSTOCK', '5'),
	('1029', 'gwuby345v', 'Yoga Set', 'Product Description', 'yoga-set.jpg', 'product', '20', 'Fitness', '25', 'INSTOCK', '8');


alter table products enable row level security;
create policy "Everybody can read products. " on products for select using (true);



-- Product Deals
CREATE  TABLE public.product_deals
(
    id int generated by default as identity primary key,
		product_id bigint references public.products,
    deals	text
);

-- seed
INSERT INTO public.product_deals (product_id, deals) 
VALUES('1000', 'flash_deals'),
('1001', 'flash_deals'),
('1002', 'flash_deals'),
('1003', 'flash_deals'),
('1004', 'flash_deals'),
('1005', 'flash_deals'),
('1006', 'flash_deals'),
('1007', 'flash_deals'),
('1008', 'flash_deals'),
('1009', 'flash_deals'),
('1010', 'flash_deals'),
('1011', 'flash_deals'),
('1012', 'flash_deals'),
('1013', 'flash_deals'),
('1014', 'flash_deals'),
('1015', 'flash_deals'),
('1016', 'flash_deals'),
('1017', 'flash_deals'),
('1018', 'flash_deals'),
('1019', 'flash_deals'),
('1020', 'hot_deals'),
('1021', 'hot_deals'),
('1022', 'hot_deals'),
('1023', 'hot_deals'),
('1024', 'hot_deals'),
('1025', 'hot_deals'),
('1026', 'hot_deals'),
('1027', 'hot_deals'),
('1028', 'hot_deals'),
('1029', 'hot_deals');


alter table product_deals enable row level security;
create policy "Everybody can read product_deals. " on product_deals for select using (true);