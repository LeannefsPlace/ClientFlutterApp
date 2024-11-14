import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_flutter_app/data/model.dart';
import 'package:practice_flutter_app/domain/bloc/fact_block_bloc.dart';

class RandomFactScreen extends StatelessWidget {
  const RandomFactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Случайный факт'),
        actions: [
          const Text("Случайный факт"),
          TextButton(onPressed: () {
            Navigator.pushNamed(context, "/new");
          }, child: const Text("Добавить факт")),
        ],
      ),
      floatingActionButton: IconButton(onPressed: () {
        context.read<FactBlockBloc>().add(GetRandomFact());
      }, icon: const Icon(Icons.arrow_right)),
      body: BlocBuilder<FactBlockBloc, FactBlockState>(
        builder: (context, state) {
          if (state is FactLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FactLoaded) {
            final Fact fact = state.fact;
            return Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(fact.title, textAlign: TextAlign.left, 
                  style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 8),
                  Text(fact.body, textAlign: TextAlign.left, 
                  style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text("Категория: ${fact.category}", textAlign: TextAlign.left, 
                  style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    if (!state.graduated)
                    IconButton(onPressed: () {
                        context.read<FactBlockBloc>().add(DislikeFact(id: fact.id));
                      }, icon: const Icon(Icons.remove)),
                    Text("Оценка: ${fact.grade.toString()}"),
                    if (!state.graduated)
                    IconButton(onPressed: () {
                        context.read<FactBlockBloc>().add(LikeFact(id: fact.id));
                      }, icon: const Icon(Icons.add))
                   ], 
                  )
                ],
              )
            );
          } else if (state is FactLoadingError) {
            return Text(state.errorMessage);
          }
          else {
            return const Text("что то пошло не так...");
          }
        }
      )
    );
  }
}