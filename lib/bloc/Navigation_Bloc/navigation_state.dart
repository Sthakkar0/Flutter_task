abstract class NavigationState {}

class NavigationInitial extends NavigationState {}

class NavigationUpdated extends NavigationState {
  final int selectedIndex;
  NavigationUpdated(this.selectedIndex);
}
