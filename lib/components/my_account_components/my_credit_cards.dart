import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:petshop/models/credit_card.dart';
import 'package:petshop/providers/my_account_provider.dart';

class MyCreditCards extends StatefulWidget {
  const MyCreditCards({super.key});

  @override
  State<MyCreditCards> createState() => _MyCreditCardsState();
}

class _MyCreditCardsState extends State<MyCreditCards> {
  String creditCardMask(String cardNumber) {
    List<String> parts = cardNumber.split(' ');
    if (parts.length == 4) {
      return '${parts[0]} xxxx xxxx ${parts[3]}';
    } else {
      return cardNumber;
    }
  }

  Widget cardItem(Size screenSize, CreditCard creditCard) {
    return InkWell(
      onTap: null,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: screenSize.height * 0.03,
          right: screenSize.width * 0.03,
          left: screenSize.height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenSize.width * 0.2,
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.01,
                vertical: screenSize.height * 0.01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenSize.height * 0.015),
                border: Border.all(color: Theme.of(context).primaryColorDark),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenSize.height * 0.02),
                  Text(creditCard.flag),
                  SizedBox(height: screenSize.height * 0.01),
                  Text(creditCardMask(creditCard.number)),
                  SizedBox(height: screenSize.height * 0.01),
                  Text(creditCard.owner),
                  SizedBox(height: screenSize.height * 0.01),
                  Text(creditCard.expirationDate),
                  SizedBox(height: screenSize.height * 0.02),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    MyAccount myAccountProvider = Provider.of<MyAccount>(context);

    return AnimatedContainer(
      width: screenSize.width * 0.6,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Theme.of(context).dividerColor, width: 0.5),
        borderRadius: BorderRadius.circular(screenSize.height * 0.02),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: screenSize.height * 0.03,
              top: screenSize.height * 0.03,
            ),
            child: Text(
              'Meus Cartões',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          SizedBox(height: screenSize.height * 0.03),
          Padding(
            padding: EdgeInsets.only(left: screenSize.height * 0.03),
            child: Text(
              'Confira os seus cartões cadastrados',
              style: TextStyle(
                fontFamily: 'NunitoSansBold',
                fontSize: screenSize.height * 0.018,
                fontWeight: FontWeight.normal,
                letterSpacing: screenSize.width * 0.0001,
                color: const Color.fromARGB(187, 0, 0, 0),
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.05),
          Column(
            children: [
              for (CreditCard card in myAccountProvider.myCreditCards)
                cardItem(screenSize, card),
            ],
          ),
        ],
      ),
    );
  }
}
