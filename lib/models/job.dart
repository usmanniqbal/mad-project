import 'dart:ffi';

class Job {
  final String jobId;
  final Double ratePerHour;

  Job(this.jobId, this.ratePerHour);

  Map<String, dynamic> toMap() => {'jobId': jobId, 'ratePerHour' : ratePerHour};
}
