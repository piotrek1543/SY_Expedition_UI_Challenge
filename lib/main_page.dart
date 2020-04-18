import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageOffsetNotifier with ChangeNotifier {
  double _offset = 0;
  double _page = 0;

  PageOffsetNotifier(PageController pageController) {
    pageController.addListener(() {
      _offset = pageController.offset;
      _page = pageController.page;
      notifyListeners();
    });
  }

  double get offset => _offset;

  double get page => _page;
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => PageOffsetNotifier(_pageController),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            PageView(
              controller: _pageController,
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                LeopardPage(),
                VulturePage(),
              ],
            ),
            LeopardImage(),
          ],
        ),
      ),
    );
  }
}

class LeopardImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(builder: (context, notifier, child) {
      return Positioned(
        top: 100,
        left: -notifier.offset,
        width: MediaQuery.of(context).size.width * 1.5,
        child: Image.asset('assets/leopard.png'),
      );
    });
  }
}

class LeopardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/leopard.png');
  }
}

class VulturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/vulture.png');
  }
}
