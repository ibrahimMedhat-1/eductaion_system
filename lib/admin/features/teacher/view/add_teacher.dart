import 'package:education_system/admin/features/teacher/manager/add_teacher_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../auth/login/widgets/main_text_field.dart';
import '../../../../components/locale/applocale.dart';
import '../../../../shared/utils/colors.dart';

class AddTeacher extends StatelessWidget {
  const AddTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTeacherCubit()..getSubjects(),
      child: BlocConsumer<AddTeacherCubit, AddTeacherState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final AddTeacherCubit cubit = AddTeacherCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title:  Text(
                  '${getLang(context,  "Add Teacher")}'
                  ,
                  style: const TextStyle(color: ColorsAsset.kPrimary),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/Cream and Black Simple Education Logo (7).png",
                            height: 250,
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      MainTextField(
                        textInputType: TextInputType.name,
                        controller: cubit.teacherNameController,
                        hintText:
                        '${getLang(context,  "Teacher Name")}'
                        ,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MainTextField(
                        textInputType: TextInputType.emailAddress,
                        controller: cubit.teacherEmailController,
                        hintText:
                        '${getLang(context,   "Teacher Email")}'
                       ,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MainTextField(
                        textInputType: TextInputType.text,
                        controller: cubit.teacherPasswordController,
                        hintText:
                        '${getLang(context,   "Teacher Password")}'
                        ,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: DropdownButtonFormField<String>(
                          value: cubit.selectedSubject,
                          decoration:  InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorsAsset.kPrimary,
                              ),
                            ),
                            labelText:
                            '${getLang(context,  "Choose Subject")}'
                            ,
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
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  value: cubit.firstYear,
                                  onChanged: (value) {
                                    cubit.firstYear = value!;
                                    cubit.emit(ChangeValue());
                                    cubit.selectYear(value, 'first Secondary');
                                  }),
                               Text('${getLang(context,  "First year of secondary school")}'),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: cubit.secondYear,
                                  onChanged: (value) {
                                    cubit.secondYear = value!;
                                    cubit.emit(ChangeValue());
                                    cubit.selectYear(value, 'second Secondary');
                                  }),
                               Text('${getLang(context,  "Second year of secondary school")}'),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: cubit.thirdYear,
                                  onChanged: (value) {
                                    cubit.thirdYear = value!;
                                    cubit.emit(ChangeValue());
                                    cubit.selectYear(value, 'third Secondary');
                                  }),
                               Text('${getLang(context,  "Third year of secondary school")}'),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      state is AddTeacherLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: () {
                                cubit.addTeacher(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorsAsset.kPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0), // Border radius
                                ),
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                                child: Text(
                                  '${getLang(context,  "Add Teacher")}'
                                  ,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
