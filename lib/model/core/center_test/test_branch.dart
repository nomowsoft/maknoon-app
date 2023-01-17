class TestBranch{
  int branchId;
  String branchName;

  TestBranch({required this.branchId,required this.branchName});

  TestBranch.fromJson(Map<String, dynamic> json):
    branchId = json['branch_id'] ?? 0,
    branchName = json['branch_name'] ?? '';

  Map<String, dynamic> toMap() => {
        "branch_id": branchId,
        "branch_name": branchName,
      };
}