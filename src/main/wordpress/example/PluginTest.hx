package wordpress.example;

@:build(wordpress.macro.Builder.build())
@:keep
@:keepInit
@:keepSub
class PluginTest {

  @:action('admin_head')
  public static function addCss() {}


}
