enum ScreenNotifierEvent {
  showPomodoroFinishSnackbar,
  showMuteAlertSnackbar;

  bool get isShowPomodoroFinishSnackbar => this == showPomodoroFinishSnackbar;
  bool get isShowMuteAlertSnackbar => this == showMuteAlertSnackbar;
}
