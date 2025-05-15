// pomodoro_timer.dart
import 'package:flutter/material.dart';

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({super.key});

  @override
  State<PomodoroTimer> createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  int _workDuration = 25; // 25 menit kerja
  int _breakDuration = 5; // 5 menit istirahat
  int _secondsRemaining = 25 * 60;
  bool _isWorking = true;
  bool _isRunning = false;
  late String _currentPhase;

  @override
  void initState() {
    super.initState();
    _currentPhase = "Kerja";
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
    });
    _tick();
  }

  void _pauseTimer() {
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    setState(() {
      _isRunning = false;
      _isWorking = true;
      _secondsRemaining = _workDuration * 60;
      _currentPhase = "Kerja";
    });
  }

  void _tick() {
    if (!_isRunning) return;

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
          _tick();
        } else {
          _switchPhase();
        }
      });
    });
  }

  void _switchPhase() {
    setState(() {
      _isWorking = !_isWorking;
      _currentPhase = _isWorking ? "Kerja" : "Istirahat";
      _secondsRemaining = (_isWorking ? _workDuration : _breakDuration) * 60;
    });
    _tick();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Pomodoro Timer - $_currentPhase'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _formatTime(_secondsRemaining),
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (!_isRunning)
                ElevatedButton(
                  onPressed: _startTimer,
                  child: const Text('Mulai'),
                )
              else
                ElevatedButton(
                  onPressed: _pauseTimer,
                  child: const Text('Jeda'),
                ),
              ElevatedButton(
                onPressed: _resetTimer,
                child: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}