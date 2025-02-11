import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        left: screenSize.width * 0.075,
        right: screenSize.width * 0.075,
        top: screenSize.width * 0.05,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: screenSize.height * 0.55,
            width: screenSize.width * 0.4,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.all(
                Radius.circular(screenSize.height * 0.02),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(screenSize.height * 0.05),
              child: Column(
                children: [
                  Text(
                    'SOBRE NÓS',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.04,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet. Id voluptatem nobis hic rerum facere et voluptates consectetur. Eos reiciendis obcaecati et porro voluptates ut aspernatur aliquid qui fugiat sapiente.\n\nEt culpa aspernatur ut repellendus esse cum nobis consectetur? Ad recusandae rerum ut placeat nobis ut error nesciunt. Eos quasi natus et amet eveniet 33 dignissimos officiis qui consequatur asperiores.\n\nEt omnis neque et dolores magni quo rerum libero eos sint quasi ut odio minus! A explicabo quia eos quis nobis ex galisum maiores id inventore pariatur sit omnis adipisci.',
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: screenSize.width * 0.02,
          ),
          SizedBox(
            height: screenSize.height * 0.55,
            width: screenSize.width * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                Text(
                  'FALE CONOSCO',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                SizedBox(
                  width: screenSize.width * 0.2,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.phone_enabled_rounded,
                            color: Theme.of(context).highlightColor,
                            size: screenSize.height * 0.04,
                          ),
                          SizedBox(
                            width: screenSize.width * 0.015,
                          ),
                          Text('0000 - 0000 ou 3333 - 3333',
                              style: Theme.of(context).textTheme.bodyMedium)
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.alternate_email,
                            color: Theme.of(context).highlightColor,
                            size: screenSize.height * 0.04,
                          ),
                          SizedBox(
                            width: screenSize.width * 0.015,
                          ),
                          Text('cuties@cutiespetshop.com.br',
                              style: Theme.of(context).textTheme.bodyMedium)
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.instagram,
                            size: screenSize.height * 0.04,
                            color: Theme.of(context).highlightColor,
                          ),
                          SizedBox(
                            width: screenSize.width * 0.015,
                          ),
                          Text('@cutiespetshop',
                              style: Theme.of(context).textTheme.bodyMedium)
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
