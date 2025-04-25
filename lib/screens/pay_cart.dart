import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:petshop/models/order.dart';
import 'package:petshop/models/cart_item.dart';
import 'package:petshop/models/credit_card.dart';
import 'package:petshop/providers/my_account_provider.dart';
import 'package:petshop/providers/shopping_cart_provider.dart';
import 'package:petshop/providers/order_history_provider.dart';
import 'package:petshop/providers/selected_screen_provider.dart';
import 'package:petshop/components/cart_components/credit_card.dart';
import 'package:petshop/components/my_account_components/order_details.dart';

class PayCart extends StatefulWidget {
  final String orderID;
  const PayCart({super.key, required this.orderID});

  @override
  State<PayCart> createState() => _PayCartState();
}

class _PayCartState extends State<PayCart> {
  String _selectedPaymentMethod = 'Cartão de Crédito';
  bool _anyChanges = false;
  String? _errorMessage;
  late List<String> _options;
  late String _selectedCard;

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  String? validateCardFields() {
    String cleanedCardNumber = _cardNumberController.text.replaceAll(' ', '');
    String cardHolderName = _cardHolderController.text.trim();
    String expirationDate = _expiryDateController.text.trim();
    String cvvCode = _cvvController.text.trim();

    const genericError = 'Dado(s) do cartão inválido(s).';

    if (cleanedCardNumber.length != 16) {
      return genericError;
    }

    if (cardHolderName.isEmpty) {
      return genericError;
    }

    final dateParts = expirationDate.split('/');
    if (dateParts.length != 2) {
      return genericError;
    }

    int? month = int.tryParse(dateParts[0]);
    int? year = int.tryParse(dateParts[1]);

    if (month == null || year == null || month < 1 || month > 12) {
      return genericError;
    }

    int currentYear = DateTime.now().year % 100;
    int currentMonth = DateTime.now().month;

    if (year < currentYear || (year == currentYear && month <= currentMonth)) {
      return genericError;
    }

    if (cvvCode.isEmpty ||
        cvvCode.length < 3 ||
        int.tryParse(cvvCode) == null) {
      return genericError;
    }

    return null;
  }

  _payOrder(
    MyAccount myAccountProvider,
    OrderHistoryProvider orderHistoryProvider,
    ShoppingCartProvider shoppingCartProvider,
    SelectScreen selectScreenProvider,
  ) {
    if (orderHistoryProvider.orders
        .where((element) => element.id == widget.orderID)
        .isEmpty) {
      List<CartItem> itens = List.from(shoppingCartProvider.cartItems);
      Order order = Order(
        id: (orderHistoryProvider.orders.length + 1).toString(),
        clientID: myAccountProvider.loggedUserInfos!.id.toString(),
        itens: itens,
        data: DateTime.now(),
        status: 'Pedido Aprovado',
        formaPagamento: '',
      );
      orderHistoryProvider.addOrder(order);
      shoppingCartProvider.cleanCart();
      myAccountProvider.updateAccountDetailsScreen(OrderDetails(order: order));
      context.goNamed('minha-conta');
    } else {
      Order order = orderHistoryProvider.orders.firstWhere(
        (element) => element.id == widget.orderID,
      );
      order.status = 'Pedido Aprovado';
      shoppingCartProvider.cleanCart();
      myAccountProvider.updateAccountDetailsScreen(OrderDetails(order: order));
      context.goNamed('minha-conta');
    }
  }

  String creditCardMask(String cardNumber) {
    final digits = cardNumber.replaceAll(RegExp(r'\s+'), '');
    if (digits.length == 16) {
      return '${digits.substring(0, 4)} xxxx xxxx ${digits.substring(12)}';
    }
    return cardNumber;
  }

  _onCardChanged(String newCard) {
    setState(() {
      _selectedCard = newCard;
    });
  }

  _onAnyChanges(bool anyChange) {
    setState(() {
      _anyChanges = anyChange;
    });
  }

  @override
  void initState() {
    super.initState();
    final myAccountProvider = Provider.of<MyAccount>(context, listen: false);
    _options =
        myAccountProvider.myCreditCards
            .map((card) => creditCardMask(card.number))
            .toList();
    _options.add('Adicionar novo cartão');
    _selectedCard = _options[0];
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    MyAccount myAccountProvider = Provider.of<MyAccount>(
      context,
      listen: false,
    );
    ShoppingCartProvider shoppingCartProvider =
        Provider.of<ShoppingCartProvider>(context, listen: false);
    SelectScreen selectScreenProvider = Provider.of<SelectScreen>(
      context,
      listen: false,
    );
    OrderHistoryProvider orderHistoryProvider =
        Provider.of<OrderHistoryProvider>(context, listen: false);

    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: screenSize.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: screenSize.width * 0.06),
                    ElevatedButton(
                      onPressed: () {
                        context.goNamed('home');
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: screenSize.width * 0.015,
                        ),
                        child: Image.asset(
                          'assets/images/petshop_logo.png',
                          width: screenSize.width * 0.08,
                          height: screenSize.height * 0.12,
                        ),
                      ),
                    ),
                    Text(
                      'FOFINHOS PETSHOP',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: screenSize.height * 0.05),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.075),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Finalizar pagamento',
                          style: TextStyle(
                            fontFamily: 'NunitoSansBold',
                            fontSize: screenSize.height * 0.032,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenSize.height * 0.03),
                    SizedBox(
                      width: screenSize.width * 0.4,
                      height: screenSize.height * 0.6,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (var item in shoppingCartProvider.cartItems)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.height * 0.03,
                                  vertical: screenSize.height * 0.015,
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(
                                    screenSize.height * 0.04,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      screenSize.height * 0.01,
                                    ),
                                    border: Border.all(
                                      color: Theme.of(context).dividerColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        item.product.imagemUrl,
                                        height: screenSize.height * 0.1,
                                        width: screenSize.height * 0.1,
                                        fit: BoxFit.fill,
                                      ),
                                      SizedBox(width: screenSize.width * 0.02),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.product.nome,
                                              style: TextStyle(
                                                fontFamily: 'NunitoSans',
                                                fontSize:
                                                    screenSize.height * 0.018,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              'Quantidade: ${item.quantity}',
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        'R\$ ${(double.parse(item.product.preco) * item.quantity).toStringAsFixed(2).replaceAll('.', ',')}',
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.labelMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: screenSize.width * 0.01),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.025,
                    ),
                    alignment: Alignment.topCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenSize.height * 0.01),
                        Text(
                          'Valor Total: R\$ ${shoppingCartProvider.totalCartValue.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        SizedBox(height: screenSize.height * 0.035),
                        Row(
                          children: [
                            Text(
                              'Escolha o método de pagamento:',
                              style: TextStyle(
                                fontFamily: 'NunitoSansBold',
                                fontSize: screenSize.height * 0.02,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: screenSize.width * 0.02),
                            DropdownButton<String>(
                              elevation: 1,
                              borderRadius: BorderRadius.circular(
                                screenSize.height * 0.01,
                              ),
                              underline: const SizedBox(),
                              dropdownColor: Colors.white,
                              focusColor: Colors.white,
                              value: _selectedPaymentMethod,
                              style: TextStyle(
                                fontFamily: 'NunitoSansBold',
                                fontSize: screenSize.height * 0.02,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromRGBO(227, 28, 70, 1),
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedPaymentMethod = newValue!;
                                });
                              },
                              items:
                                  <String>[
                                    'Cartão de Crédito',
                                    'Boleto',
                                    'PIX',
                                  ].map<DropdownMenuItem<String>>((
                                    String value,
                                  ) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.height * 0.015),
                        if (_selectedPaymentMethod == 'Cartão de Crédito')
                          Container(
                            height: screenSize.height * 0.425,
                            width: screenSize.width * 0.4,
                            alignment: Alignment.center,
                            child: CreditCardPayment(
                              cardNumberController: _cardNumberController,
                              cardHolderController: _cardHolderController,
                              expiryDateController: _expiryDateController,
                              cvvController: _cvvController,
                              validateCardFields: validateCardFields,
                              anyChanges: _anyChanges,
                              selectedCard: _selectedCard,
                              options: _options,
                              onCardChanged: _onCardChanged,
                              onAnyChanges: _onAnyChanges,
                            ),
                          ),
                        if (_selectedPaymentMethod == 'Boleto')
                          Container(
                            alignment: Alignment.center,
                            height: screenSize.height * 0.425,
                            width: screenSize.width * 0.4,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: screenSize.height * 0.02,
                              ),
                              child: const Text(
                                'O boleto será gerado após a confirmação do pedido.',
                              ),
                            ),
                          ),
                        if (_selectedPaymentMethod == 'PIX')
                          Container(
                            alignment: Alignment.center,
                            height: screenSize.height * 0.425,
                            width: screenSize.width * 0.4,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: screenSize.height * 0.02,
                              ),
                              child: const Text(
                                'O código PIX será gerado após a confirmação do pedido.',
                              ),
                            ),
                          ),
                        SizedBox(height: screenSize.height * 0.01),
                        Padding(
                          padding: EdgeInsets.only(
                            left: screenSize.width * 0.015,
                          ),
                          child: Text(
                            _errorMessage ?? '',
                            style: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontSize: screenSize.height * 0.018,
                              fontWeight: FontWeight.bold,
                              letterSpacing: screenSize.width * 0.0001,
                              color: const Color.fromRGBO(227, 28, 70, 1),
                            ),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        SizedBox(
                          width: screenSize.width * 0.425,
                          height: screenSize.height * 0.075,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<
                                RoundedRectangleBorder
                              >(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    screenSize.height * 0.015,
                                  ),
                                ),
                              ),
                              backgroundColor: WidgetStateProperty.all<Color>(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                            onPressed:
                                _selectedCard == _options.last
                                    ? () {
                                      if (_anyChanges) {
                                        final String? validationError =
                                            validateCardFields();

                                        if (validationError == null) {
                                          myAccountProvider.addCreditCard(
                                            CreditCard(
                                              flag: 'BANCO PETS',
                                              number:
                                                  _cardNumberController.text,
                                              owner: _cardHolderController.text,
                                              expirationDate:
                                                  _expiryDateController.text,
                                              cvv: _cvvController.text,
                                            ),
                                          );
                                          setState(() {
                                            _anyChanges = false;
                                            _errorMessage = '';
                                            _selectedCard = creditCardMask(
                                              _cardNumberController.text,
                                            );
                                          });
                                          _payOrder(
                                            myAccountProvider,
                                            orderHistoryProvider,
                                            shoppingCartProvider,
                                            selectScreenProvider,
                                          );
                                        } else {
                                          setState(() {
                                            _errorMessage = validationError;
                                          });
                                        }
                                      } else {
                                        if (_selectedCard.isNotEmpty &&
                                            _selectedCard !=
                                                'Adicionar novo cartão') {
                                          setState(() {
                                            _errorMessage = '';
                                          });

                                          _payOrder(
                                            myAccountProvider,
                                            orderHistoryProvider,
                                            shoppingCartProvider,
                                            selectScreenProvider,
                                          );
                                        } else {
                                          setState(() {
                                            _errorMessage =
                                                'Selecione um cartão para prosseguir.';
                                          });
                                        }
                                      }
                                    }
                                    : () => _payOrder(
                                      myAccountProvider,
                                      orderHistoryProvider,
                                      shoppingCartProvider,
                                      selectScreenProvider,
                                    ),

                            child: Text(
                              'Fazer Pagamento',
                              style: TextStyle(
                                fontFamily: 'NunitoSansBold',
                                fontSize: screenSize.height * 0.022,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
