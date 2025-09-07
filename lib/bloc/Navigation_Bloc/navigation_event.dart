abstract class NavigationEvent {}

class UpdateNavigation extends NavigationEvent {
  final int index;
  UpdateNavigation(this.index);
}
