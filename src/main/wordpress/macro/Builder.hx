package wordpress.macro;

import haxe.macro.Context;
import haxe.macro.Expr;
using tink.MacroApi;
using Lambda;
using wordpress.macro.Builder.BuilderTools;

@:tink class Builder {

  static function processShortCode(fields:Array<Field>) {
    return [for (field in fields){
      if (field.meta_exists(':short_code')) {
        var short_code = field.meta_get(':short_code')[0][0];
        var name = field.name;
        macro {
           var fn = function(attr,content,tag) {
             //normalize attributes;
             var new_attr = php.Lib.hashOfAssociativeArray(untyped __php__("shortcode_atts($attr)"));
             $i{name}(new_attr,content,tag);
           };
           untyped __call__('add_shortcode',$short_code,fn);
        };
      }
    }];
  }


  static function processActions(fields:Array<Field>) {
    return [for (field in fields){
      if (field.meta_exists(':action')) {
        var meta = field.meta_get(':action')[0][0];
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
    var blocks = processActions(fields).concat(processShortCode(fields));

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

class BuilderTools {

  public static inline  function meta_exists(field:Field,meta:String) {
    return field.meta.toMap().exists(meta);
  }

  public static inline  function meta_get(field:Field,meta:String) {
    return field.meta.toMap().get(meta);
  }

}
