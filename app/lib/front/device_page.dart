import 'package:flutter/material.dart';

class DevicePage extends StatelessWidget {
  const DevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thiết bị'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quản lý thiết bị',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            
            // Device List
            _buildDeviceCard(
              'Điện thoại',
              'iPhone 14 Pro',
              Icons.phone_android,
              Colors.blue,
              'Hoạt động',
            ),
            _buildDeviceCard(
              'Máy tính',
              'MacBook Pro M2',
              Icons.laptop,
              Colors.purple,
              'Hoạt động',
            ),
            _buildDeviceCard(
              'Máy tính bảng',
              'iPad Pro',
              Icons.tablet_android,
              Colors.green,
              'Không hoạt động',
            ),
            _buildDeviceCard(
              'Đồng hồ',
              'Apple Watch Series 8',
              Icons.watch,
              Colors.red,
              'Hoạt động',
            ),
            
            const SizedBox(height: 20),
            const Text(
              'Thống kê',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('4', 'Tổng thiết bị'),
                    _buildStatItem('3', 'Đang hoạt động'),
                    _buildStatItem('1', 'Không hoạt động'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    String status,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 30),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: status == 'Hoạt động' ? Colors.green[100] : Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: status == 'Hoạt động' ? Colors.green[700] : Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}