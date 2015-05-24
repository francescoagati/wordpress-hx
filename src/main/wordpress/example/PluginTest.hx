package wordpress.example;

typedef H = wordpress.Helper;



class PluginTest extends wordpress.Plugin {

  @:short_code('hello_world')
  public static function helloWorld(attrs,content,tag) {
    attrs.get('test');
    h.echo("hello wordpress");
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
