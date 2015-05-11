package wordpress;

class Helper {

  @:extern public inline static function echo(s:String) {
    untyped __call__('echo',s);
  }  
}
