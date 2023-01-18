import 'package:flutter/material.dart';
import 'package:frivia/providers/game_page_provider.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  late BuildContext _context;
  double? _deviceHeight, _deviceWidth;

  GamePageProvider? _pageProvider;

  GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    _context = context;
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    // _pageProvider = Provider.of<GamePageProvider>(context);
    print("--- GamePage.build() ---");
    context.watch<GamePageProvider>().questions;

    // List<dynamic>? questions =
    //     Provider.of<GamePageProvider>(context, listen: false).questions;
    return Text("Hi");
    // return _buildUI2();
    // return FutureBuilder<List<dynamic>?>(
    //     future: _pageProvider!.getQuestionsFromAPI(),
    //     builder: (context, AsyncSnapshot<List<dynamic>?> snapshot) {
    //       if (snapshot.hasData) {
    //         return _buildUI();
    //       } else {
    //         return Center(
    //             child: CircularProgressIndicator(
    //           color: Colors.white,
    //         ));
    //       }
    //     });
    // return _buildUI();
    // return ChangeNotifierProvider(
    //   create: (context) => GamePageProvider(context: context),
    //   child: _buildUI(),
    // );
  }

  Widget _buildUI2() {
    return Builder(builder: (context) {
      // _pageProvider!.getQuestionsFromAPI();
      // _pageProvider = context.watch<GamePageProvider>();
      // if (_pageProvider!.questions != null) {
      List<dynamic>? questions =
          Provider.of<GamePageProvider>(_context, listen: false).questions;
      if (questions != null) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
              child: _gameUI(),
            ),
          ),
        );
      } else {
        return Center(
            child: CircularProgressIndicator(
          color: Colors.white,
        ));
      }

      // return Scaffold(
      //   body: Consumer<GamePageProvider>(
      //     builder: (context, value, child) {
      //       print("--- _buildUI2 ---");
      //       if (questions != null) {
      //         return SafeArea(
      //           child: Container(
      //             padding:
      //                 EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
      //             child: _gameUI(),
      //           ),
      //         );
      //       } else {
      //         return Center(
      //             child: CircularProgressIndicator(
      //           color: Colors.white,
      //         ));
      //       }
      //     },
      //   ),
      // );
      // } else {
      //   return Center(
      //       child: CircularProgressIndicator(
      //     color: Colors.white,
      //   ));
      // }
    });
  }

  Widget _buildUI() {
    return Builder(builder: (context) {
      // _pageProvider!.getQuestionsFromAPI();
      // _pageProvider = context.watch<GamePageProvider>();
      if (_pageProvider!.questions != null) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
              child: _gameUI(),
            ),
          ),
        );
      } else {
        return Center(
            child: CircularProgressIndicator(
          color: Colors.white,
        ));
      }
    });
  }

  Widget _gameUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _questionText(),
        Column(
          children: [
            _trueButton(),
            SizedBox(height: _deviceHeight! * 0.01),
            _falseButton(),
          ],
        ),
      ],
    );
  }

  Widget _questionText() {
    String currentQuestion =
        Provider.of<GamePageProvider>(_context, listen: false)
            .getCurrentQuestionText();
    return Text(
      currentQuestion,
      style: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _trueButton() {
    return MaterialButton(
      onPressed: () {
        Provider.of<GamePageProvider>(_context, listen: false)
            .answerQuestion("True");
        // _pageProvider!.answerQuestion("True");
      },
      color: Colors.green,
      minWidth: _deviceWidth! * 0.8,
      height: _deviceHeight! * 0.1,
      child: Text(
        "True",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }

  Widget _falseButton() {
    return MaterialButton(
      onPressed: () {
        Provider.of<GamePageProvider>(_context, listen: false)
            .answerQuestion("False");
        // _pageProvider!.answerQuestion("False");
      },
      color: Colors.red,
      minWidth: _deviceWidth! * 0.8,
      height: _deviceHeight! * 0.1,
      child: Text(
        "False",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}
