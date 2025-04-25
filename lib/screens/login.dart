import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petshop/providers/my_account_provider.dart';
import 'package:petshop/providers/order_history_provider.dart';
import 'package:petshop/providers/selected_screen_provider.dart';
import 'package:petshop/screens/buy_cart.dart';
import 'package:petshop/screens/services.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final Type fromScreen;
  final String orderID;
  const Login({super.key, required this.fromScreen, required this.orderID});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _pwdControler = TextEditingController();

  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePwd = FocusNode();

  Color _emailBorderColor = const Color.fromARGB(125, 0, 0, 0);
  Color _pwdBorderColor = const Color.fromARGB(125, 0, 0, 0);

  bool _obscureTextPwd = true;
  bool _obscureTextConfirmPwd = true;

  void _togglePasswordVisibility(bool isConfirmPassword) {
    setState(() {
      if (isConfirmPassword) {
        _obscureTextConfirmPwd = !_obscureTextConfirmPwd;
      } else {
        _obscureTextPwd = !_obscureTextPwd;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _focusNodeEmail.addListener(() {
      setState(() {
        _emailBorderColor =
            _focusNodeEmail.hasFocus
                ? Theme.of(context).primaryColorDark
                : const Color.fromARGB(125, 0, 0, 0);
      });
    });
    _focusNodePwd.addListener(() {
      setState(() {
        _pwdBorderColor =
            _focusNodePwd.hasFocus
                ? Theme.of(context).primaryColorDark
                : const Color.fromARGB(125, 0, 0, 0);
      });
    });
  }

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    SelectScreen selectedScreen = Provider.of<SelectScreen>(
      context,
      listen: false,
    );
    MyAccount myAccountProvider = Provider.of<MyAccount>(
      context,
      listen: false,
    );
    final Map<Type, VoidCallback> toScreen = {
      BuyCart: () {
        myAccountProvider.validateLogin(
          _emailControler.text,
          _pwdControler.text,
          selectedScreen,
        );
        Provider.of<OrderHistoryProvider>(context, listen: false)
            .orders
            .firstWhere((order) => order.id == widget.orderID)
            .clientID = myAccountProvider.loggedUserInfos!.id.toString();
        context.goNamed(
          'pagamento',
          pathParameters: {'orderID': widget.orderID},
        );
      },
      ServicesPage: () {
        myAccountProvider.validateLogin(
          _emailControler.text,
          _pwdControler.text,
          selectedScreen,
        );
        context.goNamed('servicos');
      },
    };

    bool isButtonEnabled = true;

    return Material(
      color: Colors.white,
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
          Text(
            'Acesse sua conta',
            style: TextStyle(
              fontFamily: 'NunitoSansBold',
              fontSize: screenSize.height * 0.032,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: screenSize.height * 0.03),
          Text(
            'Informe seu email e senha cadastrados',
            style: TextStyle(
              fontFamily: 'NunitoSans',
              fontSize: screenSize.height * 0.022,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(150, 0, 0, 0),
            ),
          ),
          SizedBox(height: screenSize.height * 0.04),
          Container(
            width: screenSize.width * 0.4,
            height: screenSize.height * 0.06,
            decoration: BoxDecoration(
              border: Border.all(color: _emailBorderColor, width: 0.75),
              borderRadius: BorderRadius.circular(screenSize.height * 0.015),
            ),
            child: TextFormField(
              controller: _emailControler,
              style: TextStyle(
                fontFamily: 'NunitoSans',
                fontSize: screenSize.height * 0.02,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(190, 0, 0, 0),
              ),
              focusNode: _focusNodeEmail,
              decoration: InputDecoration(
                labelText: 'E-mail',
                labelStyle: TextStyle(
                  fontFamily: 'NunitoSans',
                  backgroundColor: Colors.white,
                  fontSize: screenSize.height * 0.02,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(175, 0, 0, 0),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
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

          SizedBox(height: screenSize.height * 0.02),
          Container(
            width: screenSize.width * 0.4,
            height: screenSize.height * 0.06,
            decoration: BoxDecoration(
              border: Border.all(color: _pwdBorderColor, width: 0.75),
              borderRadius: BorderRadius.circular(screenSize.height * 0.015),
            ),
            child: TextFormField(
              controller: _pwdControler,
              style: TextStyle(
                fontFamily: 'NunitoSans',
                fontSize: screenSize.height * 0.02,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(190, 0, 0, 0),
              ),
              obscureText: _obscureTextPwd,
              focusNode: _focusNodePwd,
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: screenSize.width * 0.005),
                  child: IconButton(
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(
                      _obscureTextPwd ? Icons.visibility_off : Icons.visibility,
                      color: const Color.fromARGB(175, 0, 0, 0),
                    ),
                    onPressed: () => _togglePasswordVisibility(false),
                  ),
                ),
                labelText: 'Senha',
                labelStyle: TextStyle(
                  fontFamily: 'NunitoSans',
                  backgroundColor: Colors.white,
                  fontSize: screenSize.height * 0.02,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(175, 0, 0, 0),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
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
          Consumer<MyAccount>(
            builder:
                (context, provider, child) => Container(
                  alignment: Alignment.center,
                  height: screenSize.height * 0.075,
                  child: Text(
                    provider.loginValidation,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
          ),
          ElevatedButton(
            onPressed:
                isButtonEnabled
                    ? toScreen.keys.toList().contains(widget.fromScreen)
                        ? () => toScreen[widget.fromScreen]!()
                        : () {
                          myAccountProvider.validateLogin(
                            _emailControler.text,
                            _pwdControler.text,
                            selectedScreen,
                          );
                          context.goNamed('minha-conta');
                        }
                    : null,
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenSize.height * 0.01),
                ),
              ),
              backgroundColor: WidgetStateProperty.all<Color>(
                Theme.of(context).primaryColorDark,
              ),
              overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.15,
                vertical: screenSize.height * 0.02,
              ),
              child: Text(
                'Entrar',
                style: TextStyle(
                  fontFamily: 'NunitoSansBold',
                  fontSize: screenSize.height * 0.02,
                  fontWeight: FontWeight.bold,
                  letterSpacing: screenSize.width * 0.0001,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.02),
          TextButton(
            onPressed: () {
              context.pop();
            },
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
              surfaceTintColor: WidgetStateProperty.all<Color>(
                Colors.transparent,
              ),
            ),
            child: Text(
              'Voltar',
              style: TextStyle(
                fontFamily: 'NunitoSansBold',
                fontSize: screenSize.height * 0.02,
                fontWeight: FontWeight.bold,
                letterSpacing: screenSize.width * 0.0001,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
