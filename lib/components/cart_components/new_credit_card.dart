import 'dart:math';
import 'package:flutter/material.dart';
import 'package:petshop/components/cart_components/card_input_formatter.dart';

class NewCreditCard extends StatefulWidget {
  final TextEditingController cardNumberController;
  final TextEditingController cardHolderController;
  final TextEditingController expiryDateController;
  final TextEditingController cvvController;
  final String? Function()? validateCardFields;
  final String? paymentError;
  bool anyChanges;
  final Function(bool)? onAnyChanges;

  NewCreditCard({
    super.key,
    required this.cardNumberController,
    required this.cardHolderController,
    required this.expiryDateController,
    required this.cvvController,
    required this.validateCardFields,
    this.paymentError,
    required this.anyChanges,
    this.onAnyChanges,
  });

  @override
  State<NewCreditCard> createState() => NewCreditCardState();
}

class NewCreditCardState extends State<NewCreditCard>
    with SingleTickerProviderStateMixin {
  String cardNumber = 'XXXX XXXX XXXX XXXX';
  String cardHolder = 'SEU NOME AQUI';
  String expiryDate = 'MM/AA';
  String cvv = 'XXX';
  bool showBack = false;
  bool _checkbox = true;

  late bool _anyChanges;
  late AnimationController _controller;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    _anyChanges = false;
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _flipAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void toggleCardSide(bool back) {
    setState(() {
      showBack = back;
      if (back) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  Widget _buildFrontCard(Size screenSize) {
    return _buildCardContent(
      screenSize: screenSize,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Banco Pets',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              Text(
                'VISA',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.02),

          Container(
            width: screenSize.width * 0.03,
            height: screenSize.height * 0.035,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.amber[300],
            ),
          ),
          const Spacer(),
          Text(cardNumber, style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(height: screenSize.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(cardHolder, style: Theme.of(context).textTheme.bodyMedium),
              Text(expiryDate, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard(Size screenSize) {
    return _buildCardContent(
      screenSize: screenSize,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screenSize.height * 0.05,
            color: Colors.black87,
            margin: EdgeInsets.only(bottom: screenSize.height * 0.03),
          ),

          const Text(
            'Assinatura',
            style: TextStyle(fontSize: 10, color: Colors.white70),
          ),
          Container(
            height: screenSize.height * 0.04,
            color: Colors.white70,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.centerRight,
            child: Text(
              cvv,
              style: const TextStyle(
                fontFamily: 'Courier',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          const Spacer(),
          const Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'Powered by Pets',
              style: TextStyle(
                fontSize: 10,
                fontStyle: FontStyle.italic,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardContent({required Widget child, required Size screenSize}) {
    return Container(
      width: screenSize.width * 0.22,
      height: screenSize.height * 0.27,
      padding: EdgeInsets.all(screenSize.height * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenSize.height * 0.02),
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        color: const Color.fromARGB(70, 21, 202, 163),
      ),
      child: child,
    );
  }

  String formatCardNumber(String input) {
    input = input.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      buffer.write(input[i]);
      if ((i + 1) % 4 == 0 && i != input.length - 1) buffer.write(' ');
    }
    return buffer.toString().padRight(19, 'X');
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: screenSize.height * 0.35,
          width: screenSize.width * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AnimatedBuilder(
                        animation: _flipAnimation,
                        builder: (context, child) {
                          final angle = _flipAnimation.value * pi;
                          final isFront = angle <= pi / 2;

                          return Transform(
                            alignment: Alignment.center,
                            transform:
                                Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..rotateY(angle),
                            child: Stack(
                              children: [
                                Opacity(
                                  opacity: isFront ? 1.0 : 0.0,
                                  child: _buildFrontCard(screenSize),
                                ),
                                Opacity(
                                  opacity: isFront ? 0.0 : 1.0,
                                  child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.identity()..rotateY(pi),
                                    child: _buildBackCard(screenSize),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      SizedBox(
                        width: screenSize.width * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              side: BorderSide(
                                color: Theme.of(context).primaryColorDark,
                                width: 2,
                              ),
                              checkColor: Colors.white,
                              activeColor: Theme.of(context).primaryColorDark,
                              value: _checkbox,
                              onChanged: (bool? valor) {
                                setState(() {
                                  _checkbox = valor!;
                                });
                                print(_checkbox);
                              },
                            ),
                            Text(
                              'Salvar cartão',
                              style: TextStyle(
                                fontFamily: 'NunitoSans',
                                fontSize: screenSize.height * 0.018,
                                fontWeight: FontWeight.bold,
                                letterSpacing: screenSize.width * 0.0001,
                                color: const Color.fromARGB(187, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: screenSize.width * 0.02),
                  SizedBox(
                    width: screenSize.width * 0.15,
                    height: screenSize.height * 0.35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: screenSize.height * 0.005,
                          ),
                          child: Text(
                            'Número do Cartão',
                            style: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontSize: screenSize.height * 0.018,
                              fontWeight: FontWeight.bold,
                              height: screenSize.height * 0.003,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          height: screenSize.height * 0.065,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).dividerColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              screenSize.height * 0.01,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: screenSize.height * 0.015,
                          ),
                          child: TextField(
                            controller: widget.cardNumberController,
                            inputFormatters: [CardNumberInputFormatter()],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(
                                screenSize.height * 0.01,
                              ),
                              border: InputBorder.none,
                              counterText: '',
                            ),
                            style: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontSize: screenSize.height * 0.016,
                              fontWeight: FontWeight.bold,
                              height: screenSize.height * 0.003,
                              color: Colors.black,
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 19,
                            onTap: () => toggleCardSide(false),
                            onChanged: (val) {
                              setState(() {
                                cardNumber = formatCardNumber(val);
                                _anyChanges = true;
                              });
                              widget.onAnyChanges!(true);
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: screenSize.height * 0.005,
                          ),
                          child: Text(
                            'Nome do Titular',
                            style: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontSize: screenSize.height * 0.018,
                              fontWeight: FontWeight.bold,
                              height: screenSize.height * 0.003,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          height: screenSize.height * 0.065,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).dividerColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              screenSize.height * 0.01,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: screenSize.height * 0.015,
                          ),
                          child: TextField(
                            controller: widget.cardHolderController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(
                                screenSize.height * 0.01,
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontSize: screenSize.height * 0.018,
                              fontWeight: FontWeight.bold,
                              height: screenSize.height * 0.003,
                              color: Colors.black,
                            ),
                            onTap: () => toggleCardSide(false),
                            onChanged: (val) {
                              setState(() {
                                cardHolder =
                                    val.isEmpty
                                        ? 'SEU NOME AQUI'
                                        : val.toUpperCase();
                                _anyChanges = true;
                              });
                              widget.onAnyChanges!(true);
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: screenSize.height * 0.005,
                                  ),
                                  child: Text(
                                    'Validade (MM/AA)',
                                    style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontSize: screenSize.height * 0.018,
                                      fontWeight: FontWeight.bold,
                                      height: screenSize.height * 0.003,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: screenSize.height * 0.065,
                                  width: screenSize.width * 0.07,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context).dividerColor,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      screenSize.height * 0.01,
                                    ),
                                  ),
                                  child: TextField(
                                    controller: widget.expiryDateController,
                                    inputFormatters: [
                                      ExpiryDateInputFormatter(),
                                    ],
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(
                                        screenSize.height * 0.01,
                                      ),
                                      border: InputBorder.none,
                                      counterText: '',
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontSize: screenSize.height * 0.018,
                                      fontWeight: FontWeight.bold,
                                      height: screenSize.height * 0.003,
                                      color: Colors.black,
                                    ),
                                    keyboardType: TextInputType.number,
                                    maxLength: 5,
                                    onTap: () => toggleCardSide(false),
                                    onChanged: (val) {
                                      val = val.replaceAll(RegExp(r'\D'), '');
                                      if (val.length > 2) {
                                        val =
                                            '${val.substring(0, 2)}/${val.substring(2)}';
                                      }
                                      setState(() {
                                        expiryDate = val.padRight(5, 'A');
                                        _anyChanges = true;
                                      });
                                      widget.onAnyChanges!(true);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: screenSize.height * 0.005,
                                  ),
                                  child: Text(
                                    'CVV',
                                    style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontSize: screenSize.height * 0.018,
                                      fontWeight: FontWeight.bold,
                                      height: screenSize.height * 0.003,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: screenSize.height * 0.065,
                                  width: screenSize.width * 0.07,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context).dividerColor,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      screenSize.height * 0.01,
                                    ),
                                  ),
                                  child: TextField(
                                    controller: widget.cvvController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(
                                        screenSize.height * 0.01,
                                      ),
                                      border: InputBorder.none,
                                      counterText: '',
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'NunitoSans',
                                      fontSize: screenSize.height * 0.018,
                                      fontWeight: FontWeight.bold,
                                      height: screenSize.height * 0.003,
                                      color: Colors.black,
                                    ),
                                    keyboardType: TextInputType.number,
                                    maxLength: 3,
                                    onTap: () => toggleCardSide(true),
                                    onChanged: (val) {
                                      setState(() {
                                        cvv = val.padRight(3, 'X');
                                        _anyChanges = true;
                                      });
                                      widget.onAnyChanges!(true);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
