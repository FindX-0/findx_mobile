enum DurationFormat {
  hhmmss,
  hhmmssShort,
  mmss,
  shortLabels,
}

String formatDuration(
  int durationInMillis, {
  DurationFormat format = DurationFormat.hhmmss,
}) {
  if (durationInMillis < 0) {
    return '';
  }

  return switch (format) {
    DurationFormat.hhmmssShort => _formatDurationHHMMSSShort(durationInMillis),
    DurationFormat.hhmmss => _formatDurationHHMMSS(durationInMillis),
    DurationFormat.mmss => _formatDurationMMSS(durationInMillis),
    DurationFormat.shortLabels => _formatDurationShortLabels(durationInMillis),
  };
}

String _formatDurationHHMMSSShort(int durationInMillis) {
  final duration = Duration(milliseconds: durationInMillis);

  String h = duration.inHours > 0 ? duration.inHours.toString() : '';
  String m = duration.inMinutes > 0 ? duration.inMinutes.remainder(60).toString() : '';
  String s = duration.inSeconds.remainder(60).toString();

  return '${h.isNotEmpty ? '$h:' : ''}${m.isNotEmpty ? '$m:' : ''}$s';
}

String _formatDurationMMSS(int durationInMillis) {
  final duration = Duration(milliseconds: durationInMillis);

  String m = _twoDigits(duration.inMinutes);
  String s = _twoDigits(duration.inSeconds.remainder(60));

  return '$m:$s';
}

String _formatDurationHHMMSS(int durationInMillis) {
  final duration = Duration(milliseconds: durationInMillis);

  String h = _twoDigits(duration.inHours);
  String m = _twoDigits(duration.inMinutes.remainder(60));
  String s = _twoDigits(duration.inSeconds.remainder(60));

  return '$h:$m:$s';
}

String _formatDurationShortLabels(int durationInMillis) {
  int seconds = durationInMillis ~/ 1000;
  final int hours = seconds ~/ 3600;
  seconds = seconds % 3600;
  final int minutes = seconds ~/ 60;
  seconds = seconds % 60;

  final hoursString = hours == 0 ? '' : '${hours}h';
  final hoursSeparator = hoursString.isEmpty ? '' : ' ';

  final minutesString = minutes == 0 ? '' : '${minutes}m';
  final minutesSeparator = minutesString.isEmpty ? '' : ' ';

  final secondsString = seconds == 0 ? '' : '${seconds}s';

  return '$hoursString$hoursSeparator$minutesString$minutesSeparator$secondsString';
}

String _twoDigits(int n) {
  return n.toString().padLeft(2, '0');
}
