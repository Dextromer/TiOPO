unit AccessAdapterUnit;

interface

uses SysUtils, Data.DB, Data.Win.ADODB,
     System.Generics.Collections, AdaptersUnit;

type
  AccessAdapter = class(TInterfacedObject, Adapters)
  private
    caption:string;
    ADOConnection:TADOConnection;
  public
    function GetAnswerTableName:string;
    function GetAnswerTable(answer:string):TList<string>;
    function GetCorrectTableName:string;
    function GetCorrectTable(correct:string):TDictionary<integer, integer>;
    function GetQuestTableName:string;
    function GetQuestTable(quest:string):TList<string>;
    function getMenu: TList<string>;
    procedure setTest(caption:string);
    function getQuest:TList<string>;
    function getAnswer:TList<string>;
    function getCorrect:TDictionary<integer, integer>;
  published
    constructor create;
  end;
implementation

{ AccessAdapter }

constructor AccessAdapter.create;
begin
  ADOConnection:=TADOConnection.create(nil);
  with (ADOConnection)do
  begin
    Provider:='Microsoft.ACE.OLEDB.12.0';
    Mode:=cmShareDenyNone;
    LoginPrompt:=False;
    ConnectionString:= 'Provider=Microsoft.ACE.OLEDB.12.0;'+
      'Data Source=BD.accdb;'+'Persist Security Info=False';
    Connected:=true;
  end;
end;

function AccessAdapter.getAnswer: TList<string>;
var
  ADOQuery:TADOQuery;
  answer:string;
begin
  answer:=GetAnswerTableName;
  result:=GetAnswerTable(answer);
end;

function AccessAdapter.GetAnswerTable(answer:string):TList<string>;
var
  ADOQuery:TADOQuery;
begin
  result:=TList<string>.create;
  ADOQuery:=TADOQuery.Create(nil);
  with (ADOQuery) do
  begin
    Connection:=ADOConnection;
    Close;
    SQL.Clear;
    SQL.Add('SELECT caption FROM ' + answer + ';');
    Open;
    Active:=True;
  end;
  while not ADOQuery.Eof do
  begin
    result.Add(ADOQuery.FieldByName('caption').AsString);
    ADOQuery.Next;
  end;
  ADOQuery.Free;
end;

function AccessAdapter.GetAnswerTableName: string;
var
  ADOQuery:TADOQuery;
begin
  ADOQuery:=TADOQuery.Create(nil);
  with (ADOQuery) do
  begin
    Connection:=ADOConnection;
    Close;
    SQL.Clear;
    SQL.Add('SELECT answer FROM Main WHERE caption="' + Self.caption + '";');
    Open;
    Active:=True;
  end;
  ADOQuery.First;
  result:= ADOQuery.FieldByName('answer').AsString;
  ADOQuery.Free;
end;

function AccessAdapter.getCorrect: TDictionary<integer, integer>;
var
  correct:string;
begin
  correct:=GetCorrectTableName;
  result:=GetCorrectTable(correct);
end;

function AccessAdapter.GetCorrectTable(correct: string): TDictionary<integer, integer>;
var
  ADOQuery:TADOQuery;
begin
  result:=TDictionary<integer, integer>.create;
  ADOQuery:=TADOQuery.Create(nil);
  with (ADOQuery) do
  begin
    Connection:=ADOConnection;
    Close;
    SQL.Clear;
    SQL.Add('SELECT quest_id, answer_id FROM ' + correct + ';');
    Open;
    Active:=True;
  end;
  ADOQuery.First;
  while not ADOQuery.Eof do
  begin
    result.Add(StrToInt(ADOQuery.FieldByName('quest_id').AsString),
      StrToInt(ADOQuery.FieldByName('answer_id').AsString));
    ADOQuery.Next;
  end;
  ADOQuery.Free;
end;

function AccessAdapter.GetCorrectTableName: string;
var
  ADOQuery:TADOQuery;
begin
  ADOQuery:=TADOQuery.Create(nil);
  with (ADOQuery) do
  begin
    Connection:=ADOConnection;
    Close;
    SQL.Clear;
    SQL.Add('SELECT correct FROM Main WHERE caption="' + Self.caption + '";');
    Open;
    Active:=True;
  end;
  ADOQuery.First;
  result:= ADOQuery.FieldByName('correct').AsString;
end;

function AccessAdapter.getQuest: TList<string>;
var
  ADOQuery:TADOQuery;
  quest:string;
begin
  quest:=GetQuestTableName;
  result:=GetQuestTable(quest);
end;

function AccessAdapter.GetQuestTable(quest: string): TList<string>;
var
  ADOQuery:TADOQuery;
begin

  result:=TList<string>.create;
  ADOQuery:=TADOQuery.Create(nil);
  with (ADOQuery) do
  begin
    Connection:=ADOConnection;
    Close;
    SQL.Clear;
    SQL.Add('SELECT caption FROM ' + quest + ';');
    Open;
    Active:=True;
  end;
  while not ADOQuery.Eof do
  begin
    result.Add(ADOQuery.FieldByName('caption').AsString);
    ADOQuery.Next;
  end;
  ADOQuery.Free;

end;

function AccessAdapter.GetQuestTableName: string;
var
  ADOQuery:TADOQuery;
begin
  ADOQuery:=TADOQuery.Create(nil);
  with (ADOQuery) do
  begin
    Connection:=ADOConnection;
    Close;
    SQL.Clear;
    SQL.Add('SELECT quest FROM Main WHERE caption="' + Self.caption + '";');
    Open;
    Active:=True;
  end;
  ADOQuery.First;
  result:=ADOQuery.FieldByName('quest').AsString;
end;

procedure AccessAdapter.setTest(caption: string);
begin
  self.caption:=caption;
end;

function AccessAdapter.getMenu: TList<string>;
var
  ADOQuery:TADOQuery;
begin
  result:=TList<string>.create;
  ADOQuery:=TADOQuery.Create(nil);
  with (ADOQuery) do
  begin
    Connection:=ADOConnection;
    Close;
    SQL.Clear;
    SQL.Add('SELECT caption FROM main;');
    Open;
    Active:=True;
  end;
  ADOQuery.First;
  while not ADOQuery.Eof do
  begin
    result.Add(ADOQuery.FieldByName('caption').AsString);
    ADOQuery.Next;
  end;
  ADOQuery.Free;
end;

end.
