part of 'task_service_cubit.dart';

@immutable
sealed class TaskServiceState {}

final class TaskServiceInitial extends TaskServiceState {}

final class TaskServiceLoading extends TaskServiceState {}

final class TaskServiceloded extends TaskServiceState {
  final List<TaskModel> tasks;
  TaskServiceloded(this.tasks);
}

final class TaskServiceError extends TaskServiceState {
  final String message;
  TaskServiceError(this.message);
}
