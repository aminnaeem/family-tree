// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:family_tree/model/family_member.dart' as _i5;
import 'package:family_tree/home/home_view.dart' as _i2;
import 'package:family_tree/memberdetails/memberdetails_view.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i6;

class Routes {
  static const homeView = '/';

  static const memberDetailView = '/member-detail-view';

  static const all = <String>{
    homeView,
    memberDetailView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.memberDetailView,
      page: _i3.MemberDetailView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i4.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.MemberDetailView: (data) {
      final args = data.getArgs<MemberDetailViewArguments>(nullOk: false);
      return _i4.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.MemberDetailView(
            key: args.key,
            index: args.index,
            member: args.member,
            onUpdate: args.onUpdate),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class MemberDetailViewArguments {
  const MemberDetailViewArguments({
    this.key,
    required this.index,
    required this.member,
    required this.onUpdate,
  });

  final _i4.Key? key;

  final int index;

  final _i5.FamilyMember member;

  final dynamic Function(
    int,
    _i5.FamilyMember,
  ) onUpdate;

  @override
  String toString() {
    return '{"key": "$key", "index": "$index", "member": "$member", "onUpdate": "$onUpdate"}';
  }

  @override
  bool operator ==(covariant MemberDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.index == index &&
        other.member == member &&
        other.onUpdate == onUpdate;
  }

  @override
  int get hashCode {
    return key.hashCode ^ index.hashCode ^ member.hashCode ^ onUpdate.hashCode;
  }
}

extension NavigatorStateExtension on _i6.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMemberDetailView({
    _i4.Key? key,
    required int index,
    required _i5.FamilyMember member,
    required dynamic Function(
      int,
      _i5.FamilyMember,
    ) onUpdate,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.memberDetailView,
        arguments: MemberDetailViewArguments(
            key: key, index: index, member: member, onUpdate: onUpdate),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMemberDetailView({
    _i4.Key? key,
    required int index,
    required _i5.FamilyMember member,
    required dynamic Function(
      int,
      _i5.FamilyMember,
    ) onUpdate,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.memberDetailView,
        arguments: MemberDetailViewArguments(
            key: key, index: index, member: member, onUpdate: onUpdate),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
