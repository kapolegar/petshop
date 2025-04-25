import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:petshop/providers/my_account_provider.dart';
import 'package:petshop/components/cart_components/new_credit_card.dart';

class CreditCardPayment extends StatefulWidget {
  final TextEditingController cardNumberController;
  final TextEditingController cardHolderController;
  final TextEditingController expiryDateController;
  final TextEditingController cvvController;
  final String? Function()? validateCardFields;
  final String? paymentError;
  List<String> options;
  String selectedCard;
  bool anyChanges;
  final Function(String)? onCardChanged;
  final Function(bool)? onAnyChanges;

  CreditCardPayment({
    super.key,
    required this.cardNumberController,
    required this.cardHolderController,
    required this.expiryDateController,
    required this.cvvController,
    this.validateCardFields,
    this.paymentError,
    required this.options,
    required this.selectedCard,
    required this.anyChanges,
    this.onAnyChanges,
    this.onCardChanged,
  });

  @override
  State<CreditCardPayment> createState() => _CreditCardPaymentState();
}

class _CreditCardPaymentState extends State<CreditCardPayment> {
  late String _selectedCard;

  String creditCardMask(String cardNumber) {
    final digits = cardNumber.replaceAll(RegExp(r'\s+'), '');
    if (digits.length == 16) {
      return '${digits.substring(0, 4)} xxxx xxxx ${digits.substring(12)}';
    }
    return cardNumber;
  }

  Widget _buildCardContainer(
    Size screenSize,
    MyAccount myAccountProvider,
    int index,
  ) {
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
          Text(
            creditCardMask(myAccountProvider.myCreditCards[index].number),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: screenSize.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                myAccountProvider.myCreditCards[index].owner,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                myAccountProvider.myCreditCards[index].expirationDate,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedCard = widget.selectedCard ?? '';
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final myAccountProvider = Provider.of<MyAccount>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: screenSize.height * 0.425,
            width: screenSize.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenSize.width * 0.4,
                  height: screenSize.height * 0.05,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.75,
                      color: Theme.of(context).dividerColor,
                    ),
                    borderRadius: BorderRadius.circular(
                      screenSize.height * 0.015,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      elevation: 1,
                      value: _selectedCard,
                      menuMaxHeight: screenSize.height * 0.25,
                      items:
                          widget.options.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(
                                option,
                                style: TextStyle(
                                  fontFamily: 'NunitoSans',
                                  fontSize: screenSize.height * 0.018,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(190, 0, 0, 0),
                                ),
                              ),
                            );
                          }).toList(),

                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCard = newValue!;
                        });
                        if (widget.onCardChanged != null) {
                          widget.onCardChanged!(newValue!);
                        }
                      },
                      borderRadius: BorderRadius.circular(
                        screenSize.height * 0.02,
                      ),
                      decoration: InputDecoration(
                        focusColor: const Color.fromARGB(64, 227, 28, 71),
                        fillColor: Colors.transparent,
                        hoverColor: const Color.fromARGB(64, 227, 28, 71),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.01,
                          vertical: screenSize.height * 0.01,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.025),
                if (widget.selectedCard != widget.options.last)
                  _buildCardContainer(
                    screenSize,
                    myAccountProvider,
                    widget.options.indexOf(_selectedCard),
                  ),
                if (widget.selectedCard == widget.options.last)
                  Container(
                    alignment: Alignment.centerLeft,
                    height: screenSize.height * 0.35,
                    width: screenSize.width * 0.4,
                    child: NewCreditCard(
                      cardNumberController: widget.cardNumberController,
                      cardHolderController: widget.cardHolderController,
                      expiryDateController: widget.expiryDateController,
                      cvvController: widget.cvvController,
                      validateCardFields: widget.validateCardFields,
                      anyChanges: widget.anyChanges,
                      onAnyChanges: widget.onAnyChanges,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
