class Posts
{

  String _tittle,_Desc,_Date,_path;
  int _id;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get tittle => _tittle;

  set tittle(String value) {
    _tittle = value;
  }

  Posts(this._tittle, this._Desc, this._Date, this._path);
  Posts.withId(this._id, this._tittle, this._Desc, this._Date, this._path);


  get Desc => _Desc;

  get path => _path;

  set path(value) {
    _path = value;
  }

  get Date => _Date;

  set Date(value) {
    _Date = value;
  }

  set Desc(value) {
    _Desc = value;
  }

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['tittle'] = _tittle;
    map['Desc'] = _Desc;
    map['Date'] = _Date;
    map['path'] = _path;

    return map;
  }

  // Extract a Note object from a Map object
  Posts.fromMapObject(Map<String, dynamic> map) {

    this._id = map['id'];
    this._tittle = map['tittle'];
    this._Desc = map['Desc'];
    this._Date = map['Date'];
    this._path = map['path'];
  }




}