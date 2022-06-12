unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids,
  TAGraph, TASeries, TAMultiSeries;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Chart1: TChart;
    Chart1BubbleSeries1: TBubbleSeries;
    Chart2: TChart;
    Chart2PieSeries1: TPieSeries;
    Chart3: TChart;
    Chart3LineSeries1: TLineSeries;
    Chart4: TChart;
    Chart4LineSeries1: TLineSeries;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);

  var tLS:TLineSeries;
begin
 tLS:=TLineSeries.Create(Chart1);
 tLS.AddXY(0.5,1.0);
 tLS.AddXY(7.0,4.0);
 Chart1.AddSeries(tLS);
end;

procedure TForm1.Button2Click(Sender: TObject);
const
A1=155;
A2=251;
A3=203;
A4=404;
Var i: word;
begin
With Chart2PieSeries1 do
begin
Clear; //очищение диаграммы от предыдущих значений
Add(A1, 'Цех 1', clYellow);
Add(A2, 'Цех 2', clBlue);
Add(A3, 'Цех 3', clRed);
Add(A4, 'Цех 4', clPurple);
end;
end;

procedure TForm1.Button3Click(Sender: TObject);
  Type
  xyValue = record // пользовательский тип данных
  x, y: real; //координаты точки
  end;
  var
  arrXY: array of xyValue; // массив записей для хранения координат точек без задания макси-мального размера
  procedure fillArray(); // заполнение массива
  var x, y, h, maxX: real;
  tmp: xyValue; //переменная типа запись
  begin
  SetLength(arrXY,0);
  x:=0; // начальное значение X
  h:=0.1; // шаг изменения X
  maxX:=1.5*Pi; // максимальное значение X
  while (x+h)<=maxX do // пока будущее значение X меньше максимума
  begin
  x:=x+h; //увеличение значение X на шаг h
  y:=1/(cos(x)/sin(x));
  tmp.x:=x; tmp.y:=y; // записывает координаты в переменную tmp
  SetLength(arrXY,(Length(arrXY)+1) ); // выделение памяти для массива arrXY длиной на 1 больше, чем текущий размера массива
  arrXY[Length(arrXY)-1]:=tmp; //добавляем новый элемент в массив


  end;
  end;
  procedure fillChart(); // прорисовка графика по точкам
  var i: integer;
  c: TColor;
  begin
  c:=RGBtoColor(255,0,0); //задание цвета линии
  with Form1 do
  begin
  Chart3LineSeries1.Clear(); //очищение плоскости для построения нового графика
  Chart3LineSeries1.LinePen.Width:=3; //устанавливается ширина/толщина линии
  Chart3LineSeries1.LinePen.Color:=c; //устанавливается цвет линии графика
  //StringGrid1.ColCount:=Length(arrXY)+1;
  for i:=0 to Length(arrXY)-1 do
  Chart3LineSeries1.AddXY(arrXY[i].x,arrXY[i].y,'',c); //добавление линии от теку-щего места до точки с координатами (x;y)
  end;
  end;

begin
fillArray(); // заполнение массива
fillChart(); // прорисовка графика по точкам
end;

procedure TForm1.Button4Click(Sender: TObject);
  Type
  xyValue = record // пользовательский тип данных
  x, y, xx, yy: real; //координаты точки
  end;
  var
  arrXY: array of xyValue; // массив записей для хранения координат точек без задания макси-мального размера
  arXY: array of xyValue;
  procedure fillArray(); // заполнение массива
  Var x,xx,maxX,y,yy,i,ii,e,One,Onee,Two,Twoo:real;

  tmp: xyValue; //переменная типа запись
  tmpp: xyValue;

  begin
  StringGrid1.Cells[0,0]:=' №'; //проставляется надпись на заголовке первого столбца таблицы
  StringGrid1.Cells[1,0]:=' X'; //проставляется надпись на заголовке второго столбца таблицы
  StringGrid1.Cells[2,0]:=' f(X)'; //проставляется надпись на заголовке третьего столбца таблицы
  StringGrid1.GridLineWidth:=2; // задается толщина разграничительных линий.

  StringGrid2.Cells[0,0]:=' №'; //проставляется надпись на заголовке первого столбца таблицы
  StringGrid2.Cells[1,0]:=' X'; //проставляется надпись на заголовке второго столбца таблицы
  StringGrid2.Cells[2,0]:=' f(X)'; //проставляется надпись на заголовке третьего столбца таблицы
  StringGrid2.GridLineWidth:=2; // задается толщина разграничительных линий.

  StringGrid1.RowCount:=2;
  StringGrid2.RowCount:=2;

  One:=StrToFloat(Edit1.Text);
  Onee:=StrToFloat(Edit2.Text);
  Two:=StrToFloat(Edit3.Text);
  Twoo:=StrToFloat(Edit4.Text);

  SetLength(arrXY,0);
  SetLength(arXY,0);

  i:=0;
  ii:=0;
  x:=0;
  xx:=0;
  e:=2.7;
  maxX:=1.5*Pi;

  while (x+0.15)<=maxX do
  begin
  y:=sin(2*x) - exp(-0.7 * x * (ln(e)))+20;

  if (y >= One) and (y <= Onee) then
  begin
  StringGrid1.Cells[0,StringGrid1.RowCount-1]:= FloatToStrF(i,ffGeneral,6,6); //добавление в первый столбец в предпоследнюю строчку № точки
  StringGrid1.Cells[1,StringGrid1.RowCount-1]:= FloatToStrF(X,ffGeneral,6,6); //добавление во второй столбец в предпоследнюю строчку координату X точки
  StringGrid1.Cells[2,StringGrid1.RowCount-1]:= FloatToStrF(Y,ffGeneral,6,6); //добавление во второй столбец в предпоследнюю строчку координату Y точки
  StringGrid1.RowCount:=StringGrid1.RowCount+1; //добавление к таблице ещё одной строчки

  tmp.x:=x; tmp.y:=y; // записывает координаты в переменную tmp
  SetLength(arrXY,(Length(arrXY)+1) );
  arrXY[Length(arrXY)-1]:=tmp;
  end;

  x:=x+0.15;
  i:=i+1;
  end;

  while (xx+0.3)<=maxX do
  begin
  yy:=2 * arctan(xx + Pi) - xx + 5;

  if (yy >= Two) and (yy <= Twoo) then
  begin
  StringGrid2.Cells[0,StringGrid2.RowCount-1]:= FloatToStrF(ii,ffGeneral,6,6); //добавление в первый столбец в предпоследнюю строчку № точки
  StringGrid2.Cells[1,StringGrid2.RowCount-1]:= FloatToStrF(xx,ffGeneral,6,6); //добавление во второй столбец в предпоследнюю строчку координату X точки
  StringGrid2.Cells[2,StringGrid2.RowCount-1]:= FloatToStrF(yy,ffGeneral,6,6); //добавление во второй столбец в предпоследнюю строчку координату Y точки
  StringGrid2.RowCount:=StringGrid2.RowCount+1; //добавление к таблице ещё одной строчки

  tmpp.xx:=xx; tmpp.yy:=yy; // записывает координаты в переменную tmp
  SetLength(arXY,(Length(arXY)+1) );
  arXY[Length(arXY)-1]:=tmpp;
  end;

  xx:=xx+0.3;
  ii:=ii+1;
  end;

  StringGrid1.RowCount:=StringGrid1.RowCount-1;
  StringGrid2.RowCount:=StringGrid2.RowCount-1;
  end;

  procedure fillChart();
  var i: integer;
  c: TColor;
  begin
  c:=RGBtoColor(255,0,0);
  with Form1 do
  begin
  Chart4LineSeries1.Clear(); //очищение плоскости для построения нового графика
  Chart4LineSeries1.LinePen.Width:=3; //устанавливается ширина/толщина линии
  Chart4LineSeries1.LinePen.Color:=c; //устанавливается цвет линии графика
  //StringGrid1.ColCount:=Length(arrXY)+1;
  for i:=0 to Length(arrXY)-1 do
      Chart4LineSeries1.AddXY(arrXY[i].x,arrXY[i].y,'',c); //добавление линии от текущего места до точки с координатами (x;y)
  end;
  for i:=0 to Length(arXY)-1 do
      Chart4LineSeries1.AddXY(arXY[i].xx,arXY[i].yy,'',c);
  end;
begin
fillArray();
fillChart();
end;


procedure TForm1.Button5Click(Sender: TObject);
var tBS:TBubbleSeries;
begin
 tBS:=TBubbleSeries.Create(Chart1);
 tBS.AddXY(0.5,1,0.3);
 tBS.AddXY(7,4,1);
 Chart1.AddSeries(tBS);
end;


end.

