import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:petshop/screens/services.dart';
import 'package:petshop/screens/home_products_page.dart';
import 'package:petshop/providers/selected_screen_provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final GlobalKey _menuKey = GlobalKey();
  final List<GlobalKey> _itemKeys = [];
  OverlayEntry? _overlayEntry;
  bool _isMouseInsideMenu = false;
  bool _isMouseOverItem = false;

  late List<bool> _itemIsHovered;
  late Map<String, List<String>> _mainCategories;
  late Map<String, Widget> _selection;

  @override
  void initState() {
    _mainCategories = {
      'Cachorro': ['Cães'],
      'Gato': ['Gatos'],
      'Pássaro': ['Pássaro'],
      'Peixe': ['Peixe'],
      'Outros Pets': ['Outros Pets'],
      'Casa e Jardim': ['Casa e Jardim'],
      'Promoções': ['Promoção'],
    };
    ScrollController scrollController = ScrollController();

    _selection = {
      for (var entry in _mainCategories.entries)
        entry.key: HomeProductsPage(
          filteredItems: entry.value,
          scrollController: scrollController,
        ),
      'Serviços': const ServicesPage(),
    };

    _itemIsHovered = List.filled(_selection.length, false);
    _itemKeys.addAll(List.generate(_selection.length, (_) => GlobalKey()));
    super.initState();
  }

  void _updateHoveredItem(int index, bool isHovered) {
    setState(() {
      for (int i = 0; i < _itemIsHovered.length; i++) {
        _itemIsHovered[i] = i == index && isHovered;
      }
    });
  }

  void _showSubMenu(
    BuildContext context,
    Offset position,
    List<String> options,
    Size screenSize,
    String parentCategory,
    SelectScreen selectedScreen,
  ) {
    _removeMenu(selectedScreen);
    _overlayEntry = OverlayEntry(
      builder:
          (context) => Consumer<SelectScreen>(
            builder: (_, foo, child) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                selectedScreen.updateHovering(true);
              });
              return Stack(
                children: [
                  Positioned(
                    top: position.dy + 38,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child:
                        selectedScreen.isHoveringOptions
                            ? GestureDetector(
                              onTap: () => _removeMenu(selectedScreen),
                              child: Container(
                                color: Colors.black.withOpacity(0.5),
                              ),
                            )
                            : const SizedBox.shrink(),
                  ),
                  Positioned(
                    left: position.dx,
                    top: position.dy + 38,
                    child: MouseRegion(
                      onEnter: (_) => _isMouseInsideMenu = true,
                      onExit: (_) {
                        _isMouseInsideMenu = false;
                        _scheduleMenuRemoval(selectedScreen);
                      },
                      child: Material(
                        key: _menuKey,
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(screenSize.height * 0.01),
                          bottomRight: Radius.circular(
                            screenSize.height * 0.01,
                          ),
                        ),
                        child: Container(
                          width: screenSize.width * 0.2,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children:
                                options.map((option) {
                                  return MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: screenSize.width * 0.005,
                                      ),
                                      child: InkWell(
                                        onHover: (hovering) {
                                          hovering
                                              ? selectedScreen
                                                  .updateBottomBarMenuSelection(
                                                    option,
                                                  )
                                              : selectedScreen
                                                  .updateBottomBarMenuSelection(
                                                    '',
                                                  );
                                        },
                                        hoverColor: const Color.fromARGB(
                                          56,
                                          21,
                                          202,
                                          163,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          screenSize.height * 0.05,
                                        ),
                                        onTap: () {
                                          _removeMenu(selectedScreen);
                                          final combinedCategories = [
                                            ..._mainCategories[parentCategory]!,
                                            option,
                                          ];
                                          context.goNamed(
                                            'produtos',
                                            queryParameters: {
                                              'filtro': combinedCategories,
                                            },
                                          );
                                        },
                                        child: AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 250,
                                          ),
                                          curve: Curves.easeInOut,
                                          padding: EdgeInsets.symmetric(
                                            vertical: screenSize.height * 0.015,
                                            horizontal:
                                                screenSize.height * 0.025,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AnimatedDefaultTextStyle(
                                                duration: const Duration(
                                                  milliseconds: 250,
                                                ),
                                                style: TextStyle(
                                                  fontFamily: 'NunitoSans',
                                                  letterSpacing:
                                                      screenSize.width *
                                                      0.00075,
                                                  fontSize:
                                                      screenSize.height * 0.018,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      selectedScreen
                                                                  .bottomBarMenuSelection ==
                                                              option
                                                          ? Theme.of(
                                                            context,
                                                          ).primaryColorDark
                                                          : Colors.black,
                                                ),
                                                child: Text(option),
                                              ),
                                              AnimatedSwitcher(
                                                duration: const Duration(
                                                  milliseconds: 250,
                                                ),
                                                transitionBuilder:
                                                    (child, animation) =>
                                                        FadeTransition(
                                                          opacity: animation,
                                                          child: child,
                                                        ),
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  // key: ValueKey(isHovered),
                                                  weight: 100,
                                                  size:
                                                      screenSize.height * 0.02,
                                                  color:
                                                      selectedScreen
                                                                  .bottomBarMenuSelection ==
                                                              option
                                                          ? Theme.of(
                                                            context,
                                                          ).primaryColorDark
                                                          : Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeMenu(SelectScreen selectedScreen) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      selectedScreen.updateHovering(false);
    });

    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _scheduleMenuRemoval(SelectScreen selectedScreen) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      selectedScreen.updateHovering(false);
    });
    Future.delayed(const Duration(milliseconds: 250), () {
      if (!_isMouseInsideMenu && !_isMouseOverItem && mounted) {
        _removeMenu(selectedScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final selectedScreen = Provider.of<SelectScreen>(context, listen: false);

    final dropdownOptions = {
      'Cachorro': ['Ração', 'Brinquedos', 'Camas', 'Coleiras', 'Comedouros'],
      'Gato': [
        'Ração',
        'Arranhadores',
        'Areia Sanitária',
        'Camas',
        'Comedouros',
        'Fontes',
      ],
      'Pássaro': ['Alimentos', 'Gaiolas', 'Acessórios'],
      'Peixe': ['Ração', 'Aquários'],
    };

    return SizedBox(
      // height: screenSize.height * 0.065,
      child: Padding(
        padding: EdgeInsets.only(top: screenSize.height * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: screenSize.width * 0.85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children:
                    _selection.keys.map((item) {
                      int index = _selection.keys.toList().indexOf(item);
                      return Column(
                        key: _itemKeys[index],
                        children: [
                          MouseRegion(
                            onEnter: (_) {
                              _isMouseOverItem = true;
                              if (dropdownOptions.containsKey(item)) {
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  final box =
                                      _itemKeys[index].currentContext
                                              ?.findRenderObject()
                                          as RenderBox?;
                                  if (box != null) {
                                    final position = box.localToGlobal(
                                      Offset.zero,
                                    );
                                    _showSubMenu(
                                      context,
                                      position,
                                      dropdownOptions[item]!,
                                      screenSize,
                                      item,
                                      selectedScreen,
                                    );
                                  }
                                });
                              }
                            },
                            onExit: (_) {
                              _isMouseOverItem = false;
                              _scheduleMenuRemoval(selectedScreen);
                            },
                            child: TextButton(
                              style: ButtonStyle(
                                overlayColor: WidgetStateProperty.all(
                                  Colors.transparent,
                                ),
                              ),
                              onHover:
                                  (hovering) =>
                                      _updateHoveredItem(index, hovering),
                              onPressed: () {
                                _removeMenu(selectedScreen);
                                item == _selection.keys.toList().last
                                    ? context.goNamed('servicos')
                                    : context.goNamed(
                                      'produtos',
                                      queryParameters: {
                                        'filtro': _mainCategories[item]!,
                                      },
                                    );
                              },
                              child: Text(
                                item,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: screenSize.height * 0.005,
                            ),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              height: screenSize.height * 0.003,
                              width:
                                  (screenSize.width * 0.85) /
                                  _itemIsHovered.length,
                              color:
                                  _itemIsHovered[index]
                                      ? Theme.of(context).primaryColorDark
                                      : Theme.of(
                                        context,
                                      ).scaffoldBackgroundColor,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
