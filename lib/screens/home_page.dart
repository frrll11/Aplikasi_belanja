import 'dart:math';
import 'package:flutter/material.dart';

// ---------- Colors ----------
const kPurple = Color(0xFFFF62BB);
const kPurpleLight = Color(0xFFDCD3FA);
const kPurpleDark = Color(0xFF7C6BD6);
const kPink = Color(0xFFFF6F7F);
const kPinkLight = Color(0xFFFFB3BC);
const kGold = Color(0xFFF5C542);
const kTextDark = Color(0xFF3C3C4A);
const kTextGray = Color(0xFF8E8E9A);
const kStarOff = Color(0xFFE0E0E8);

// ---------- Model ----------
class Cake {
  final String name, type, category, desc1, desc2, emoji;
  final double price, rating;
  final bool recommended;
  final List<String> ingredients;
  // Isi path asset jika punya gambar, mis. 'assets/brownie.png'
  final String? image;

  const Cake({
    required this.name,
    required this.type,
    required this.category,
    required this.price,
    required this.rating,
    this.recommended = false,
    this.desc1 = '',
    this.desc2 = '',
    this.ingredients = const [],
    this.image,
    this.emoji = '🍰',
  });
}

// Emoji untuk tiap bahan (fallback: ✨)
const ingredientEmoji = <String, String>{
  'Sugar': '🍬',
  'Flour': '🌾',
  'Chocolate': '🍫',
  'Cream Cheese': '🧀',
  'Butter': '🧈',
  'Eggs': '🥚',
  'Milk': '🥛',
  'Strawberry': '🍓',
  'Cherry': '🍒',
  'Lemon': '🍋',
  'Carrot': '🥕',
  'Coffee': '☕',
  'Vanilla': '🌼',
  'Matcha': '🍵',
  'Almond': '🌰',
  'Caramel': '🍯',
  'Apple': '🍎',
  'Cocoa': '🍫',
  'Cream': '🍦',
  'Walnut': '🥜',
};

const cakes = <Cake>[
  // ---------------- CAKE ----------------
  Cake(
    name: 'Marble Brownie',
    type: 'Chocolate Cake',
    category: 'Cake',
    price: 9.89,
    rating: 3.5,
    recommended: true,
    desc1:
        'Creamy peanut butter with a pinch of sea salt swirled with sweet-tart strawberry jam.',
    desc2:
        "Forget that this flavor is dairy-free. It's as good as, if not better than, everything else we make.",
    ingredients: ['Sugar', 'Flour', 'Chocolate'],
    emoji: '🍫',
  ),
  Cake(
    name: 'Cheese Cake',
    type: 'Piece of Cake',
    category: 'Cake',
    price: 4.59,
    rating: 3,
    recommended: true,
    desc1:
        'Silky smooth New York style cheesecake on a buttery graham cracker crust.',
    desc2:
        'Topped with a light layer of fresh strawberry compote. Rich, creamy and never too sweet.',
    ingredients: ['Cream Cheese', 'Butter', 'Strawberry', 'Sugar'],
    emoji: '🍰',
  ),
  Cake(
    name: 'Pie Cake',
    type: 'Piece of Cake',
    category: 'Cake',
    price: 8.89,
    rating: 4,
    recommended: true,
    desc1:
        'A golden flaky crust filled with slow-cooked apples, cinnamon and a touch of brown sugar.',
    desc2:
        'Baked fresh every morning. Best enjoyed warm with a spoon of vanilla cream on the side.',
    ingredients: ['Apple', 'Butter', 'Flour', 'Sugar'],
    emoji: '🧁',
  ),
  Cake(
    name: 'Red Velvet',
    type: 'Layer Cake',
    category: 'Cake',
    price: 11.50,
    rating: 4.5,
    recommended: true,
    desc1:
        'Soft crimson sponge layers with a gentle hint of cocoa and a tangy buttermilk finish.',
    desc2:
        'Frosted generously with silky cream cheese icing. A true classic for every celebration.',
    ingredients: ['Flour', 'Cocoa', 'Cream Cheese', 'Sugar'],
    emoji: '❤️',
  ),
  Cake(
    name: 'Black Forest',
    type: 'Chocolate Cake',
    category: 'Cake',
    price: 10.25,
    rating: 4,
    desc1:
        'Moist chocolate sponge soaked in cherry syrup, layered with whipped cream and dark cherries.',
    desc2:
        'Finished with chocolate shavings on top. Deep, fruity and wonderfully indulgent.',
    ingredients: ['Chocolate', 'Cherry', 'Cream', 'Flour'],
    emoji: '🍒',
  ),
  Cake(
    name: 'Tiramisu Cake',
    type: 'Coffee Cake',
    category: 'Cake',
    price: 12.40,
    rating: 5,
    recommended: true,
    desc1:
        'Espresso-soaked sponge layered with mascarpone cream and dusted with bittersweet cocoa.',
    desc2:
        'Light, airy and perfectly balanced between bitter coffee and sweet cream.',
    ingredients: ['Coffee', 'Cream Cheese', 'Cocoa', 'Eggs'],
    emoji: '☕',
  ),
  Cake(
    name: 'Carrot Cake',
    type: 'Spiced Cake',
    category: 'Cake',
    price: 7.75,
    rating: 3.5,
    desc1:
        'Warm spiced cake packed with fresh grated carrots, crunchy walnuts and a hint of cinnamon.',
    desc2:
        'Topped with a thick layer of cream cheese frosting. Comforting in every bite.',
    ingredients: ['Carrot', 'Walnut', 'Flour', 'Cream Cheese'],
    emoji: '🥕',
  ),
  Cake(
    name: 'Lemon Drizzle',
    type: 'Citrus Cake',
    category: 'Cake',
    price: 6.20,
    rating: 4,
    desc1:
        'Light and zesty loaf cake soaked in a sharp, sweet lemon glaze.',
    desc2:
        'Bright, fresh and refreshing. Perfect with a cup of afternoon tea.',
    ingredients: ['Lemon', 'Butter', 'Sugar', 'Eggs'],
    emoji: '🍋',
  ),

  // ---------------- DESSERTS ----------------
  Cake(
    name: 'French Macarons',
    type: 'Box of 6',
    category: 'Desserts',
    price: 13.90,
    rating: 4.5,
    recommended: true,
    desc1:
        'Delicate almond meringue shells with a chewy center and smooth ganache filling.',
    desc2:
        'Six assorted flavors: vanilla, chocolate, strawberry, pistachio, coffee and caramel.',
    ingredients: ['Almond', 'Sugar', 'Eggs', 'Cream'],
    emoji: '🎂',
  ),
  Cake(
    name: 'Vanilla Cupcake',
    type: 'Single Piece',
    category: 'Desserts',
    price: 3.25,
    rating: 3.5,
    desc1:
        'Fluffy vanilla sponge topped with a swirl of buttercream and colorful sprinkles.',
    desc2: 'Small, sweet and just right for a quick treat.',
    ingredients: ['Vanilla', 'Butter', 'Flour', 'Sugar'],
    emoji: '🧁',
  ),
  Cake(
    name: 'Glazed Donut',
    type: 'Single Piece',
    category: 'Desserts',
    price: 2.50,
    rating: 4,
    desc1:
        'Pillowy soft yeast donut fried golden and coated in a shiny sugar glaze.',
    desc2: 'Made fresh every morning. Melts in your mouth.',
    ingredients: ['Flour', 'Sugar', 'Milk', 'Eggs'],
    emoji: '🍩',
  ),
  Cake(
    name: 'Caramel Pudding',
    type: 'Custard Dessert',
    category: 'Desserts',
    price: 4.10,
    rating: 4.5,
    recommended: true,
    desc1:
        'Silky egg custard crowned with a glossy, slightly bitter caramel sauce.',
    desc2: 'Served chilled. Smooth, wobbly and deeply satisfying.',
    ingredients: ['Milk', 'Eggs', 'Caramel', 'Sugar'],
    emoji: '🍮',
  ),
  Cake(
    name: 'Cream Puff',
    type: 'Box of 3',
    category: 'Desserts',
    price: 5.60,
    rating: 3.5,
    desc1:
        'Crisp choux pastry shells filled with vanilla custard cream.',
    desc2: 'Dusted with powdered sugar. Light as air.',
    ingredients: ['Flour', 'Butter', 'Vanilla', 'Cream'],
    emoji: '🥐',
  ),

  // ---------------- ICE CREAM ----------------
  Cake(
    name: 'Vanilla Scoop',
    type: 'Classic Ice Cream',
    category: 'Ice Cream',
    price: 3.80,
    rating: 4,
    recommended: true,
    desc1:
        'Old-fashioned vanilla bean ice cream churned slowly for a dense, creamy texture.',
    desc2: 'Simple, pure and always a favorite. Great on its own or with cake.',
    ingredients: ['Vanilla', 'Milk', 'Cream', 'Sugar'],
    emoji: '🍦',
  ),
  Cake(
    name: 'Choco Fudge Sundae',
    type: 'Sundae',
    category: 'Ice Cream',
    price: 6.50,
    rating: 4.5,
    desc1:
        'Three scoops of chocolate ice cream drowned in warm fudge sauce and whipped cream.',
    desc2: 'Topped with crushed walnuts and a bright red cherry.',
    ingredients: ['Chocolate', 'Cream', 'Walnut', 'Cherry'],
    emoji: '🍨',
  ),
  Cake(
    name: 'Strawberry Cone',
    type: 'Ice Cream Cone',
    category: 'Ice Cream',
    price: 3.95,
    rating: 3.5,
    desc1:
        'Fresh strawberry ice cream with real fruit pieces in a crunchy waffle cone.',
    desc2: 'Sweet, fruity and perfect on a hot day.',
    ingredients: ['Strawberry', 'Milk', 'Sugar', 'Cream'],
    emoji: '🍧',
  ),
  Cake(
    name: 'Matcha Gelato',
    type: 'Italian Gelato',
    category: 'Ice Cream',
    price: 5.20,
    rating: 4.5,
    desc1:
        'Smooth Italian-style gelato made with premium ceremonial grade matcha.',
    desc2: 'Earthy, slightly bitter and wonderfully creamy.',
    ingredients: ['Matcha', 'Milk', 'Sugar', 'Cream'],
    emoji: '🍵',
  ),
];

// ---------- Cart (state sederhana) ----------
final ValueNotifier<List<Cake>> cart = ValueNotifier<List<Cake>>([]);

void addToCart(Cake cake) => cart.value = [...cart.value, cake];

void removeFromCart(int index) {
  final list = [...cart.value]..removeAt(index);
  cart.value = list;
}

// ---------- Favorit ----------
final ValueNotifier<List<Cake>> favorites = ValueNotifier<List<Cake>>([]);

bool isFavorite(Cake cake) => favorites.value.any((c) => c.name == cake.name);

void toggleFavorite(Cake cake) {
  if (isFavorite(cake)) {
    favorites.value = favorites.value.where((c) => c.name != cake.name).toList();
  } else {
    favorites.value = [...favorites.value, cake];
  }
}

// ---------- Pesanan ----------
class Order {
  final List<Cake> items;
  final double total;
  final DateTime date;
  const Order({required this.items, required this.total, required this.date});
}

final ValueNotifier<List<Order>> orders = ValueNotifier<List<Order>>([]);

/// Ubah isi keranjang menjadi 1 pesanan, lalu kosongkan keranjang.
void checkout() {
  final items = cart.value;
  if (items.isEmpty) return;
  final total = items.fold<double>(0, (sum, c) => sum + c.price);
  orders.value = [
    ...orders.value,
    Order(items: List<Cake>.from(items), total: total, date: DateTime.now()),
  ];
  cart.value = [];
}

// ---------- Shared widgets ----------
class CakeImage extends StatelessWidget {
  final Cake cake;
  final double size;
  const CakeImage(this.cake, this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    if (cake.image != null) {
      return Image.asset(cake.image!, width: size, height: size);
    }
    return Text(cake.emoji, style: TextStyle(fontSize: size * 0.6));
  }
}

class Stars extends StatelessWidget {
  final double rating, size;
  const Stars(this.rating, {this.size = 14, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (i) => Icon(Icons.star, size: size, color: i < rating ? kGold : kStarOff),
      ),
    );
  }
}

class PriceText extends StatelessWidget {
  final double price;
  final bool big;
  const PriceText(this.price, {this.big = false, super.key});

  @override
  Widget build(BuildContext context) {
    final whole = price.floor();
    final cents = ((price - whole) * 100).round().toString().padLeft(2, '0');
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('\$ $whole',
            style: TextStyle(fontSize: big ? 28 : 16, color: kTextDark)),
        Padding(
          padding: EdgeInsets.only(top: big ? 2 : 0),
          child: Text(cents,
              style: TextStyle(fontSize: big ? 16 : 10, color: kTextDark)),
        ),
      ],
    );
  }
}

/// Ikon keranjang dengan badge jumlah item, bisa diklik ke CartPage.
class CartIcon extends StatelessWidget {
  final Color color;
  final double size;
  const CartIcon({super.key, required this.color, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const CartPage())),
      child: ValueListenableBuilder<List<Cake>>(
        valueListenable: cart,
        builder: (_, items, __) => Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(Icons.shopping_cart_outlined, color: color, size: size),
            if (items.isNotEmpty)
              Positioned(
                right: -6,
                top: -6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration:
                      const BoxDecoration(color: kPink, shape: BoxShape.circle),
                  child: Text('${items.length}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
//                      HOME PAGE
// =====================================================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tabs = const ['Recommended', 'Desserts', 'Ice Cream', 'Cake'];
  int selectedTab = 0;

  List<Cake> get filtered => selectedTab == 0
      ? cakes.where((c) => c.recommended).toList()
      : cakes.where((c) => c.category == tabs[selectedTab]).toList();

  List<Cake> get bestBuy {
    final list = [...filtered]..sort((a, b) => b.rating.compareTo(a.rating));
    return list;
  }

  void openDetail(Cake cake) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(cake: cake)));
  }

  @override
  Widget build(BuildContext context) {
    final items = filtered;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Cake World',
                            style: TextStyle(
                                color: kPink, fontSize: 28, fontWeight: FontWeight.w500)),
                        Icon(Icons.search, size: 20, color: kTextDark),
                      ],
                    ),
                  ),

                  // Tabs
                  SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: tabs.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 20),
                      itemBuilder: (_, i) => GestureDetector(
                        onTap: () => setState(() => selectedTab = i),
                        child: Column(
                          children: [
                            Text(
                              tabs[i],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight:
                                    i == selectedTab ? FontWeight.w500 : FontWeight.normal,
                                color: i == selectedTab ? kTextDark : kTextGray,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: i == selectedTab ? kPurpleDark : Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Carousel (berubah sesuai tab)
                  SizedBox(
                    height: 210,
                    child: ListView.separated(
                      key: ValueKey(selectedTab),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (_, i) => FeaturedCard(
                        cake: items[i],
                        onTap: () => openDetail(items[i]),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Best buy
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Best buy',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500, color: kTextDark)),
                  ),
                  const SizedBox(height: 12),
                  ...bestBuy.map((c) => BestBuyItem(cake: c, onTap: () => openDetail(c))),
                ],
              ),
            ),
          ),

          // Bottom nav
          const Positioned(left: 0, right: 0, bottom: 0, child: BottomNav()),
        ],
      ),
    );
  }
}

class FeaturedCard extends StatelessWidget {
  final Cake cake;
  final VoidCallback onTap;
  const FeaturedCard({super.key, required this.cake, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: kPurple,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // Ribbon
            Positioned(
              top: 18,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: const BoxDecoration(
                  color: kPink,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: const Text('MUST TRY',
                    style: TextStyle(
                        color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CakeImage(cake, 110),
              ),
            ),
            Positioned(
              left: 8,
              right: 8,
              bottom: 10,
              child: Text(
                cake.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'serif',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BestBuyItem extends StatelessWidget {
  final Cake cake;
  final VoidCallback onTap;
  const BestBuyItem({super.key, required this.cake, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: Row(
          children: [
            Container(
              width: 62,
              height: 62,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFF9E6A8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: CakeImage(cake, 52),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cake.name, style: const TextStyle(fontSize: 13, color: kTextDark)),
                  Text(cake.type, style: const TextStyle(fontSize: 9, color: kTextGray)),
                  const SizedBox(height: 4),
                  Stars(cake.rating, size: 12),
                ],
              ),
            ),
            PriceText(cake.price),
          ],
        ),
      ),
    );
  }
}

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 18, bottom: 18 + MediaQuery.of(context).padding.bottom),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 16)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(Icons.home, color: kPurpleDark, size: 24),
          const CartIcon(color: kTextGray),
          // Ikon person = buka halaman Profile
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/profile'),
            child: const Icon(Icons.person_outline, color: kTextGray, size: 24),
          ),
        ],
      ),
    );
  }
}

// =====================================================
//                     DETAIL PAGE
// =====================================================
class DetailPage extends StatefulWidget {
  final Cake cake;
  const DetailPage({super.key, required this.cake});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final cake = widget.cake;

    return Scaffold(
      body: Stack(
        children: [
          // Purple header background
          Container(
            height: 340,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [kPurple, Color(0xFFB9A4FB)],
              ),
            ),
          ),

          SingleChildScrollView(
            child: Column(
              children: [
                // Top bar
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back_ios_new,
                              color: Colors.white, size: 20),
                        ),
                        const CartIcon(color: Colors.white, size: 22),
                      ],
                    ),
                  ),
                ),

                // Image + title
                SizedBox(
                  height: 230,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CakeImage(cake, 130),
                      const SizedBox(height: 6),
                      Text(
                        cake.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontFamily: 'serif',
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        cake.type,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontFamily: 'serif',
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),

                // White sheet
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(24, 36, 24, 120),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stars(cake.rating),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CustomPaint(
                                      size: const Size(90, 16), painter: BarcodePainter()),
                                  Text(cake.name.toUpperCase().replaceAll(' ', ''),
                                      style: const TextStyle(
                                          fontSize: 5, letterSpacing: 1, color: kTextGray)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const Text('All That Is Beautiful.',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: kTextDark)),
                          const SizedBox(height: 6),
                          Text(cake.desc1,
                              style: const TextStyle(
                                  fontSize: 10, height: 1.5, color: kTextGray)),
                          const SizedBox(height: 10),
                          Text(cake.desc2,
                              style: const TextStyle(
                                  fontSize: 10, height: 1.5, color: kTextGray)),
                          const SizedBox(height: 24),
                          const Text('INGREDIENTS',
                              style: TextStyle(fontSize: 11, color: kTextDark)),
                          const SizedBox(height: 10),
                          Wrap(
                            runSpacing: 10,
                            children: cake.ingredients
                                .map((e) => IngredientChip(label: e))
                                .toList(),
                          ),
                        ],
                      ),
                    ),

                    // Heart button
                    Positioned(
                      top: -24,
                      left: 24,
                      child: GestureDetector(
                        onTap: () => setState(() => toggleFavorite(cake)),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
                          ),
                          child: Icon(Icons.favorite,
                              color: isFavorite(cake) ? kPink : kPinkLight, size: 24),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Bottom bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  24, 16, 24, 16 + MediaQuery.of(context).padding.bottom),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 16)],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PriceText(cake.price, big: true),
                  ElevatedButton(
                    onPressed: () {
                      addToCart(cake);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${cake.name} ditambahkan')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPink,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text('Add item',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IngredientChip extends StatelessWidget {
  final String label;
  const IngredientChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          Container(
            width: 52,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: kPurpleLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(ingredientEmoji[label] ?? '✨',
                style: const TextStyle(fontSize: 22)),
          ),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 8, color: kTextGray)),
        ],
      ),
    );
  }
}

class BarcodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rnd = Random(7);
    double x = 0;
    while (x < size.width) {
      final w = (rnd.nextInt(3) + 1).toDouble();
      canvas.drawRect(Rect.fromLTWH(x, 0, w, size.height), Paint()..color = kTextDark);
      x += w + rnd.nextInt(3) + 1;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =====================================================
//                      CART PAGE
// =====================================================
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: kTextDark),
        title: const Text('Keranjang',
            style: TextStyle(color: kPink, fontWeight: FontWeight.w500)),
      ),
      body: ValueListenableBuilder<List<Cake>>(
        valueListenable: cart,
        builder: (context, items, _) {
          if (items.isEmpty) {
            return const Center(
              child: Text('Keranjang masih kosong',
                  style: TextStyle(color: kTextGray)),
            );
          }
          final total = items.fold<double>(0, (sum, c) => sum + c.price);
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: items.length,
                  itemBuilder: (_, i) {
                    final c = items[i];
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: kPurpleLight,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: CakeImage(c, 48),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(c.name,
                                    style: const TextStyle(
                                        fontSize: 13, color: kTextDark)),
                                Text(c.type,
                                    style: const TextStyle(
                                        fontSize: 9, color: kTextGray)),
                              ],
                            ),
                          ),
                          PriceText(c.price),
                          IconButton(
                            icon: const Icon(Icons.close,
                                size: 18, color: kTextGray),
                            onPressed: () => removeFromCart(i),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    24, 16, 24, 16 + MediaQuery.of(context).padding.bottom),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 16)],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total',
                            style: TextStyle(fontSize: 11, color: kTextGray)),
                        PriceText(total, big: true),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        checkout();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Pesanan berhasil dibuat')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPink,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text('Checkout',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}