import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_flutter_app/domain/bloc/fact_block_bloc.dart';

class FactForm extends StatefulWidget{
  const FactForm({super.key});
  
  @override
  State<StatefulWidget> createState() => FactFormState();
}

class FactFormState extends State<FactForm>{
    String? fact_title;
    String? fact_body;
    String? fact_category;


  @override
  Widget build(BuildContext context) {
    final _FactForm = GlobalKey<FormState>();
    TextEditingController TitleController = TextEditingController(text: fact_title);
    TextEditingController BodyController = TextEditingController(text: fact_body);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Случайный факт'),
        actions: [
          TextButton(onPressed: () {
            Navigator.pushNamed(context, "/");
          }, child: const Text("Случайный факт")),
          const Text("Добавить факт"),
        ],
      ),
      body: BlocBuilder<FactBlockBloc, FactBlockState>(
        builder: (context, state) {
          return Form(
        autovalidateMode: AutovalidateMode.always,
        key: _FactForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(alignment: Alignment.center,
            child:
            TextFormField(
              textAlign: TextAlign.center,
              onChanged: (value) => fact_title = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: TitleController,
              decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Введите название факта",
              fillColor: Colors.grey
            )
            ),
            ),
            Align(alignment: Alignment.center,
            child:  TextFormField(
              textAlign: TextAlign.center,
              onChanged: (value) => fact_body = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: BodyController,
              decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Введите описание факта",
              fillColor: Colors.grey
            ),)
            ),
            DropdownButton(
              items: dropdownItems,
              onChanged: (String? newValue){
                setState(() {
                  fact_category = newValue!;
                });
              },
              value: fact_category,
            ),
            ElevatedButton(
            onPressed: () {
              if (_FactForm.currentState!.validate() && fact_category != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Данные записаны!'))
                );
                context.read<FactBlockBloc>().add(WriteNewFact(title: fact_title!, body: fact_body!, category: fact_category!));
                Navigator.pushNamed(context, "/");
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Заполните данные до конца!'))
                );
              }
            },
            child: const Text('Submit'),
          ),
          ],
        ),
        );
      }
      )
    );
    } 
  }

List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "General", child: Text("General")),
    const DropdownMenuItem(value: "Animals", child: Text("Animals")),
    const DropdownMenuItem(value: "History", child: Text("History"))
  ];
  return menuItems;
  }