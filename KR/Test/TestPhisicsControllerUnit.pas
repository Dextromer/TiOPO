unit TestPhisicsControllerUnit;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, PhisicsControllerUnit, ControllersUnit, Test1LoggingUnit,
  System.Generics.Collections, Dialogs, MainUnit, SysUtils, MenuLoggingUnit, stdCtrls,
  TestsUnit;

type
  // Test methods for class PhisicsController

  TestPhisicsController = class(TTestCase)
  strict private
    FPhisicsController: PhisicsController;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestsetTest;
    procedure TestgetMenu;
    procedure TestgetQuest;
    procedure TestgetAnswer;
    procedure TestgetCorrect;
  end;

implementation

procedure TestPhisicsController.SetUp;
begin
  FPhisicsController := PhisicsController.Create;
end;

procedure TestPhisicsController.TearDown;
begin
  FPhisicsController.Free;
  FPhisicsController := nil;
end;

procedure TestPhisicsController.TestsetTest;
var
  caption: string;
begin
  // TODO: Setup method call parameters
  caption:=FPhisicsController.getMenu.Items[1];
  FPhisicsController.setTest(caption);
  CheckEquals(caption, '���� � ��������� ������');
  CheckNotEquals(caption, '������������� ������ ��� ������');
  // TODO: Validate method results
end;

procedure TestPhisicsController.TestgetMenu;
var
  ReturnValue: TList<string>;
begin
  ReturnValue := FPhisicsController.getMenu;
  CheckNotEquals(ReturnValue.Items[1],'�����');
  CheckEquals(ReturnValue.Items[0], '������������� ������ ��� ������');
  CheckNotEquals(ReturnValue.First, '11');
  // TODO: Validate method results
end;

procedure TestPhisicsController.TestgetQuest;
var
  ReturnValue: TList<string>;
begin
  FPhisicsController.setTest('���� � ��������� ������');
  ReturnValue := FPhisicsController.getQuest;
  CheckNotEquals(ReturnValue.Items[4],'1111');
  CheckEquals(ReturnValue.Count, 5);
  // TODO: Validate method results
end;

procedure TestPhisicsController.TestgetAnswer;
var
  ReturnValue: TList<string>;
begin
  FPhisicsController.setTest('���� � ��������� ������');
  ReturnValue := FPhisicsController.getAnswer;
  CheckEquals(ReturnValue.Items[1],'��� ������, �������������� ������������� ��� ������� ���������� �����.');
  CheckTrue(ReturnValue.Items[3]<>'sss');
  CheckNotEquals(ReturnValue.Items[1],'�����');
  CheckEquals(ReturnValue.Count, 5);
  // TODO: Validate method results
end;

procedure TestPhisicsController.TestgetCorrect;
var
  ReturnValue: TDictionary<integer,integer>;
begin
  FPhisicsController.setTest('���� � ��������� ������');
  ReturnValue := FPhisicsController.getCorrect;
  CheckEquals(ReturnValue.Items[2], 2);
  CheckNotEquals(ReturnValue.Items[3], 11);
  // TODO: Validate method results
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestPhisicsController.Suite);
end.

