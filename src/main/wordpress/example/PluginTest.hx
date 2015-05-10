package wordpress.example;

class PluginTest extends wordpress.Plugin {

  @:action('admin_head')
  public static function addCss() {

    echo("
      .class {
        background:red;
      }
    ");

  }


}
