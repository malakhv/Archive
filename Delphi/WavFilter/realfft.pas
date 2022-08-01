unit realfft;
(***********************************************************************
Этот код сгенерирован транслятором AlgoPascal в рамках проекта ALGLIB

Условия, на которых распространяется этот код, можно получить по адресу
http://alglib.sources.ru/copyrules.php
***********************************************************************)
interface
uses Math, Ap;

procedure RealFastFourierTransform(var a : TReal1DArray;
     tnn : Integer;
     InverseFFT : Boolean);forward;


(*************************************************************************
Быстрое преобразование Фурье

Алгоритм проводит быстрое преобразование Фурье вещественной
функции, заданной n отсчетами на действительной оси.

В зависимости от  переданных параметров, может выполняться
как прямое, так и обратное преобразование.

Входные параметры:
    tnn  -   Число значений функции. Должно  быть  степенью
            двойки. Алгоритм   не  проверяет  правильность
            переданного значения.
    a   -   array [0 .. nn-1] of Real
            Значения функции.
    InverseFFT
        -   направление преобразования.
            True, если обратное, False, если прямое.
            
Выходные параметры:
    a   -   результат   преобразования.   Подробнее    см.
            описание на сайте.
*************************************************************************)

implementation
procedure RealFastFourierTransform(var a : TReal1DArray;
     tnn : Integer;
     InverseFFT : Boolean);
var
    twr : Double;
    twi : Double;
    twpr : Double;
    twpi : Double;
    twtemp : Double;
    ttheta : Double;
    i : Integer;
    i1 : Integer;
    i2 : Integer;
    i3 : Integer;
    i4 : Integer;
    c1 : Double;
    c2 : Double;
    h1r : Double;
    h1i : Double;
    h2r : Double;
    h2i : Double;
    wrs : Double;
    wis : Double;
    nn : Integer;
    ii : Integer;
    jj : Integer;
    n : Integer;
    mmax : Integer;
    m : Integer;
    j : Integer;
    istep : Integer;
    isign : Integer;
    wtemp : Double;
    wr : Double;
    wpr : Double;
    wpi : Double;
    wi : Double;
    theta : Double;
    tempr : Double;
    tempi : Double;
begin
    if tnn=1 then
    begin
        Exit;
    end;
    if  not InverseFFT then
    begin
        ttheta := 2*Pi/tnn;
        c1 := 0.5;
        c2 := -0.5;
    end
    else
    begin
        ttheta := 2*Pi/tnn;
        c1 := 0.5;
        c2 := 0.5;
        ttheta := -ttheta;
        twpr := -2.0*sqr(sin(0.5*ttheta));
        twpi := sin(ttheta);
        twr := 1.0+twpr;
        twi := twpi;
        i:=2;
        while i<=tnn div 4+1 do
        begin
            i1 := i+i-2;
            i2 := i1+1;
            i3 := tnn+1-i2;
            i4 := i3+1;
            wrs := twr;
            wis := twi;
            h1r := c1*(a[i1]+a[i3]);
            h1i := c1*(a[i2]-a[i4]);
            h2r := -c2*(a[i2]+a[i4]);
            h2i := c2*(a[i1]-a[i3]);
            a[i1] := h1r+wrs*h2r-wis*h2i;
            a[i2] := h1i+wrs*h2i+wis*h2r;
            a[i3] := h1r-wrs*h2r+wis*h2i;
            a[i4] := -h1i+wrs*h2i+wis*h2r;
            twtemp := twr;
            twr := twr*twpr-twi*twpi+twr;
            twi := twi*twpr+twtemp*twpi+twi;
            Inc(i);
        end;
        h1r := a[0];
        a[0] := c1*(h1r+a[1]);
        a[1] := c1*(h1r-a[1]);
    end;
    if InverseFFT then
    begin
        isign := -1;
    end
    else
    begin
        isign := 1;
    end;
    n := tnn;
    nn := tnn div 2;
    j := 1;
    ii:=1;
    while ii<=nn do
    begin
        i := 2*ii-1;
        if j>i then
        begin
            tempr := a[j-1];
            tempi := a[j];
            a[j-1] := a[i-1];
            a[j] := a[i];
            a[i-1] := tempr;
            a[i] := tempi;
        end;
        m := n div 2;
        while (m>=2) and (j>m) do
        begin
            j := j-m;
            m := m div 2;
        end;
        j := j+m;
        Inc(ii);
    end;
    mmax := 2;
    while n>mmax do
    begin
        istep := 2*mmax;
        theta := 2*Pi/(isign*mmax);
        wpr := -2.0*sqr(sin(0.5*theta));
        wpi := sin(theta);
        wr := 1.0;
        wi := 0.0;
        ii:=1;
        while ii<=mmax div 2 do
        begin
            m := 2*ii-1;
            jj:=0;
            while jj<=(n-m) div istep do
            begin
                i := m+jj*istep;
                j := i+mmax;
                tempr := wr*a[j-1]-wi*a[j];
                tempi := wr*a[j]+wi*a[j-1];
                a[j-1] := a[i-1]-tempr;
                a[j] := a[i]-tempi;
                a[i-1] := a[i-1]+tempr;
                a[i] := a[i]+tempi;
                Inc(jj);
            end;
            wtemp := wr;
            wr := wr*wpr-wi*wpi+wr;
            wi := wi*wpr+wtemp*wpi+wi;
            Inc(ii);
        end;
        mmax := istep;
    end;
    if InverseFFT then
    begin
        I:=1;
        while I<=2*nn do
        begin
            a[I-1] := a[I-1]/nn;
            Inc(I);
        end;
    end;
    if  not InverseFFT then
    begin
        twpr := -2.0*sqr(sin(0.5*ttheta));
        twpi := sin(ttheta);
        twr := 1.0+twpr;
        twi := twpi;
        i:=2;
        while i<=tnn div 4+1 do
        begin
            i1 := i+i-2;
            i2 := i1+1;
            i3 := tnn+1-i2;
            i4 := i3+1;
            wrs := twr;
            wis := twi;
            h1r := c1*(a[i1]+a[i3]);
            h1i := c1*(a[i2]-a[i4]);
            h2r := -c2*(a[i2]+a[i4]);
            h2i := c2*(a[i1]-a[i3]);
            a[i1] := h1r+wrs*h2r-wis*h2i;
            a[i2] := h1i+wrs*h2i+wis*h2r;
            a[i3] := h1r-wrs*h2r+wis*h2i;
            a[i4] := -h1i+wrs*h2i+wis*h2r;
            twtemp := twr;
            twr := twr*twpr-twi*twpi+twr;
            twi := twi*twpr+twtemp*twpi+twi;
            Inc(i);
        end;
        h1r := a[0];
        a[0] := h1r+a[1];
        a[1] := h1r-a[1];
    end;
end;

end.



