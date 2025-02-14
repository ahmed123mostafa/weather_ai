import 'package:flutter/material.dart';
import 'package:flutter_weather_ai/core/botton/custom_botton.dart';
import 'package:flutter_weather_ai/core/color/color.dart';
import 'package:flutter_weather_ai/feature/auth/view/pages/sign_up.dart';
import 'package:flutter_weather_ai/feature/auth/view/pages/signin.dart';

class OnboardingScreen extends StatefulWidget {
  final int initialPage;

  const OnboardingScreen({Key? key, this.initialPage = 0}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.jumpToPage(widget.initialPage);
      // _controller.animateToPage(
      //   widget.initialPage,
      //   duration: const Duration(milliseconds: 300),
      //   curve: Curves.easeInOut,
      // );
      _currentPage = widget.initialPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: _currentPage == 1
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.secondary,
                  size: 24,
                ),
                onPressed: () {
                  _controller.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              )
            : null,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                _buildPage(
                  'Welcome to weather App',
                  'weather application',
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                  imagePath: 'assets/images/weather1.png',
                ),
                _buildPage(
                  'We provide best weather to family',
                  '',
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed.',
                  imagePath: 'assets/images/R.png',
                ),
                _buildPage(
                  'Fast to now weather',
                  '',
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                  imagePath:
                      "assets/images/weather-clouds-icon-1024x1014-px4l83ai.png",
                  isLast: true,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildPageIndicator(),
          ),
          if (_currentPage < 2)
            Padding(
              padding: const EdgeInsets.all(30),
              child: ReusableButton(
                text: 'NEXT',
                onPressed: () {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 30),
              child: Column(
                children: [
                  ReusableButton(
                    text: 'CREATE AN ACCOUNT',
                    color: Colors.black,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpView(),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ReusableButton(
                    text: 'LOGIN  ',
                    color: Colors.white,
                    isOutlined: true,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInView(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: 6,
          width: 23,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? AppColors.activeColorIndicator
                : AppColors.inActiveColorIndicator,
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
  }

  Widget _buildPage(String title, String subtitle, String description,
      {required String imagePath, bool isLast = false}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isPortrait =
            MediaQuery.of(context).orientation == Orientation.portrait;

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isPortrait)
                Flexible(
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 340,
                    fit: BoxFit.contain,
                  ),
                ),
              Text(
                title,
                style: TextStyle(
                  fontSize: isPortrait ? 24 : 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.center,
              ),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    fontFamily: 'Inter',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              SizedBox(height: isPortrait ? 10 : 0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black45,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
