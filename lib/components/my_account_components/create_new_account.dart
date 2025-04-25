import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petshop/components/appbar_components/appbar.dart';
import 'package:petshop/providers/my_account_provider.dart';
import 'package:petshop/providers/order_history_provider.dart';
import 'package:petshop/screens/buy_cart.dart';
import 'package:petshop/screens/login.dart';
import 'package:petshop/screens/services.dart';
import 'package:provider/provider.dart';
import '../../providers/selected_screen_provider.dart';

class CreateNewAccount extends StatefulWidget {
  final Type fromScreen;
  final String orderID;
  const CreateNewAccount({
    required this.orderID,
    required this.fromScreen,
    super.key,
  });

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _pwdControler = TextEditingController();
  final TextEditingController _confirmPwdControler = TextEditingController();

  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePwd = FocusNode();
  final FocusNode _focusNodeConfirmPwd = FocusNode();

  String _emailError = '';
  String _pwdError = '';
  String _confirmPwdError = '';

  Color _emailBorderColor = const Color.fromARGB(125, 0, 0, 0);
  Color _pwdBorderColor = const Color.fromARGB(125, 0, 0, 0);
  Color _confirmPwdBorderColor = const Color.fromARGB(125, 0, 0, 0);
  Color _upperCaseValidator = const Color.fromRGBO(227, 28, 70, 1);
  Color _lowerCaseValidator = const Color.fromRGBO(227, 28, 70, 1);
  Color _numberValidator = const Color.fromRGBO(227, 28, 70, 1);
  Color _caracterCountValidator = const Color.fromRGBO(227, 28, 70, 1);

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

  bool _areAllValidatorsPassed() {
    return _upperCaseValidator == const Color.fromARGB(255, 21, 202, 163) &&
        _lowerCaseValidator == const Color.fromARGB(255, 21, 202, 163) &&
        _numberValidator == const Color.fromARGB(255, 21, 202, 163) &&
        _caracterCountValidator == const Color.fromARGB(255, 21, 202, 163);
  }

  void _validateFields(MyAccount myAccountProvider) {
    setState(() {
      _emailError = '';
      _pwdError = '';
      _confirmPwdError = '';
    });

    if (_emailControler.text.isEmpty) {
      setState(() {
        _emailError = 'O campo de e-mail deve ser preenchido';
      });
    }

    if (_pwdControler.text != _confirmPwdControler.text) {
      setState(() {
        _confirmPwdError = 'As senhas não são iguais.';
      });
    }

    if (!_areAllValidatorsPassed()) {
      setState(() {
        _pwdError = 'A senha não atende a todos os requisitos.';
      });
    }

    if (_emailError == '' && _pwdError == '' && _confirmPwdError == '') {
      _createAccount(myAccountProvider);
    }
  }

  _createAccount(MyAccount myAccountProvider) {
    myAccountProvider.createAccount(
      _emailControler.text,
      _confirmPwdControler.text,
    );
    print(widget.orderID);
    print(widget.fromScreen);

    final Map<Type, void Function()> toScreen = {
      BuyCart:
          () => context.goNamed(
            'pagamento',
            pathParameters: {'orderID': widget.orderID},
          ),
      ServicesPage: () => context.goNamed('servicos'),
    };

    if (widget.fromScreen == AppBarPetShop) {
      context.goNamed('minha-conta');
    } else {
      toScreen[widget.fromScreen]?.call();
    }
  }

  void _validatePassword(String password) {
    setState(() {
      _upperCaseValidator =
          password.contains(RegExp(r'[A-Z]'))
              ? const Color.fromARGB(255, 21, 202, 163)
              : const Color.fromRGBO(227, 28, 70, 1);

      _lowerCaseValidator =
          password.contains(RegExp(r'[a-z]'))
              ? const Color.fromARGB(255, 21, 202, 163)
              : const Color.fromRGBO(227, 28, 70, 1);

      _numberValidator =
          password.contains(RegExp(r'[0-9]'))
              ? const Color.fromARGB(255, 21, 202, 163)
              : const Color.fromRGBO(227, 28, 70, 1);

      _caracterCountValidator =
          password.length >= 8
              ? const Color.fromARGB(255, 21, 202, 163)
              : const Color.fromRGBO(227, 28, 70, 1);
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
    _focusNodeConfirmPwd.addListener(() {
      setState(() {
        _confirmPwdBorderColor =
            _focusNodeConfirmPwd.hasFocus
                ? Theme.of(context).primaryColorDark
                : const Color.fromARGB(125, 0, 0, 0);
      });
    });

    _pwdControler.addListener(() {
      _validatePassword(_pwdControler.text);
    });
  }

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePwd.dispose();
    _focusNodeConfirmPwd.dispose();
    _confirmPwdControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool isButtonEnabled = true;
    MyAccount myAccountProvider = Provider.of<MyAccount>(
      context,
      listen: false,
    );

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
          Text(
            'Criar nova conta',
            style: TextStyle(
              fontFamily: 'NunitoSansBold',
              fontSize: screenSize.height * 0.032,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: screenSize.height * 0.03),
          Text(
            'Complete os campos com as suas informações',
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
          Container(
            height: screenSize.height * 0.03,
            width: screenSize.width * 0.38,
            alignment: Alignment.centerLeft,
            child: Text(
              _emailError,
              style: TextStyle(
                fontFamily: 'NunitoSansBold',
                fontSize: screenSize.height * 0.016,
                fontWeight: FontWeight.bold,
                letterSpacing: screenSize.width * 0.0001,
                color: const Color.fromRGBO(227, 28, 70, 1),
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
          Container(
            height: screenSize.height * 0.03,
            width: screenSize.width * 0.38,
            alignment: Alignment.centerLeft,
            child: Text(
              _pwdError,
              style: TextStyle(
                fontFamily: 'NunitoSansBold',
                fontSize: screenSize.height * 0.016,
                fontWeight: FontWeight.bold,
                letterSpacing: screenSize.width * 0.0001,
                color: const Color.fromRGBO(227, 28, 70, 1),
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.02),
          Container(
            width: screenSize.width * 0.4,
            height: screenSize.height * 0.06,
            decoration: BoxDecoration(
              border: Border.all(color: _confirmPwdBorderColor, width: 0.75),
              borderRadius: BorderRadius.circular(screenSize.height * 0.015),
            ),
            child: TextFormField(
              controller: _confirmPwdControler,
              style: TextStyle(
                fontFamily: 'NunitoSans',
                fontSize: screenSize.height * 0.02,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(190, 0, 0, 0),
              ),
              obscureText: _obscureTextConfirmPwd,
              focusNode: _focusNodeConfirmPwd,
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: screenSize.width * 0.005),
                  child: IconButton(
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(
                      _obscureTextConfirmPwd
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: const Color.fromARGB(175, 0, 0, 0),
                    ),
                    onPressed: () => _togglePasswordVisibility(true),
                  ),
                ),
                labelText: 'Confirme a senha',
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
          Container(
            height: screenSize.height * 0.03,
            width: screenSize.width * 0.38,
            alignment: Alignment.centerLeft,
            child: Text(
              _confirmPwdError,
              style: TextStyle(
                fontFamily: 'NunitoSansBold',
                fontSize: screenSize.height * 0.016,
                fontWeight: FontWeight.bold,
                letterSpacing: screenSize.width * 0.0001,
                color: const Color.fromRGBO(227, 28, 70, 1),
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(screenSize.width * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: screenSize.width * 0.075,
                      height: screenSize.height * 0.005,
                      color: _upperCaseValidator,
                    ),
                    SizedBox(height: screenSize.height * 0.01),
                    Text(
                      'Letra maiúscula',
                      style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontSize: screenSize.height * 0.018,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(190, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenSize.width * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: screenSize.width * 0.075,
                      height: screenSize.height * 0.005,
                      color: _lowerCaseValidator,
                    ),
                    SizedBox(height: screenSize.height * 0.01),
                    Text(
                      'Letra minúscula',
                      style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontSize: screenSize.height * 0.018,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(190, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenSize.width * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: screenSize.width * 0.075,
                      height: screenSize.height * 0.005,
                      color: _numberValidator,
                    ),
                    SizedBox(height: screenSize.height * 0.01),
                    Text(
                      '1 número',
                      style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontSize: screenSize.height * 0.018,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(190, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenSize.width * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: screenSize.width * 0.075,
                      height: screenSize.height * 0.005,
                      color: _caracterCountValidator,
                    ),
                    SizedBox(height: screenSize.height * 0.01),
                    Text(
                      '8 ou + caracteres',
                      style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontSize: screenSize.height * 0.018,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(190, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.03),
          ElevatedButton(
            onPressed:
                isButtonEnabled
                    ? () => _validateFields(myAccountProvider)
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
                'Criar conta',
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
            onPressed: () {},
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
