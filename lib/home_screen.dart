import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'motivasi_quote.dart';
import 'theme.dart';
import 'pomodoro_timer.dart';

class Task {
  final String title;
  final DateTime? deadline;
  bool isCompleted;

  Task({
    required this.title,
    this.deadline,
    this.isCompleted = false,
  });
}

class MoodoHomePage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const MoodoHomePage({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  State<MoodoHomePage> createState() => _MoodoHomePageState();
}

class _MoodoHomePageState extends State<MoodoHomePage> {
  final TextEditingController _taskController = TextEditingController();
  final List<Task> _tasks = [];
  DateTime? _selectedDeadline;
  final MotivasiQuote _motivasiQuote = MotivasiQuote();

  void _addTask() {
    final newTask = _taskController.text.trim();
    if (newTask.isNotEmpty) {
      setState(() {
        _tasks.add(Task(
          title: newTask,
          deadline: _selectedDeadline,
        ));
        _taskController.clear();
        _selectedDeadline = null;
        _motivasiQuote.showRandomQuote();
      });
    }
  }

  void _completeTask(int index) {
    final completedTask = _tasks[index];
    setState(() {
      _tasks.removeAt(index);
      _motivasiQuote.showRandomQuote();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Tugas "${completedTask.title}" selesai! Semangat terus!',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: widget.isDarkMode ? Colors.grey[500] : Colors.pink[300],
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _selectDeadline(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDeadline = picked;
      });
    }
  }

  void _showPomodoroTimer(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const PomodoroTimer(),
    );
  }

  Widget _buildTaskInput() {
    final isDark = widget.isDarkMode;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900]?.withOpacity(0.9) : Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _taskController,
                    style: TextStyle(
                      fontSize: 18,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Tugas baru',
                      hintStyle: TextStyle(
                        color: isDark ? Colors.white38 : Colors.black54,
                      ),
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _addTask(),
                  ),
                ),
              ),
              IconButton(
                icon: const Text(
                  '+',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFF48FB1),
                  ),
                ),
                onPressed: _addTask,
                splashRadius: 24,
                tooltip: 'Tambah tugas baru',
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () => _selectDeadline(context),
                  child: Text(
                    _selectedDeadline == null
                        ? 'Tambahkan deadline'
                        : 'Deadline: ${DateFormat('dd/MM/yyyy').format(_selectedDeadline!)}',
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(int index) {
    final task = _tasks[index];
    final isDark = widget.isDarkMode;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[800] : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.timer,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                  onPressed: () => _showPomodoroTimer(context),
                  tooltip: 'Mulai Pomodoro Timer',
                ),
                Checkbox(
                  value: task.isCompleted,
                  onChanged: (bool? value) {
                    if (value == true) {
                      _completeTask(index);
                    }
                  },
                  activeColor: const Color(0xFF9E9E9E),
                ),
              ],
            ),
            if (task.deadline != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 18,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Deadline: ${DateFormat('dd/MM/yyyy').format(task.deadline!)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    const Spacer(),
                    if (task.deadline!.isBefore(DateTime.now()))
                      Text(
                        'Terlambat',
                        style: TextStyle(
                          color: Colors.red[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskList() {
    final theme = Theme.of(context);
    final isDark = widget.isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900]?.withOpacity(0.9) : Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: _tasks.isEmpty
          ? Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          'Tidak ada tugas',
          style: theme.textTheme.titleLarge?.copyWith(
            color: isDark ? Colors.white38 : Colors.black38,
          ),
          textAlign: TextAlign.center,
        ),
      )
          : Column(
        children: List.generate(
          _tasks.length,
              (index) => _buildTaskItem(index),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = widget.isDarkMode;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF121212), const Color(0xFF424242)]
                : [const Color(0xFFE88DB0), const Color(0xFF7B57C9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.only(top: 40, left: 24, right: 24, bottom: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'MOODO',
                  style: theme.textTheme.displayLarge?.copyWith(
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.timer,
                        color: isDark ? Colors.white : Colors.black,
                        size: 28,
                      ),
                      onPressed: () => _showPomodoroTimer(context),
                      tooltip: 'Pomodoro Timer',
                    ),
                    IconButton(
                      icon: Icon(
                        isDark ? Icons.nightlight_round : Icons.wb_sunny,
                        color: isDark ? Colors.white : Colors.black,
                        size: 28,
                      ),
                      onPressed: widget.onToggleTheme,
                      tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 24),
                        Container(
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.grey[850]?.withOpacity(0.9)
                                : const Color(0xFFE0C7F0).withOpacity(0.9),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                          child: Column(
                            children: [
                              Text(
                                'Motivasi Harian',
                                style: theme.textTheme.displayMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _motivasiQuote.currentQuote,
                                style: theme.textTheme.bodyLarge,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildTaskInput(),
                        const SizedBox(height: 24),
                        _buildTaskList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}