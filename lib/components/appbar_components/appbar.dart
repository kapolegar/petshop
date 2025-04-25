import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:petshop/providers/my_account_provider.dart';
import 'package:petshop/providers/shopping_cart_provider.dart';
import 'package:petshop/providers/selected_screen_provider.dart';
import 'package:petshop/components/appbar_components/searchbar.dart';
import 'package:petshop/components/appbar_components/bottom_bar.dart';
import 'package:petshop/components/my_account_components/create_new_account.dart';

class AppBarPetShop extends StatefulWidget {
  final bool showBottom;
  final bool isOnHiddenScreen;
  final ScrollController scrollController;

  const AppBarPetShop({
    super.key,
    required this.scrollController,
    required this.showBottom,
    required this.isOnHiddenScreen,
  });

  @override
  State<AppBarPetShop> createState() => _AppBarPetShopState();
}

class _AppBarPetShopState extends State<AppBarPetShop> {
  bool cartIsPressed = false;
  bool accountIsPressed = false;
  bool contactIsPressed = false;
  bool _isHoveringAccountMenu = false;
  bool _mouseSobreAccountIcon = false;
  bool _mouseDentroAccountMenu = false;

  Offset? _accountMenuPosition;
  Offset? _accountIconPosition;

  OverlayEntry? _overlayAccountEntry;

  late List<GlobalKey> _itemKeys;
  final GlobalKey myAccountKey = GlobalKey();
  final GlobalKey myAccountMenuKey = GlobalKey();
  final GlobalKey overlayAccountKey = GlobalKey();

  late Map<String, dynamic> selection;
  final Map<String, bool> _isInsideAccountMenu = {
    'opened': false,
    'entered': false,
  };

  void _showAccountMenu(
    BuildContext context,
    Offset position,
    Size screenSize,
    double width,
    double height,
    SelectScreen selectedScreen,
  ) {
    _overlayAccountEntry?.remove();
    setState(() {
      _isHoveringAccountMenu = true;
      _accountMenuPosition = position;
    });

    MyAccount myAccountProvider = Provider.of<MyAccount>(
      context,
      listen: false,
    );

    _overlayAccountEntry = OverlayEntry(
      builder:
          (context) =>
              myAccountProvider.loggedUserInfos != null
                  ? Stack(
                    key: overlayAccountKey,
                    children: [
                      Positioned(
                        left: position.dx - 55,
                        top: position.dy + 40,
                        child: MouseRegion(
                          onEnter: (_) {
                            _mouseDentroAccountMenu = true;
                          },
                          onExit: (_) {
                            _mouseDentroAccountMenu = false;
                            Future.delayed(
                              const Duration(milliseconds: 200),
                              () {
                                if (!_mouseDentroAccountMenu &&
                                    !_mouseSobreAccountIcon &&
                                    mounted) {
                                  _removeAccountMenu();
                                }
                              },
                            );
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(
                              screenSize.height * 0.01,
                            ),
                            key: myAccountMenuKey,
                            color: Colors.white,
                            elevation: 0,
                            child: Container(
                              width: width,
                              height: height,
                              padding: EdgeInsets.all(
                                screenSize.height * 0.025,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Olá, ${myAccountProvider.loggedUserInfos!.nome.split(' ')[0]}!',
                                    style: TextStyle(
                                      fontFamily: 'NunitoSansBold',
                                      fontSize: screenSize.height * 0.02,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: screenSize.height * 0.015),
                                  ElevatedButton(
                                    onPressed: () {
                                      _removeAccountMenu();
                                      context.goNamed('minha-conta');
                                    },
                                    style: ButtonStyle(
                                      shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder
                                      >(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            screenSize.height * 0.01,
                                          ),
                                        ),
                                      ),
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                            Theme.of(context).primaryColorDark,
                                          ),
                                      overlayColor:
                                          WidgetStateProperty.all<Color>(
                                            Colors.transparent,
                                          ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * 0.02,
                                        vertical: screenSize.height * 0.02,
                                      ),
                                      child: Text(
                                        'Minha conta',
                                        style: TextStyle(
                                          fontFamily: 'NunitoSansBold',
                                          fontSize: screenSize.height * 0.018,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing:
                                              screenSize.width * 0.0001,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                  : Stack(
                    key: overlayAccountKey,
                    children: [
                      Positioned(
                        left: position.dx - 55,
                        top: position.dy + 40,
                        child: MouseRegion(
                          onEnter: (_) {
                            _mouseDentroAccountMenu = true;
                          },
                          onExit: (_) {
                            _mouseDentroAccountMenu = false;
                            Future.delayed(
                              const Duration(milliseconds: 200),
                              () {
                                if (!_mouseDentroAccountMenu &&
                                    !_mouseSobreAccountIcon &&
                                    mounted) {
                                  _removeAccountMenu();
                                }
                              },
                            );
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(
                              screenSize.height * 0.01,
                            ),
                            key: myAccountMenuKey,
                            color: Colors.white,
                            elevation: 0,
                            child: Container(
                              width: width,
                              height: height,
                              padding: EdgeInsets.all(
                                screenSize.height * 0.025,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _removeAccountMenu();
                                      context.goNamed(
                                        'login',
                                        extra: {
                                          'fromScreen': AppBarPetShop,
                                          'orderID': '12345',
                                        },
                                      );
                                    },
                                    style: ButtonStyle(
                                      shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder
                                      >(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            screenSize.height * 0.01,
                                          ),
                                        ),
                                      ),
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                            Theme.of(context).primaryColorDark,
                                          ),
                                      overlayColor:
                                          WidgetStateProperty.all<Color>(
                                            Colors.transparent,
                                          ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * 0.02,
                                        vertical: screenSize.height * 0.02,
                                      ),
                                      child: Text(
                                        'ENTRAR',
                                        style: TextStyle(
                                          fontFamily: 'NunitoSansBold',
                                          fontSize: screenSize.height * 0.018,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing:
                                              screenSize.width * 0.0001,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: screenSize.height * 0.02),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Não tem cadastro?',
                                        style: TextStyle(
                                          fontFamily: 'NunitoSans',
                                          fontSize: screenSize.height * 0.02,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing:
                                              screenSize.width * 0.0001,
                                          color: const Color.fromARGB(
                                            187,
                                            0,
                                            0,
                                            0,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          _removeAccountMenu;
                                          selectedScreen.changeScreen(
                                            const CreateNewAccount(),
                                          );
                                        },
                                        style: ButtonStyle(
                                          foregroundColor:
                                              WidgetStateProperty.resolveWith<
                                                Color
                                              >((Set<WidgetState> states) {
                                                if (states.contains(
                                                  WidgetState.hovered,
                                                )) {
                                                  return Theme.of(
                                                    context,
                                                  ).primaryColorDark;
                                                }
                                                return const Color.fromARGB(
                                                  187,
                                                  0,
                                                  0,
                                                  0,
                                                );
                                              }),
                                          overlayColor:
                                              WidgetStateProperty.all<Color>(
                                                Colors.transparent,
                                              ),
                                          surfaceTintColor:
                                              WidgetStateProperty.all<Color>(
                                                Colors.transparent,
                                              ),
                                        ),
                                        child: Text(
                                          'Criar conta',
                                          style: TextStyle(
                                            fontFamily: 'NunitoSansBold',
                                            fontSize: screenSize.height * 0.02,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
    );

    Overlay.of(context).insert(_overlayAccountEntry!);
  }

  _removeAccountMenu() {
    if (_overlayAccountEntry != null) {
      _overlayAccountEntry?.remove();
      _overlayAccountEntry = null;
      setState(() {
        _isHoveringAccountMenu = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    SelectScreen selectedScreen = Provider.of<SelectScreen>(
      context,
      listen: false,
    );
    ShoppingCartProvider shoppingCartProvider =
        Provider.of<ShoppingCartProvider>(context, listen: false);
    double myAccountWidth = screenSize.width * 0.18;
    double myAccountHeight = screenSize.height * 0.18;

    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      bottom:
          (widget.showBottom && !widget.isOnHiddenScreen)
              ? PreferredSize(
                preferredSize: Size.fromHeight(screenSize.height * 0.06),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const BottomBar(),
                    Container(
                      height: screenSize.height * 0.00075,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ],
                ),
              )
              : null,
      title: SizedBox(
        height: screenSize.height * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(width: screenSize.width * 0.05),
                ElevatedButton(
                  onPressed: () {
                    context.goNamed('home');
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: screenSize.width * 0.015),
                    child: Image.asset(
                      'assets/images/petshop_logo.png',
                      width: screenSize.height * 0.2,
                      height: screenSize.height * 0.2,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: screenSize.height * 0.05),
                      child: Text(
                        'FOFINHOS PETSHOP',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.75,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.02,
                            ),
                            child: const SearchBarPetShop(),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.12,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MouseRegion(
                                  onEnter: (_) {
                                    _mouseSobreAccountIcon = true;
                                    RenderBox? box =
                                        myAccountKey.currentContext
                                                ?.findRenderObject()
                                            as RenderBox?;
                                    if (box != null) {
                                      Offset position = box
                                          .localToGlobal(Offset.zero)
                                          .translate(0, 11);
                                      _showAccountMenu(
                                        context,
                                        position,
                                        screenSize,
                                        myAccountWidth,
                                        myAccountHeight,
                                        selectedScreen,
                                      );
                                    }
                                  },
                                  onExit: (_) {
                                    _mouseSobreAccountIcon = false;
                                    Future.delayed(
                                      const Duration(milliseconds: 200),
                                      () {
                                        if (!_mouseDentroAccountMenu &&
                                            !_mouseSobreAccountIcon &&
                                            mounted) {
                                          _removeAccountMenu();
                                        }
                                      },
                                    );
                                  },

                                  child: GestureDetector(
                                    onTapDown: (_) {
                                      setState(() {
                                        accountIsPressed = true;
                                      });
                                    },
                                    onTapUp: (_) {
                                      setState(() {
                                        accountIsPressed = false;
                                      });
                                    },
                                    onTapCancel: () {
                                      setState(() {
                                        accountIsPressed = false;
                                      });
                                    },
                                    child: IconButton(
                                      key: myAccountKey,
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.person,
                                        color:
                                            accountIsPressed
                                                ? Colors.white
                                                : Theme.of(
                                                  context,
                                                ).primaryColorDark,
                                        size: screenSize.height * 0.035,
                                      ),
                                      splashRadius: screenSize.height * 0.04,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTapDown: (_) {
                                    setState(() {
                                      contactIsPressed = true;
                                    });
                                  },
                                  onTapUp: (_) {
                                    setState(() {
                                      contactIsPressed = false;
                                    });
                                  },
                                  onTapCancel: () {
                                    setState(() {
                                      contactIsPressed = false;
                                    });
                                  },
                                  child: IconButton(
                                    onPressed: () {
                                      context.goNamed('contato');
                                    },
                                    icon: Icon(
                                      Icons.phone_enabled_rounded,
                                      color:
                                          contactIsPressed
                                              ? Colors.white
                                              : Theme.of(
                                                context,
                                              ).primaryColorDark,
                                      size: screenSize.height * 0.035,
                                    ),
                                    splashRadius: screenSize.height * 0.04,
                                  ),
                                ),
                                GestureDetector(
                                  onTapDown: (_) {
                                    setState(() {
                                      cartIsPressed = true;
                                    });
                                  },
                                  onTapUp: (_) {
                                    setState(() {
                                      cartIsPressed = false;
                                    });
                                  },
                                  onTapCancel: () {
                                    setState(() {
                                      cartIsPressed = false;
                                    });
                                  },
                                  child: Consumer<ShoppingCartProvider>(
                                    builder: (_, foo, child) {
                                      return SizedBox(
                                        height: screenSize.height * 0.08,
                                        width: screenSize.height * 0.08,
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                              child: IconButton(
                                                onPressed: () {
                                                  selectedScreen
                                                      .scaffoldKey
                                                      .currentState
                                                      ?.openEndDrawer();
                                                },
                                                icon: Icon(
                                                  Icons.shopping_cart_rounded,
                                                  color:
                                                      cartIsPressed
                                                          ? Colors.white
                                                          : Theme.of(
                                                            context,
                                                          ).primaryColorDark,
                                                  size:
                                                      screenSize.height * 0.035,
                                                ),
                                                splashRadius:
                                                    screenSize.height * 0.04,
                                              ),
                                            ),
                                            shoppingCartProvider
                                                        .totalCartItems ==
                                                    0
                                                ? const SizedBox()
                                                : Positioned(
                                                  bottom: 30,
                                                  right: 2,
                                                  child: Container(
                                                    height:
                                                        screenSize.height *
                                                        0.03,
                                                    width:
                                                        screenSize.height *
                                                        0.03,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            screenSize.height *
                                                                0.05,
                                                          ),
                                                      color:
                                                          Theme.of(
                                                            context,
                                                          ).primaryColor,
                                                    ),
                                                    child: Text(
                                                      shoppingCartProvider
                                                          .totalCartItems
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'NunitoSansBold',
                                                        fontSize:
                                                            screenSize.height *
                                                            0.015,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        letterSpacing:
                                                            screenSize.width *
                                                            0.0001,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
