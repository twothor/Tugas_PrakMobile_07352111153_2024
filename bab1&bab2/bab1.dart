enum Role { admin, customer }

class Product {
  String productName;
  double price;
  bool inStock;

  Product({required this.productName, required this.price, this.inStock = true});
}

class User {
  String name;
  int age;
  late List<Product> products; // Marked as late for initialization after object creation
  Role? role; // Role can be null

  User({required this.name, required this.age, required this.role});

  Future<void> fetchProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    products = [
      // ... fill products list with actual data (safe assignment)
    ];
  }

  void addToCart(Product product) {
    if (role != null && role == Role.customer) {
      try {
        if (product.inStock) {
          products.add(product);
          print('Produk ${product.productName} berhasil ditambahkan ke keranjang.');
        } else {
          throw Exception('Produk sudah habis');
        }
      } catch (e) {
        print('Terjadi kesalahan: $e');
      }
    } else {
      print('Hanya customer yang bisa menambah produk ke keranjang.');
    }
  }
}

class AdminUser extends User {
  AdminUser({required String name, required int age})
      : super(name: name, age: age, role: Role.admin);

  void addProduct(Product product) {
    products.add(product);
    print('Produk ${product.productName} berhasil ditambahkan ke daftar produk.');
  }

  void removeProduct(Product product) {
    products.remove(product);
    print('Produk ${product.productName} berhasil dihapus dari daftar produk.');
  }
}

class CustomerUser extends User {
  CustomerUser({required String name, required int age})
      : super(name: name, age: age, role: Role.customer);
}

void main() async {
  final customer = CustomerUser(name: 'Thor', age: 25);

  await customer.fetchProducts();

  customer.addToCart(Product(productName: 'iPhone 14', price: 15000000, inStock: true));
}