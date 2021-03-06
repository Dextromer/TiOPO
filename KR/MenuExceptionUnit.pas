unit MenuExceptionUnit;

interface

uses
  System.Generics.Collections,Dialogs,SysUtils,
    MainUnit,MenuUnit;

type
  MenuException = class(TInterfacedObject, Main)
  private
    /// <link>aggregation</link>
    MenuSource: Menu;
  public
    function getMenu:TList<string>;
  end;

implementation

{ MenuException }

function MenuException.getMenu: TList<string>;
begin
  try
    result:=TList<String>.create;
    MenuSource:=Menu.create;
    Result:=MenuSource.getMenu;
  except
    on E:Exception do
      showmessage('Error in Menu.getMenu'+E.Message);
  end;
end;

end.
