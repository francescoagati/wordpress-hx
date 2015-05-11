package wordpress.example;

typedef H = wordpress.Helper;



class PluginTest extends wordpress.Plugin {

  @:action('admin_head')
  public static function addCss() {
   
    h.echo("
      .class {
        background:red;
      }
    ");

  }


}
