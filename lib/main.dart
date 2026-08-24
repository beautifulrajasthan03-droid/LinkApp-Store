import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(),
    );
  }
}

class AnimatedSplashScreen extends StatefulWidget {
  @override
  _AnimatedSplashScreenState createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainHomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bolt, size: 100, color: Colors.amber),
            SizedBox(height: 20),
            Text(
              "LinkApp Store",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "By Govind Kumar Beragi",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;
  String currentUsername = "Govind";
  List<String> cartItems = [];

  void _showMobileLoginDialog(BuildContext context) {
    TextEditingController phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login with Mobile Number"),
          content: TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            decoration: InputDecoration(
              labelText: 'Enter 10-digit mobile number',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
              child: Text("Login", style: TextStyle(color: Colors.white)),
              onPressed: () {
                if (phoneController.text.isNotEmpty) {
                  setState(() {
                    currentUsername = "+91 " + phoneController.text;
                  });
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Successfully Logged In!")),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Payment Method"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.account_balance_wallet, color: Colors.blue),
                title: Text("UPI / Google Pay / PhonePe"),
                subtitle: Text("Zero Extra Charges (Free)", style: TextStyle(color: Colors.green, fontSize: 12)),
                onTap: () {
                  Navigator.of(context).pop();
                  _orderSuccessMessage("Paid via UPI (No extra charge)");
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.credit_card, color: Colors.orange),
                title: Text("Credit / Debit Card"),
                subtitle: Text("Zero Extra Charges (Free)", style: TextStyle(color: Colors.green, fontSize: 12)),
                onTap: () {
                  Navigator.of(context).pop();
                  _orderSuccessMessage("Paid via Card (No extra charge)");
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.money, color: Colors.red),
                title: Text("Cash on Delivery (COD)"),
                subtitle: Text("Extra COD Handling Charge: +₹49", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12)),
                onTap: () {
                  Navigator.of(context).pop();
                  _orderSuccessMessage("Ordered with COD (₹49 Extra Charged)");
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _orderSuccessMessage(String paymentType) {
    setState(() {
      cartItems.clear();
    });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Order Successful! 🎉"),
        content: Text("Thank you for shopping with LinkApp Store.\n\nMode: $paymentType\nYour order has been placed successfully."),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text("OK", style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void addToCart(String productName) {
    setState(() {
      cartItems.add(productName);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$productName added to Cart!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      ListView(
        children: [
          Container(
            color: Colors.blue[800],
            padding: EdgeInsets.all(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.grey),
                  hintText: "Search for Products, Brands and More",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            height: 90,
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCategoryItem(Icons.phone_android, "Mobiles"),
                _buildCategoryItem(Icons.checkroom, "Fashion"),
                _buildCategoryItem(Icons.tv, "Electronics"),
                _buildCategoryItem(Icons.home, "Home"),
                _buildCategoryItem(Icons.sports_esports, "Gaming"),
                _buildCategoryItem(Icons.book, "Books"),
              ],
            ),
          ),
          SizedBox(height: 8),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 160,
            decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("BIG BILLION DAYS", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text("Up to 80% Off on Everything!", style: TextStyle(color: Colors.white70, fontSize: 16)),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {},
                    child: Text("Explore Now", style: TextStyle(color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text("Suggested for You", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 0.70,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: [
                _buildProductCard("Smart Watch", "₹1,999", Colors.blue[100]!),
                _buildProductCard("Wireless Earbuds", "₹999", Colors.purple[100]!),
                _buildProductCard("Running Shoes", "₹2,499", Colors.orange[100]!),
                _buildProductCard("Bluetooth Speaker", "₹1,499", Colors.green[100]!),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
      Scaffold(
        body: cartItems.isEmpty
            ? Center(child: Text("Your Cart is Empty!", style: TextStyle(fontSize: 18, color: Colors.grey)))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.shopping_bag, color: Colors.blue[800]),
                          title: Text(cartItems[index]),
                          subtitle: Text("In your cart"),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                cartItems.removeAt(index);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    color: Colors.white,
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700]),
                        onPressed: () => _showPaymentDialog(context),
                        child: Text("Proceed to Payment", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_circle, size: 100, color: Colors.blue[800]),
            SizedBox(height: 10),
            Text("Logged in as: $currentUsername", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800]),
              onPressed: () => _showMobileLoginDialog(context),
              child: Text("Change / Login Mobile Number", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("LinkApp Store", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            Text("Welcome, $currentUsername", style: TextStyle(fontSize: 12, color: Colors.yellowAccent)),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.notifications, color: Colors.white), onPressed: () {}),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      '${cartItems.length}',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.white, size: 28),
            onPressed: () => _showMobileLoginDialog(context),
          ),
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.blue[50],
            child: Icon(icon, color: Colors.blue[800]),
          ),
          SizedBox(height: 4),
          Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildProductCard(String name, String price, Color bgColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4, spreadRadius: 1)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Center(child: Icon(Icons.shopping_bag, size: 50, color: Colors.black54)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                SizedBox(height: 2),
                Text(price, style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.bold, fontSize: 14)),
                SizedBox(height: 2),
                Text("Min. 50% Off", style: TextStyle(color: Colors.red, fontSize: 11)),
                SizedBox(height: 6),
                SizedBox(
                  width: double.infinity,
                  height: 28,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[700],
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () => addToCart(name),
                    child: Text("Add to Cart", style: TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

