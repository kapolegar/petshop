import 'dart:async';
import 'package:flutter/material.dart';

class ProductSlider extends StatefulWidget {
  @override
  _ProductSliderState createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  final PageController _pageController =
      PageController(viewportFraction: 0.8, initialPage: 1);
  int _currentIndex = 1;

  final List<Color> _cardColors = [
    const Color.fromRGBO(28, 227, 185, 1),
    const Color.fromRGBO(28, 227, 185, 1),
    const Color.fromRGBO(28, 227, 185, 1),
    const Color.fromRGBO(28, 227, 185, 1),
  ];

  List<Color> get _loopedColors =>
      [_cardColors.last, ..._cardColors, _cardColors.first];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Timer.periodic(const Duration(seconds: 15), (Timer timer) {
      if (_pageController.hasClients) {
        _nextPage();
      }
    });
  }

  void _nextPage() {
    if (_currentIndex < _loopedColors.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      _fixLoop();
    }
  }

  void _prevPage() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      _fixLoop();
    }
  }

  void _fixLoop() {
    Future.delayed(const Duration(milliseconds: 350), () {
      if (_currentIndex == _loopedColors.length - 1) {
        // Se estiver no último falso, volta para o primeiro real
        setState(() => _currentIndex = 1);
        _pageController.jumpToPage(1);
      } else if (_currentIndex == 0) {
        // Se estiver no primeiro falso, volta para o último real
        setState(() => _currentIndex = _loopedColors.length - 2);
        _pageController.jumpToPage(_loopedColors.length - 2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: screenSize.height * 0.15,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _loopedColors.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
              _fixLoop();
            },
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin:
                    EdgeInsets.symmetric(horizontal: screenSize.height * 0.015),
                decoration: BoxDecoration(
                  color: _loopedColors[index],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Card ${index == 0 ? _cardColors.length : index > _cardColors.length ? 1 : index}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              );
            },
          ),
          Positioned(
            left: screenSize.height * 0.178,
            top: screenSize.height * 0.044,
            child: IconButton(
              icon: Icon(
                Icons.arrow_circle_left_rounded,
                size: screenSize.height * 0.05,
                color: Theme.of(context).highlightColor,
              ),
              splashRadius: 1,
              onPressed: _prevPage,
            ),
          ),
          Positioned(
            right: screenSize.height * 0.187,
            top: screenSize.height * 0.044,
            child: IconButton(
              icon: Icon(
                Icons.arrow_circle_right_rounded,
                size: screenSize.height * 0.05,
                color: Theme.of(context).highlightColor,
              ),
              splashRadius: 1,
              onPressed: _nextPage,
            ),
          ),
        ],
      ),
    );
  }
}
