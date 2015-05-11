package wordpress.macro;

import haxe.macro.Context;
import haxe.macro.Expr;
using tink.MacroApi;
using Lambda;

class Builder {

  macro static public function build():Array<Field> {
    var fields = Context.getBuildFields();
    var cls = Context.getLocalClass().toString();

    var blocks = fields.filter(function(field) {
      return field.meta.toMap().exists(':action');
    }).map(function(field) {
      var meta = field.meta.toMap().get(':action')[0][0];
      var name = field.name;
      return macro {
         var fn = function() {
           var clsRef = Type.resolveClass($v{cls});
           Reflect.callMethod(clsRef,$i{name},[]);
         }
         untyped __call__('add_action',$meta,fn);
      };
    });


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
