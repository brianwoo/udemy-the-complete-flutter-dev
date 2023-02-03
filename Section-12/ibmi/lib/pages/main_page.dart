import 'package:flutter/cupertino.dart';
import 'package:ibmi/pages/bmi_page.dart';
import 'package:ibmi/pages/history_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _tabs = [const BMIPage(), HistoryPage()];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("iBMI"),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
              ),
              label: "BMI",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.person,
              ),
              label: "History",
            )
          ],
        ),
        tabBuilder: (ctx, index) {
          return CupertinoTabView(
            builder: (context) => _tabs[index],
          );
        },
      ),
    );
  }
}
