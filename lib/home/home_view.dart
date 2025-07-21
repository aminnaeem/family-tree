import 'package:family_tree/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('My Family Tree')),
          body: Stack(
            children: [
              // Background logo
              Positioned.fill(
                child: Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    'asset/logo/logo.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),

              // Foreground content
              model.members.isEmpty
                  ? const Center(child: Text('Press the button to add a member'))
                  : ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: model.members.length,
                    itemBuilder: (context, index) {
                      final member = model.members[index];
                      return Dismissible(
                        key: Key(member.name + index.toString()),
                        direction: DismissDirection.endToStart, // swipe left to delete
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          color: const Color.fromARGB(87, 244, 67, 54),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) => model.deleteMember(index),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.green[100],
                              child: Text(
                                member.name[0].toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            title: Text(member.name),
                            subtitle: Text(
                              '${member.relationship}     Age: ${model.calculateAge(member.birthDate)}',
                            ),
                            trailing: Icon(
                              Icons.favorite,
                              color: member.isAlive ? Colors.red : Colors.grey,
                            ),
                            onTap: () => model.openMemberDetail(index),
                          ),
                        ),
                      );
                    },
                  ),

            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => model.addFamilyMember(context),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
