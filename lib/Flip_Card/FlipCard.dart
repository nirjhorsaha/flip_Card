import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Flipcard extends StatefulWidget {
  const Flipcard({super.key});

  @override
  State<Flipcard> createState() => _FlipcardState();
}

class _FlipcardState extends State<Flipcard> {
  int _currentCardIndex = 0;
  bool _lessonCompleted = false;
  double progressValue = 0.0;

  bool get allCardsCompleted => _currentCardIndex == frontContents.length - 1;

  final List<String> frontContents = [
    '국기',
    '줄여서',
    '일정',
    '줄었다',
    '연령',
    '과거',
    '정년퇴임',
    '사회',
    '정년퇴임',
    '문맹',
  ];
  final Map<String, List<String>> backContents = {
    'english': [
      'Flag',
      'Shortly',
      'Schedule',
      'Reduced',
      'Age',
      'Past',
      'Retirement',
      'Society',
      'Urbanization',
      'Illiteracy',
    ],
    'bangla': [
      'পতাকা',
      'শীঘ্রই',
      'সময়সূচী',
      'হ্রাস',
      'বয়স',
      'অতীত',
      'অবসর',
      'সমাজ',
      'নগরায়ন',
      'নিরক্ষরতা',
    ],
  };

  void goToNextCard() {
    setState(() {
      if (_currentCardIndex < frontContents.length - 1) {
        _currentCardIndex++;
        print('Current Index: $_currentCardIndex');
      }
    });
  }

  void goToPreviousCard() {
    setState(() {
      if (_currentCardIndex > 0) {
        _currentCardIndex--;
      }
    });
  }

  String getProgressFraction() {
    return "${_currentCardIndex + 1}/${frontContents.length}";
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    double progressValue = (_currentCardIndex + 1) / frontContents.length;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: size.height * .5,
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
            ),
            SafeArea(
              // bottom: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IntrinsicHeight(
                      child: Stack(
                        children: [
                          Align(
                            child: Text(
                              '',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                          Positioned(
                            left: 0,
                            child: CustomIconButton(
                              height: 25,
                              width: 25,
                              onTap: () => Navigator.pop(context),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 280,
                              height: 300,
                              child: FlipCard(
                                front: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      frontContents[_currentCardIndex],
                                      style: TextStyle(fontSize: 30),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                back: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        backContents['english']![
                                            _currentCardIndex],
                                        style: TextStyle(fontSize: 30),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        backContents['bangla']![
                                            _currentCardIndex],
                                        style: TextStyle(fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Cards: ${getProgressFraction()}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigoAccent,
                              ),
                            ),
                            SizedBox(height: 20),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Container(
                                height: 10,
                                width: 200,
                                child: LinearProgressIndicator(
                                  value: progressValue,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.indigoAccent),
                                  backgroundColor: Colors.grey[300],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            _lessonCompleted
                                ? Text(
                                    'Lesson 1 Complete',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  )
                                : allCardsCompleted
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          OutlinedButton.icon(
                                            onPressed: goToPreviousCard,
                                            icon: Icon(Icons.arrow_back_ios),
                                            label: Text('Prev'),
                                          ),
                                          SizedBox(width: 20),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                _lessonCompleted = true;
                                              });
                                              print('All cards are completed!');
                                            },
                                            child: Text('Complete'),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          OutlinedButton(
                                            onPressed: _currentCardIndex > 0
                                                ? goToPreviousCard
                                                : null,
                                            child: Row(
                                              children: [
                                                Icon(Icons.arrow_back_ios),
                                                SizedBox(width: 10),
                                                Text('Prev'),
                                              ],
                                            ),
                                          ),
                                          OutlinedButton(
                                            onPressed: allCardsCompleted
                                                ? null
                                                : goToNextCard,
                                            child: Row(
                                              children: [
                                                Text(allCardsCompleted
                                                    ? 'Complete'
                                                    : 'Next'),
                                                SizedBox(width: 10),
                                                Icon(Icons.arrow_forward_ios),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  final Color? color;
  final VoidCallback onTap;

  const CustomIconButton({
    Key? key,
    required this.child,
    required this.height,
    required this.width,
    this.color = Colors.white,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        child: Center(child: child),
        onTap: onTap,
      ),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 2.0,
            spreadRadius: .05,
          ), //BoxShadow
        ],
      ),
    );
  }
}

void main() {
  runApp(Flipcard());
}
