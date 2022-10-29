enum Tones {
  none('none', ''),
  alert('alert', 'mp3'),
  ding('ding', 'mp3'),
  doorbell('doorbell', 'wav'),
  doubleBell('double_bell', 'wav'),
  hello('hello', 'mp3'),
  greetings('greetings', 'mp3'),
  happyBells('happy_bells', 'wav'),
  harp('harp', 'mp3'),
  loudBeeps('loud_beeps', 'mp3'),
  magical('magical', 'mp3'),
  marbles('marbles', 'mp3'),
  messageOld('message_old', 'mp3'),
  message('message', 'mp3'),
  musicalAlert('musical_alert', 'wav'),
  positive('positive', 'wav'),
  pristine('pristine', 'mp3'),
  quickChime('quick_chime', 'wav'),
  relax('relax', 'mp3'),
  twinkle('twinkle', 'mp3');

  const Tones(this.name, this.type);

  final String name;
  final String type;
}
