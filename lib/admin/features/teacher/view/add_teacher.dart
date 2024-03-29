import 'package:education_system/admin/features/teacher/manager/add_teacher_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../auth/login/widgets/main_text_field.dart';
import '../../../../shared/utils/colors.dart';

class AddTeacher extends StatelessWidget {
  const AddTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTeacherCubit(),
      child: BlocConsumer<AddTeacherCubit, AddTeacherState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final AddTeacherCubit cubit = AddTeacherCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title: const Text(
                    'Add Teacher',style: TextStyle(color: ColorsAsset.kPrimary),
                ),
                centerTitle: true,
              ),
              body:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/Cream and Black Simple Education Logo (7).png",
                        height: 250,)),
                  const SizedBox(height: 15,),
                  MainTextField(
                    controller: cubit.teacherNameController,
                    hintText: "Teacher Name",),
                  const SizedBox(height: 15,),
                  MainTextField(
                    controller: cubit.teacherEmailController,
                    hintText: "Teacher Email",),
                  const SizedBox(height: 15,),
                  MainTextField(
                    controller: cubit.teacherPasswordController,
                    hintText: "Teacher Password",),
                  const SizedBox(height: 15,),

                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width*0.3,
                    child: DropdownButtonFormField<String>(
                      value: cubit.selectedSubject,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:ColorsAsset.kPrimary,
                          ),
                        ),
                        labelText: "Choose Subject",
                      ),
                      items: cubit.subjects.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        cubit.handleSubjectChange(newValue!);
                      },
                    ),
                  ),
                  const SizedBox(height: 15,),

                  ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsAsset.kPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Border radius
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                      child: Text(
                        'Add teacher',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )


                ],
              )

          );
        },
      ),
    );
  }
}
