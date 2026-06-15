import 'package:flutter_riverpod/flutter_riverpod.dart';

final aiJobQueueProvider = StateNotifierProvider<AiJobQueueNotifier, Set<String>>((ref) {
  return AiJobQueueNotifier();
});

class AiJobQueueNotifier extends StateNotifier<Set<String>> {
  AiJobQueueNotifier() : super({});

  void addJob(String jobId) {
    state = {...state, jobId};
  }

  void removeJob(String jobId) {
    final newState = {...state};
    newState.remove(jobId);
    state = newState;
  }

  bool isJobActive(String jobId) {
    return state.contains(jobId);
  }

  bool get hasActiveJobs => state.isNotEmpty;
}
