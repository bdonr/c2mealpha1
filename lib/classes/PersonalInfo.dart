class PersonalInfo{
   late String _xing;

  PersonalInfo(xing){
    this._xing = xing;
  }

   String get xing => _xing;

  set xing(String value) {
    _xing = value;
  }



}