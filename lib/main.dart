import 'package:flutter/material.dart';

// --- 1. Mock Data and Models ---

/// Model for a menu item, including category and optional image URL.
class MenuItem {
  final int id;
  final String name;
  final String description;
  final double price;
  final IconData icon; // Used as a fallback icon if no image URL is provided
  final String category; // 'tea', 'coffee', 'snacks'
  final String? imageUrl; // Network URL or filename placeholder

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
    required this.category,
    this.imageUrl, // Optional
  });
}

// All Menu Data (Working Cards content)
final List<MenuItem> allMenuItems = [
  // TEA MENU (Classic Boba uses the live image URL)
  MenuItem(id: 1, name: 'Classic Boba', description: 'Chewy pearls in a creamy, sweet black milk tea. Our bestseller!', price: 55.50, icon: Icons.bubble_chart, category: 'tea', imageUrl: 'https://raw.githubusercontent.com/misuuwu/funtea_assets/refs/heads/main/bubbletea.png'),
  MenuItem(id: 2, name: 'Matcha Latte', description: 'Smooth, vibrant green tea with steamed milk. Energizing.', price: 119.00, icon: Icons.local_drink, category: 'coffee', imageUrl: 'https://raw.githubusercontent.com/misuuwu/funtea_assets/refs/heads/main/macha.png'),
  MenuItem(id: 3, name: 'Taro Milk Tea', description: 'Sweet, nutty taro flavor with a beautiful purple hue. Unique and creamy.', price: 110.75, icon: Icons.opacity, category: 'tea', imageUrl: 'https://raw.githubusercontent.com/misuuwu/funtea_assets/refs/heads/main/taro.png'),
  MenuItem(id: 4, name: 'Jasmine Green Tea', description: 'Light and fragrant green tea, served hot or iced. Perfect palate cleanser.', price: 95.50, icon: Icons.eco, category: 'tea', imageUrl: 'https://raw.githubusercontent.com/misuuwu/funtea_assets/refs/heads/main/jasmine.png'),

  // COFFEE & ESPRESSO
  MenuItem(id: 5, name: 'Americano', description: 'Bold espresso diluted with hot water. Simple and strong.', price: 120.00, icon: Icons.coffee_maker, category: 'coffee', imageUrl: 'https://raw.githubusercontent.com/misuuwu/funtea_assets/refs/heads/main/americano.png'),
  MenuItem(id: 6, name: 'Caramel Macchiato', description: 'Vanilla syrup, milk, espresso shots, and caramel drizzle.', price: 112.50, icon: Icons.local_bar, category: 'coffee', imageUrl: 'https://raw.githubusercontent.com/misuuwu/funtea_assets/refs/heads/main/macchiato.png'),
  MenuItem(id: 7, name: 'Cold Brew', description: 'Coffee steeped in cold water for 12 hours. Smooth and low acidity.', price: 115.25, icon: Icons.icecream, category: 'coffee', imageUrl: 'https://raw.githubusercontent.com/misuuwu/funtea_assets/refs/heads/main/coldbrew.png'),
  MenuItem(id: 10, name: 'Chai Latte', description: 'Spiced black tea concentrate mixed with steamed milk.', price: 123.80, icon: Icons.local_bar, category: 'coffee', imageUrl: 'https://raw.githubusercontent.com/misuuwu/funtea_assets/refs/heads/main/chai.png'),

  // SNACKS & PASTRIES
  MenuItem(id: 8, name: 'Chocolate Croissant', description: 'Flaky pastry with a rich, dark chocolate center. Baked fresh daily.', price: 50.75, icon: Icons.cookie, category: 'snacks', imageUrl: 'https://raw.githubusercontent.com/misuuwu/funtea_assets/refs/heads/main/croissant.png'),
  MenuItem(id: 9, name: 'Matcha Muffin', description: 'A moist, light muffin infused with premium matcha powder.', price: 60.25, icon: Icons.donut_large, category: 'snacks', imageUrl: 'https://raw.githubusercontent.com/misuuwu/funtea_assets/refs/heads/main/muffin.png'),
  MenuItem(id: 11, name: 'Almond Biscotti', description: 'Crispy Italian biscuits, perfect for dipping in coffee or tea.', price: 40.50, icon: Icons.fastfood, category: 'snacks', imageUrl: 'https://raw.githubusercontent.com/misuuwu/funtea_assets/refs/heads/main/biscotti.png'),
];

/// Model and Data for the 5 Options (Sidebar)
class NavigationOption {
  final String id;
  final String name;
  final IconData icon;

  NavigationOption({required this.id, required this.name, required this.icon});
}

final List<NavigationOption> sidebarOptions = [
  NavigationOption(id: 'home', name: 'Home', icon: Icons.home_filled),
  NavigationOption(id: 'tea', name: 'Tea Menu', icon: Icons.emoji_food_beverage),
  NavigationOption(id: 'coffee', name: 'Coffee & Espresso', icon: Icons.local_cafe_outlined),
  NavigationOption(id: 'snacks', name: 'Snacks & Pastries', icon: Icons.cake),
  NavigationOption(id: 'account', name: 'My Account', icon: Icons.person),
];

// Mock Order History Data
final List<Map<String, dynamic>> mockOrders = [
  {'date': '2024-10-15', 'item': 'Classic Boba', 'total': 4.50},
  {'date': '2024-10-14', 'item': 'Matcha Muffin', 'total': 3.25},
  {'date': '2024-10-10', 'item': 'Caramel Macchiato', 'total': 5.50},
];


// --- 2. Stateless Web App (Coffee shop App) ---
class FunteaApp extends StatelessWidget {
  const FunteaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Funtea',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // NEW PRIMARY COLOR: Starbucks Green (Deep Green)
        primarySwatch: Colors.green,
        // Using a modern, clean font aesthetic
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
          // CHANGED: App Bar background to deep forest green
          backgroundColor: Colors.green.shade900,
          // CHANGED: App Bar foreground (icons/text) to white for contrast
          foregroundColor: Colors.white,
          elevation: 1,
        ),
        useMaterial3: true,
      ),
      home: const FunteaHomePage(),
    );
  }
}

// Main screen which handles state and responsiveness
class FunteaHomePage extends StatefulWidget {
  const FunteaHomePage({super.key});

  @override
  State<FunteaHomePage> createState() => _FunteaHomePageState();
}

class _FunteaHomePageState extends State<FunteaHomePage> {
  String _currentPage = 'home';
  int _cartCount = 0; // State for shopping cart count
  double _maxPrice = 6.0; // State for price filter, max value of any item is 5.50
  String _sortCriteria = 'name_asc'; // State for sorting: 'name_asc', 'price_asc', 'price_desc'
  static const double _desktopBreakpoint = 800; // Define when to switch to desktop layout

  // Define new accent color for buttons and highlights
  final Color _accentGreen = Colors.lightGreen.shade600;
  final Color _primaryGreen = Colors.green.shade800;


  String _getPageTitle() {
    return sidebarOptions.firstWhere((opt) => opt.id == _currentPage).name;
  }

  void _selectPage(String pageId) {
    setState(() {
      _currentPage = pageId;
    });
    // For mobile, ensure the drawer is closed after selection
    if (MediaQuery.of(context).size.width < _desktopBreakpoint) {
      Navigator.of(context).pop();
    }
  }

  void _addToCart(String itemName) {
    setState(() {
      _cartCount++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$itemName added to cart!'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // --- 3. Sidebar/Drawer Content Widget (Reusable) ---

  // Cart icon widget to show the count
  Widget _buildCartIcon({Color? color}) {
    return Stack(
      children: [
        // Updated cart icon color
        Icon(Icons.shopping_cart, color: color ?? _primaryGreen),
        if (_cartCount > 0)
          Positioned(
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: const BoxConstraints(
                minWidth: 14,
                minHeight: 14,
              ),
              child: Text(
                '$_cartCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
      ],
    );
  }

  Widget _buildDrawerContent({required bool isDrawer}) {
    return Container(
      width: isDrawer ? null : 250, // Fixed width for permanent sidebar
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Funtea Logo/Title
          Padding(
            padding: const EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Funtea',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    // Updated logo color
                    color: _primaryGreen,
                  ),
                ),
                // Show Cart Icon on Desktop sidebar
                if (!isDrawer)
                  IconButton(
                    icon: _buildCartIcon(color: _primaryGreen),
                    onPressed: () {
                      // Handle cart navigation
                    },
                  ),
              ],
            ),
          ),
          const Divider(indent: 16, endIndent: 16),
          // 5 OPTIONS
          ...sidebarOptions.map((option) {
            final isActive = option.id == _currentPage;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                leading: Icon(
                  option.icon,
                  color: isActive ? Colors.white : Colors.grey.shade700,
                ),
                title: Text(
                  option.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isActive ? Colors.white : Colors.grey.shade800,
                  ),
                ),
                // Updated active tile color
                tileColor: isActive ? _accentGreen : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                onTap: () => _selectPage(option.id),
              ),
            );
          }).toList(),
          const Spacer(),
          // Footer
          if (!isDrawer)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '© 2025 Funtea App',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }

  // --- 4. Working Cards Component (Menu Item Card) ---
  Widget _buildMenuItemCard(MenuItem item) {
    // Determine if the URL is a real network link or just a placeholder filename
    final bool isNetworkImage = item.imageUrl != null && item.imageUrl!.startsWith('http');

    Widget imageWidget;
    if (isNetworkImage) {
      // Load the image from the network URL
      imageWidget = ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(
          item.imageUrl!,
          fit: BoxFit.cover,
          height: 120,
          width: double.infinity,
          // Placeholder and error handling for network image
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: 120,
              color: Colors.grey.shade200,
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                      : null,
                  // Updated loading color
                  color: Colors.green,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 120,
              color: Colors.red.shade100,
              child: const Center(
                child: Icon(Icons.broken_image, color: Colors.red, size: 40),
              ),
            );
          },
        ),
      );
    } else {
      // Use the placeholder logic for items without a proper URL
      imageWidget = Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey.shade100, // Background color for the placeholder
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey.shade300)
        ),
        child: Center(
          child: item.imageUrl != null
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.image_outlined, color: Colors.grey.shade500, size: 30),
              const SizedBox(height: 5),
              Text(
                'Image: ${item.imageUrl}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontStyle: FontStyle.italic, fontSize: 12),
              ),
            ],
          )
              : Icon(
            item.icon,
            // Updated placeholder icon color
            color: Colors.green.shade400,
            size: 48,
          ),
        ),
      );
    }

    return Card(
      elevation: 8,
      // Updated shadow color
      shadowColor: Colors.green.shade50.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Display the determined image widget (Network Image or Placeholder)
            imageWidget,
            const SizedBox(height: 12),
            Text(
              item.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            // The description text is constrained to maxLines to help prevent overflow
            Text(
              item.description,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₱${item.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    // Updated price text color
                    color: _accentGreen,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _addToCart(item.name), // Use the new function to update the cart count
                  style: ElevatedButton.styleFrom(
                    // Updated button color
                    backgroundColor: _accentGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    elevation: 5,
                  ),
                  child: const Text('Add to Cart', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- NEW: Account Content Builder ---
  Widget _buildAccountContent(double screenWidth) {
    // Mock user data (since we aren't using Firebase Auth yet)
    const String mockUserId = 'user-funtea-101';
    const String mockUserName = 'Funtea Fan';

    // Check if the screen is considered small/mobile (width less than desktop breakpoint)
    final bool isSmallScreen = screenWidth < _desktopBreakpoint;

    // Helper widget for section headers
    Widget _sectionHeader(String title) {
      return Padding(
        padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: _primaryGreen,
          ),
        ),
      );
    }

    return Padding(
      // Reduced horizontal padding for small screens to give more space
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12.0 : 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Profile & Settings
          _sectionHeader('Profile & Settings'),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.lightGreen,
                    child: Icon(Icons.person_outline, size: 40, color: Colors.white),
                  ),
                  const SizedBox(width: 20),

                  // START FIX HERE: Ensure the Column takes full available space and aligns content left
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // **THIS IS THE CRITICAL FIX**
                      children: [
                        Text(
                          mockUserName,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis, // Ensure name doesn't break vertically if it's too long horizontally
                          maxLines: 1, // Keep the name on a single line if possible
                        ),
                        const SizedBox(height: 4),
                        // The ID text is also constrained to prevent breaking
                        Text(
                          'User ID: $mockUserId',
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // END FIX

                  const SizedBox(width: 10), // Add a small gap before the button

                  // FIX 1: Use IconButton on small screens to prevent overflow
                  if (isSmallScreen)
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit, size: 28, color: Colors.white),
                      style: IconButton.styleFrom(
                        backgroundColor: _accentGreen,
                      ),
                    )
                  else
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit, size: 20),
                      label: const Text('Edit Profile'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _accentGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // 2. Loyalty & Rewards
          _sectionHeader('Funtea Rewards'),
          Card(
            elevation: 4,
            color: Colors.green.shade50,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // FIX 2: Wrap the text Column in Expanded to allow it to shrink
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Current Stars Balance',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '50', // Mock data
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w900,
                            color: _primaryGreen,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'You are a Bronze Member',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.star, size: 60, color: Colors.amber.shade400),
                ],
              ),
            ),
          ),

          // 3. Order History
          _sectionHeader('Recent Orders (₱)'),
          ...mockOrders.map((order) {
            return Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(Icons.receipt_long, color: _accentGreen),
                title: Text(order['item']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Order Date: ${order['date']}'),
                trailing: Text(
                  '₱${order['total'].toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: _primaryGreen),
                ),
                onTap: () {
                  // Action to view detailed order
                },
              ),
            );
          }).toList(),

          // Bottom Spacer
          const SizedBox(height: 50),
        ],
      ),
    );
  }


  // Conditional Main Content based on selected page
  Widget _buildMainContent() {
    Widget content;

    // Determine which items to display
    final bool isCardsView = ['home', 'tea', 'coffee', 'snacks'].contains(_currentPage);
    final double screenWidth = MediaQuery.of(context).size.width;

    if (_currentPage == 'account') {
      content = _buildAccountContent(screenWidth);
    } else if (isCardsView) {
      // 1. Filter items based on the current page category and price filter
      List<MenuItem> visibleItems = (_currentPage == 'home')
          ? allMenuItems.where((item) => item.category == 'tea' && item.price <= _maxPrice).toList() // Show only Tea on Home, filtered by price
          : allMenuItems.where((item) => item.category == _currentPage && item.price <= _maxPrice).toList(); // Show items for selected category, filtered by price

      // 2. Apply Sorting Logic
      visibleItems.sort((a, b) {
        if (_sortCriteria == 'name_asc') {
          return a.name.compareTo(b.name);
        } else if (_sortCriteria == 'price_asc') {
          return a.price.compareTo(b.price);
        } else if (_sortCriteria == 'price_desc') {
          return b.price.compareTo(a.price);
        }
        return 0; // Default: no change
      });


      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Home Feature Banner (Updated to a complementary color)
          if (_currentPage == 'home')
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                // NEW BANNER COLORS (Using Cyan/Teal as a good contrast to the primary green)
                color: Colors.cyan.shade50,
                border: Border(left: BorderSide(color: Colors.cyan.shade600, width: 6)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Featured Today!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.cyan.shade800)),
                  const SizedBox(height: 6),
                  Text('Get 15% off all Boba drinks for a limited time. Don\'t miss out!', style: TextStyle(color: Colors.cyan.shade700)),
                ],
              ),
            ),

          Text(
              _currentPage == 'home' ? 'Today\'s Top Tea Selections' : 'All ${_getPageTitle()}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.grey.shade700)),
          const SizedBox(height: 20),

          // --- FILTER AND SORT CONTROLS CONTAINER ---
          if (isCardsView)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price Filter Row
                  Text(
                    'Filter by Price: Max ₱${_maxPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _primaryGreen),
                  ),
                  Slider(
                    value: _maxPrice,
                    min: 2.0, // Minimum price of any item
                    max: 200.0, // Maximum price to filter by
                    divisions: 80, // For smooth price steps (0.05 increments)
                    label: '₱${_maxPrice.toStringAsFixed(2)}',
                    onChanged: (double newValue) {
                      setState(() {
                        _maxPrice = newValue;
                      });
                    },
                    // Updated slider active/inactive colors
                    activeColor: _accentGreen,
                    inactiveColor: Colors.lightGreen.shade100,
                  ),
                  const SizedBox(height: 15), // Vertical space between filter and sort

                  // Sort Dropdown Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Updated Sort text color
                      Text('Sort by:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _primaryGreen)),

                      // FIX 3: Wrap DropdownButton in Flexible to prevent overflow
                      Flexible(
                        child: DropdownButton<String>(
                          value: _sortCriteria,
                          // Updated sort icon color
                          icon: Icon(Icons.sort, color: _accentGreen),
                          elevation: 16,
                          style: TextStyle(color: _primaryGreen, fontWeight: FontWeight.bold, fontSize: 16),
                          underline: Container(
                            height: 2,
                            // Updated underline color
                            color: Colors.lightGreen.shade200,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              _sortCriteria = newValue!;
                            });
                          },
                          items: <Map<String, String>>[
                            {'value': 'name_asc', 'text': 'Name (A-Z)'},
                            {'value': 'price_asc', 'text': 'Price (Low to High)'},
                            {'value': 'price_desc', 'text': 'Price (High to Low)'},
                          ].map<DropdownMenuItem<String>>((Map<String, String> option) {
                            return DropdownMenuItem<String>(
                              value: option['value'],
                              child: Text(option['text']!),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Showing ${visibleItems.length} items',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  )
                ],
              ),
            ),
          const SizedBox(height: 25),

          // Working Cards GridView
          visibleItems.isEmpty
              ? Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text(
                'No menu items found below ₱${_maxPrice.toStringAsFixed(2)} for this category.',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade500),
              ),
            ),
          )
              : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 380, // Max width of a card
              childAspectRatio: 0.8,
              crossAxisSpacing: 25,
              mainAxisSpacing: 25,
            ),
            itemCount: visibleItems.length,
            itemBuilder: (context, index) {
              return _buildMenuItemCard(visibleItems[index]);
            },
          ),
        ],
      );
    } else {
      // Fallback content - should be caught by _buildAccountContent
      content = Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Text(
            'Welcome to the ${_getPageTitle()} section!',
            style: const TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Page Title
          Text(
            _getPageTitle(),
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 30),
          content,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= _desktopBreakpoint;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      // App Bar (Visible on mobile/tablet)
      appBar: isDesktop
          ? null
          : AppBar(
        // Explicitly set text color to white for contrast on the dark App Bar
        title: const Text('Funtea', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
        actions: [
          // Cart Icon on Mobile AppBar
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              // Pass white color for visibility on the dark AppBar
              icon: _buildCartIcon(color: Colors.white),
              onPressed: () {
                // Handle cart navigation
              },
            ),
          )
        ],
      ),

      // Drawer (Sidebar on mobile/tablet)
      drawer: isDesktop
          ? null
          : Drawer(
        child: _buildDrawerContent(isDrawer: true),
      ),

      body: isDesktop
          ? Row(
        children: [
          // Permanent Sidebar for Desktop View
          _buildDrawerContent(isDrawer: false),
          const VerticalDivider(width: 1, thickness: 1, color: Colors.grey),
          // Main Content Area
          Expanded(child: _buildMainContent()),
        ],
      )
          : // Mobile/Tablet View (uses AppBar and Drawer)
      _buildMainContent(),
    );
  }
}

void main() {
  runApp(const FunteaApp());
}
