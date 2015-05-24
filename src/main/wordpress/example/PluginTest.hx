package wordpress.example;
import wordpress.types.ShortCode;



class PluginTest extends wordpress.Plugin {

  @:short_code('hello_world')
  public static function helloWorld(shortCode:ShortCode) {

    var name = shortCode.attrs.get('name');
    h.echo('hello $name');
  }

  @:action('admin_head')
  public static function addCss() {

    h.echo("
      .class {
        background:red;
      }
    ");

  }


}
