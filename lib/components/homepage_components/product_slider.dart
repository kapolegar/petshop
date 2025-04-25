import 'dart:async';
import 'package:flutter/material.dart';

class ProductSlider extends StatefulWidget {
  const ProductSlider({super.key});

  @override
  _ProductSliderState createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  final PageController _pageController = PageController(
    viewportFraction: 0.8,
    initialPage: 1,
  );
  int _currentIndex = 1;

  final List<String> _cardImages = [
    "images/banners/banner1.png",
    "images/banners/banner2.png",
    "images/banners/banner3.png",
    "images/banners/banner4.png",
  ];

  List<String> get _loopedImages => [
    _cardImages.last,
    ..._cardImages,
    _cardImages.first,
  ];

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
    if (_pageController.hasClients) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
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
      if (_currentIndex == _loopedImages.length - 1) {
        _pageController.jumpToPage(1);
        setState(() => _currentIndex = 1);
      } else if (_currentIndex == 0) {
        _pageController.jumpToPage(_loopedImages.length - 2);
        setState(() => _currentIndex = _loopedImages.length - 2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: screenSize.height * 0.25,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _loopedImages.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
              _fixLoop();
            },
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                margin: EdgeInsets.symmetric(
                  horizontal: screenSize.height * 0.015,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenSize.height * 0.04),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(screenSize.height * 0.04),
                  child: Image.asset(
                    _loopedImages[index],
                    height: screenSize.height * 0.25,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          Positioned(
            left: screenSize.height * 0.16,
            top: screenSize.height * 0.085,
            child: IconButton(
              icon: Icon(
                Icons.arrow_circle_left_rounded,
                size: screenSize.height * 0.05,
                color: Theme.of(context).primaryColorDark,
              ),
              splashRadius: 1,
              onPressed: _prevPage,
            ),
          ),
          Positioned(
            right: screenSize.height * 0.16,
            top: screenSize.height * 0.085,
            child: IconButton(
              icon: Icon(
                Icons.arrow_circle_right_rounded,
                size: screenSize.height * 0.05,
                color: Theme.of(context).primaryColorDark,
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
