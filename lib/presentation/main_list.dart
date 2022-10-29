import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/ContadorCubit/contador_cubit.dart';

class MainList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ContadorCubit cubit = BlocProvider.of<ContadorCubit>(context);

    return BlocBuilder<ContadorCubit, ContadorState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0),
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                height: 100,
                child: Dismissible(
                  background: Container(
                    color: Colors.red,
                  ),
                  key: ValueKey<dynamic>(cubit.getCars()[index]),
                  onDismissed: (DismissDirection direction) {
                    cubit.getCars().removeAt(index);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(cubit.getCars()[index].numeroDoCarro.toString()),
                      Text(cubit.getCars()[index].nomeDaEquipe),
                      Text(cubit.getCars()[index].getVoltas().toString()),
                      GestureDetector(
                        child: const Icon(Icons.arrow_upward),
                        onTap: () {
                          cubit.getCars()[index].increment();
                          cubit.rebuild();
                        },
                      ),
                      GestureDetector(
                        child: const Icon(Icons.arrow_downward),
                        onTap: () {
                          Icon(Icons.arrow_downward);
                          cubit.getCars()[index].decrement();
                          cubit.rebuild();
                        },
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: cubit.getListLenght(),
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        );
      },
    );
  }
}
