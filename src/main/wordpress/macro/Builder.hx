package wordpress.macro;

import haxe.macro.Context;
import haxe.macro.Expr;
using tink.MacroApi;
using Lambda;

@:tink class Builder {

  static function processActions(fields:Array<Field>) {
    return [for (field in fields){
      if (field.meta.toMap().exists(':action')) {
        var meta = field.meta.toMap().get(':action')[0][0];
        var name = field.name;
        macro {
           var fn = function() $i{name}();
           untyped __call__('add_action',$meta,fn);
        };
      }
    }];
  }

  macro static public function build():Array<Field> {
    var fields = Context.getBuildFields();
    var cls = Context.getLocalClass().toString();
    var blocks = processActions(fields);

    var metaClass = (macro class TTT {
       static var h = wordpress.Helper;
       static function __init__() {
         $b{blocks};
       }
    });

    for (field in metaClass.fields) fields.push(field);

    return fields;
  }

}
