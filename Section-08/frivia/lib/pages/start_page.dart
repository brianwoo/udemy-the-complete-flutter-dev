import 'package:flutter/material.dart';
import 'package:frivia/pages/game_page.dart';
import 'package:frivia/providers/game_page_provider.dart';
import 'package:provider/provider.dart';

class StartPage extends StatelessWidget {
  double? _deviceHeight, _deviceWidth;
  GamePageProvider? _pageProvider;
  // late BuildContext _context;

  StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    // _context = context;

    return ChangeNotifierProvider<GamePageProvider>(
      create: (context) => GamePageProvider(),
      builder: (context, child) => _buildUI(),
    );

    // _pageProvider = Provider.of<GamePageProvider>(context);
    // return ChangeNotifierProvider(
    //   create: (context) => GamePageProvider(context: context),
    //   child: _buildUI(),
    // );
    // return _buildUI();
  }

  Widget _buildUI() {
    return Builder(builder: (context) {
      // _pageProvider = context.watch<GamePageProvider>();
      return Scaffold(
        body: SafeArea(
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _headingAndDifficulty(context),
                _difficultySlider(context),
                _startButton(context),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _headingAndDifficulty(BuildContext context) {
    return Column(
      children: [
        Text(
          "Frivia",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          Provider.of<GamePageProvider>(context, listen: false)
              .getDifficultyString(),
          // _pageProvider!.getDifficultyString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _difficultySlider(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.1),
      child: Slider(
        value: Provider.of<GamePageProvider>(context, listen: true)
            .getDifficulty(),
        // value: _pageProvider!.getDifficulty(),
        onChanged: (newDifficulty) {
          print("difficulty: " + newDifficulty.toString());
          // _pageProvider!.setDifficulty(newDifficulty);
          Provider.of<GamePageProvider>(context, listen: false)
              .setDifficulty(newDifficulty);
        },
        min: 0,
        max: 2,
        divisions: 2,
        label: "Difficulty",
      ),
    );
  }

  Widget _startButton(BuildContext context) {
    return MaterialButton(
      color: Colors.blue.shade500,
      minWidth: _deviceWidth! * 0.8,
      height: _deviceHeight! * 0.1,
      onPressed: () {
        Provider.of<GamePageProvider>(context, listen: false)
            .getQuestionsFromAPI()
            .then((value) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => GamePage()));
        });
        // _pageProvider!.getQuestionsFromAPI().then((value) {
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => GamePage()));
        // });
      },
      child: Text(
        "Start",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
