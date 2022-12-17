int getSafeMonth(int month) {
  if (month > 12) {
    return 1;
  } else if (month < 1) {
    return 12;
  } else {
    return month;
  }
}
