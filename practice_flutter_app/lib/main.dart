import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_flutter_app/domain/bloc/fact_block_bloc.dart';
import 'package:practice_flutter_app/presentation/screen/new_fact.dart';
import 'package:practice_flutter_app/presentation/screen/random_fact.dart';

void main() {
  runApp(
    MaterialApp(
    routes: {
      '/': (context) => BlocProvider(
      create: (context) => FactBlockBloc()..add(GetRandomFact()),
      child: const RandomFactScreen(),
      ),
      '/new':(context) => BlocProvider(
      create: (context) => FactBlockBloc()..add(GetRandomFact()),
      child: const FactForm()
      ),
    },
    title: "oleg main",
    )
  );
}
