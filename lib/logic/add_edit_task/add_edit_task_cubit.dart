import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sptimer/common/error/errors.dart';
import 'package:sptimer/common/events_bus/events.dart';
import 'package:sptimer/common/events_bus/events_bus.dart';
import 'package:sptimer/common/id_generator.dart';
import 'package:sptimer/data/repositories/tasks_repository.dart';
import 'package:sptimer/data/models/task.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sptimer/data/enums/tones.dart';
import 'package:sptimer/data/models/task.dart';

import 'package:just_audio/just_audio.dart';
import 'package:real_volume/real_volume.dart';
import 'package:sptimer/data/services/pomodoro_sound_player.dart';

part 'add_edit_task_state.dart';
part 'add_edit_task_cubit.freezed.dart';

final class AddEditTaskCubit extends Cubit<AddEditTaskState> {
  AddEditTaskCubit({
    required TasksRepository tasksRepository,
    required Task? task,
  })  : _tasksRepository = tasksRepository,
        super(AddEditTaskState.initial(task)) {
    _audioPlayer.init();
  }

  final TasksRepository _tasksRepository;
  final _audioPlayer = PomodoroSoundPlayer();

  Future<void> addOrEdit() async {
    final isValid = state.title.isNotEmpty;
    if (!isValid) return;

    final task = state.toTask();
    late GlobalEvent event;

    if (state.isEditing) {
      await _tasksRepository.update(task);
      event = TaskEditedEvent(task);
    } else {
      await _tasksRepository.add(task);
      event = TaskAddedEvent(task);
    }

    EventsBus.fire(event);
  }

  // UI customization update methods
  void updateTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void updateWorkDuration(Duration duration) {
    emit(state.copyWith(workDuration: duration));
  }

  void updateShortBreakDuration(Duration duration) {
    emit(state.copyWith(shortBreakDuration: duration));
  }

  void updateLongBreakDuration(Duration duration) {
    emit(state.copyWith(longBreakDuration: duration));
  }

  void updateMaxPomodoroRound(int rounds) {
    emit(state.copyWith(maxPomodoroRound: rounds));
  }

  void toggleVibrate() {
    emit(state.copyWith(vibrate: !state.vibrate));
  }

  Future<void> updateTone(Tones tone) async {
    emit(state.copyWith(tone: tone));
    await _playTone(tone);
  }

  Future<void> updateToneVolume(double volume) async {
    emit(state.copyWith(toneVolume: volume));
    await _audioPlayer.setVolume(volume);
  }

  Future<void> updateStatusVolume(double volume) async {
    emit(state.copyWith(statusVolume: volume));
    await RealVolume.setVolume(volume, streamType: StreamType.MUSIC);
  }

  void toggleReadStatusAloud() {
    emit(state.copyWith(readStatusAloud: !state.readStatusAloud));
  }

  Future<void> _playTone(Tones tone) async {
    if (state.toneVolume == 0.0) return;
    if (await _audioPlayer.cantPlaySound()) {
      emit(
        state.copyWith(
          error: SoundSettingsSetMutedError(),
        ),
      );
      return;
    }

    await _audioPlayer.playTone(tone);
  }

  @override
  Future<void> close() async {
    await _audioPlayer.dispose();
    return super.close();
  }
}

final class SoundSettingsSetMutedError extends AppError {}
