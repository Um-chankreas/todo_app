import 'package:todo_app/app/enum/status_msg.dart';

class AppRecord<T> {
  final LoadingStatus status;
  final String message;
  final String nextPageUrl;
  final T data;
  const AppRecord._({
    this.status = LoadingStatus.loading,
    this.message = "",
    this.nextPageUrl = "",
    required this.data,
  });
  // Success: replace current data
  factory AppRecord.success(
    T data, [
    String message = 'Success',
    String nextPageUrl = "",
  ]) {
    return AppRecord._(
      status: nextPageUrl.isEmpty
          ? LoadingStatus.noloadmore
          : LoadingStatus.success,
      data: data,
      message: message,
    );
  }
  // Load more: append to current list
  factory AppRecord.loadMore({
    required List<T> currentData,
    required List<T> newData,
    String nextPageUrl = "",
    String message = 'Load more',
  }) {
    final List<T> combined = [...currentData, ...newData];
    return AppRecord._(
      status: nextPageUrl.isEmpty
          ? LoadingStatus.noloadmore
          : LoadingStatus.success,
      data: combined as T,
      nextPageUrl: nextPageUrl,
      message: message,
    );
  }
  factory AppRecord.loading({
    required T defaultData,
    String message = 'Loading...',
  }) {
    return AppRecord._(
      status: LoadingStatus.loading,
      data: defaultData,
      message: message,
    );
  }
  // Error from server
  factory AppRecord.error({required T defaultData, String message = 'Error'}) {
    return AppRecord._(
      status: LoadingStatus.failed,
      data: defaultData,
      message: message,
    );
  }

  factory AppRecord.warning({
    required T defaultData,
    String message = 'Error',
  }) {
    return AppRecord._(
      status: LoadingStatus.warning,
      data: defaultData,
      message: message,
    );
  }
  bool get isSuccess => status == LoadingStatus.success;
  bool get isNoLoadMore => status == LoadingStatus.noloadmore;
  bool get isLoading => status == LoadingStatus.loading;
  bool get isLoadingMore => status == LoadingStatus.loadmore;
  bool get isError => status == LoadingStatus.failed;
  bool get isWarning => status == LoadingStatus.warning;
}
