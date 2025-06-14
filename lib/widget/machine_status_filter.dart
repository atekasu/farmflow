import 'package:flutter/material.dart';

///機会のステータスでフィルタリングするウィジェット
class MachineStatusFilter extends StatelessWidget {
  final String seledtedFilter;
  final Function(String) onFilterChanged;
  const MachineStatusFilter({
    super.key,
    required this.seledtedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    const filters = ['全て', '良好', '要確認', '修理が必要'];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children:
            filters.map((filter) {
              final isSelected = seledtedFilter == filter;

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    onTap: () => onFilterChanged(filter),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? const Color(0xFF2196F3) // 選択されている場合の色
                                : Colors.grey[200], // 選択されていない場合の色
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              isSelected
                                  ? const Color(0xFF2196F3)
                                  : Colors.transparent,
                        ),
                      ),
                      child: Text(
                        filter,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[600],
                          fontSize: 12,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
