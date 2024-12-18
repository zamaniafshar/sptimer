import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sptimer/config/routes/routes_name.dart';
import 'package:sptimer/config/theme/themes.dart';
import 'package:sptimer/utils/extensions/extensions.dart';

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
    final localization = context.localization;

    return IntroductionScreen(
      pages: [
        PageViewModel(
          image: Image.asset(
            'assets/images/app_vector.png',
            fit: BoxFit.contain,
          ),
          title: localization.appIntroductionAppMotto,
          body: localization.appIntroductionAppDescription,
          decoration: _pageViewModelDecoration,
        ),
        PageViewModel(
          image: Image.asset(
            'assets/images/pomodoro.png',
            fit: BoxFit.contain,
          ),
          decoration: _pageViewModelDecoration,
          title: localization.appIntroductionWhatIsPomodoro,
          body: localization.appIntroductionWhatIsPomodoroDescription,
        ),
        PageViewModel(
          image: Image.asset(
            'assets/images/how_to_use.png',
            fit: BoxFit.contain,
          ),
          title: localization.appIntroductionHowToUse,
          body: localization.appIntroductionHowToUseDescription,
          decoration: _pageViewModelDecoration,
        ),
      ],
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        spacing: const EdgeInsets.symmetric(horizontal: 5.0),
        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
      done: Text(localization.appIntroductionDone),
      onDone: () => goToHomePage(context),
      onSkip: () => goToHomePage(context),
      next: const Icon(Icons.arrow_forward),
      skip: Text(localization.appIntroductionSkip),
      showSkipButton: true,
    );
  }
}
