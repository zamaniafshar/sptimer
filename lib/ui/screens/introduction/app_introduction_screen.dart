import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sptimer/config/localization/app_localization.dart';
import 'package:sptimer/config/routes/routes_name.dart';

const _pageViewModelDecoration = PageDecoration(
  bodyAlignment: Alignment.center,
  imageAlignment: Alignment.center,
  imageFlex: 3,
  bodyFlex: 2,
  bodyPadding: EdgeInsets.zero,
  contentMargin: EdgeInsets.symmetric(horizontal: 16),
);

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({Key? key}) : super(key: key);

  void goToHomePage(BuildContext context) {
    Navigator.pushReplacementNamed(context, RoutesName.baseScreen);
  }

  @override
  Widget build(BuildContext context) {
    final appTexts = AppLocalization.of(context);

    return IntroductionScreen(
      pages: [
        PageViewModel(
          image: Image.asset(
            'assets/images/app_vector.png',
            fit: BoxFit.contain,
          ),
          title: appTexts.appIntroductionAppMotto,
          body: appTexts.appIntroductionAppDescription,
          decoration: _pageViewModelDecoration,
        ),
        PageViewModel(
          image: Image.asset(
            'assets/images/pomodoro.png',
            fit: BoxFit.contain,
          ),
          decoration: _pageViewModelDecoration,
          title: appTexts.appIntroductionWhatIsPomodoro,
          body: appTexts.appIntroductionWhatIsPomodoroDescription,
        ),
        PageViewModel(
          image: Image.asset(
            'assets/images/how_to_use.png',
            fit: BoxFit.contain,
          ),
          title: appTexts.appIntroductionHowToUse,
          body: appTexts.appIntroductionHowToUseDescription,
          decoration: _pageViewModelDecoration,
        ),
      ],
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        spacing: const EdgeInsets.symmetric(horizontal: 5.0),
        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
      done: Text(appTexts.appIntroductionDone),
      onDone: () => goToHomePage(context),
      onSkip: () => goToHomePage(context),
      next: const Icon(Icons.arrow_forward),
      skip: Text(appTexts.appIntroductionSkip),
      showSkipButton: true,
    );
  }
}
