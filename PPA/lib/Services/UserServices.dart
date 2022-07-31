import 'package:googleapis/androidmanagement/v1.dart';
import 'package:ppa/db/Database.dart';
import 'package:ppa/db/passwordmodel.dart';
import 'package:ppa/db/repository.dart';

class UserServices{
  late Repository _repository;
  UserServices(){
    _repository=Repository();
  }

  SaveUser(ModelPass user)async{
    return await _repository.insertData('password', user.passwordMap());
  }

  ReadAllPassword()async{
    return await _repository.readData('password');
  }
  UpdateUser(ModelPass user)async{
    return await _repository.updateData('password', user.passwordMap());
  }
  DeleteUserPass(Userid)async{
    return await _repository.deleteDataById('password', Userid);
  }

}