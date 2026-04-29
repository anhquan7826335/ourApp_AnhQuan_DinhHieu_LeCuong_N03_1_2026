import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> members = [
      {'name': 'Nguyen Thi Van', 'age': 20},
      {'name': 'Tran Van Minh', 'age': 10},
      {'name': 'Ngo Thi Lan', 'age': 25},
    ];
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 16,
                right: 16,
                bottom: 8,
              ),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.width * 0.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 0.5,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  'assets/group_avatar.png',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const FlutterLogo(size: 10),
                ),
              ),
            ),
          Expanded(
            child: Container(
              child: ListView(
                children: members
                    .map((c) => ListTile(
                          title: Text(c['name']),
                          subtitle: Text('Tuổi: 	${c['age']}'),
                        ))
                    .toList(),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: const [
                Text('Phenikaa University', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Nhóm: Anh Quân, Đình Hiếu, Lê Cường'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/detail');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Detail'),
          BottomNavigationBarItem(icon: Icon(Icons.contacts), label: 'About'),
        ],
      ),
    );
  }
}
