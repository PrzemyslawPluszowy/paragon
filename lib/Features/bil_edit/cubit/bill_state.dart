part of 'bill_cubit.dart';

class BillState extends Equatable {
  const BillState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];

  final bool isLoading;

  factory BillState.initail() {
    return const BillState(
      isLoading: false,
    );
  }

  BillState copyWith({isLoading}) {
    return BillState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
