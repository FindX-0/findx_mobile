abstract interface class ServerTimeOffsetStore {
  Future<void> write(int value);

  Future<int?> read();
}
