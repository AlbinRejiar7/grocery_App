import 'package:flutter/material.dart';
import 'package:grocery_app/Model/cart_model.dart';
import 'package:grocery_app/controller/cart_controller.dart';
import 'package:grocery_app/controller/dark_theme_provider.dart';
import 'package:grocery_app/controller/orders_controller.dart';
import 'package:grocery_app/controller/product_controller.dart';
import 'package:grocery_app/view/cart/cart_widget.dart';
import 'package:grocery_app/widget/empty_screen.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Razorpay _razorpay = Razorpay();
  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    super.initState();
  }

  bool isPaymentSuccessfull = false;

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    setState(() {
      isPaymentSuccessfull = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("PAYMENT SUCCESSFULL YOUR ORDER HAS BEEN PLACED")));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("PAYMENT FAILED")));
    setState(() {
      isPaymentSuccessfull = false;
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }
  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    var orderController = Provider.of<OrdersController>(context);
    double total = 0.0;
    DarkThemeProvider themeController = Provider.of<DarkThemeProvider>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;
    CartController cartProvider = Provider.of<CartController>(context);
    List<CartModel> cartItemList = cartProvider.getCartItems.values.toList();

    var productProvider = Provider.of<ProductController>(context);

    cartProvider.getCartItems.forEach((key, value) {
      final getCurrentProduct = productProvider.findProdByid(value.productId);
      total += (getCurrentProduct.isOnSale
              ? getCurrentProduct.salePrice
              : getCurrentProduct.price) *
          value.quantity;
    });

    return cartProvider.getCartItems.isEmpty
        ? const EmptyScreen()
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back,
                    color: color,
                  )),
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                "Cart(${cartProvider.getCartItems.length})",
                style: TextStyle(color: color, fontWeight: FontWeight.w700),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      _showDeleteDialog(context, cartProvider);
                    },
                    icon: Icon(
                      IconlyBroken.delete,
                      color: color,
                    ))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.green)),
                            onPressed: () async {
                              try {
                                var options = {
                                  'key': "rzp_test_crC9Czw4mnhFNy",
                                  'amount': total * 100,
                                  'name': 'Fresh Veggies',
                                  'description': 'For your good Health',
                                  'prefill': {
                                    'contact': '4535345345',
                                    'email': 'abcd@gmail.com'
                                  }
                                };
                                _razorpay.open(options);
                                if (isPaymentSuccessfull) {
                                  await orderController.saveOrderstoDb(
                                      context, total);
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())));
                              } finally {
                                setState(() {
                                  isPaymentSuccessfull = false;
                                });
                              }
                            },
                            child: const Text(
                              "ORDER",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      Row(
                        children: [
                          Text(
                            "TOTAL: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: color),
                          ),
                          FittedBox(
                            child: Text(
                              "₹ ${total.toStringAsFixed(2)} ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 22,
                                  color: Colors.green[700]),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Flexible(
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int value) =>
                          Divider(
                        height: 30,
                        color: color,
                      ),
                      itemCount: cartItemList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ChangeNotifierProvider.value(
                            value: cartItemList[index],
                            child: CartWidget(
                              quantity: cartItemList[index].quantity.toString(),
                            ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Future<dynamic> _showDeleteDialog(
      BuildContext context, CartController cartProvider) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              // ignore: prefer_const_constructors
              content: Row(
                children: const [
                  Icon(
                    IconlyBroken.delete,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 28,
                  ),
                  Flexible(child: Text("DO YOU WANT TO CLEAR THE CART?")),
                ],
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.cancel)),
                IconButton(
                    onPressed: () {
                      cartProvider.clearCartOnDb();

                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.done))
              ],
            ));
  }
}
