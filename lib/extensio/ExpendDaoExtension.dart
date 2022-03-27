
import 'package:change/extensio/TimeExtension.dart';

import '../dao/ExpendDao.dart';
import '../entity/Expend.dart';

extension ExpendDaoExtension on ExpendDao {
  insertReplace(Expend expend) {
    int dateStamp = expend.dateStamp;
    this.delete(expend.type.type, dateStamp.getMinDateStampDay(),
        dateStamp.getMaxDateStampDay());
    this.insert(expend);
  }
}