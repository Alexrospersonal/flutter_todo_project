abstract interface class IsEnabledNotifier {
  bool canEnabled = false;
  bool isEnabled = false;
  void update<T extends IsEnabledNotifier>(T state);
}
