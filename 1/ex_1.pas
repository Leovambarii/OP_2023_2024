program ex_1;

type
    IntArray = array of Integer;

procedure PrintArray(var arr: IntArray);
var
    i: Integer;
begin
    write('Array: ');
    for i := 0 to Length(arr) - 1 do
    begin
        write(arr[i], ' ');
    end;
    writeln;
end;

(*3.0 Procedura do generowania 50 losowych liczb od 0 do 100*)
(*4.0 Dodanie parametrów do procedury losującej określającymi zakres losowania: od, do, ile*)
procedure FillRandomArray(var arr: IntArray; start, ending, amount: Integer);
var
    i: Integer;
begin
    if (amount > Length(arr)) or (start > ending) then
    begin
        writeln('FillArrayWithRandomNumbers error: Incorrect parameters!');
        halt;
    end;

    Randomize;
    for i := 0 to amount - 1 do
    begin
        arr[i] := Random(ending - start + 1) + start;
    end;
end;

(*3.5 Procedura do sortowania liczb*)
procedure BubbleSort(var arr: IntArray);
var
    i, j, tmp: Integer;
begin
    for i := 0 to Length(arr) - 2 do
    begin
        for j := 0 to Length(arr) - 2 - i do
        begin
            if (arr[j] > arr[j + 1]) then
            begin
                tmp := arr[j];
                arr[j] := arr[j + 1];
                arr[j + 1] := tmp;
            end;
        end;
    end;
end;

procedure TestResult(test: string; res: boolean);
begin
    if res = true then
        writeln('Test PASSED - ' + test)
    else
        writeln('Test FAILED - ' + test)
end;

(*4.5 5 testów jednostkowych testujące procedury*)
procedure Test_1_IfStart();
var
    testArray: IntArray;
    i, start, ending, amount: Integer;
    res: boolean = true;
begin
    start := 10;
    ending := 100;
    amount := 50;

    SetLength(testArray, amount);
    FillRandomArray(testArray, start, ending, amount);

    for i := 0 to amount - 1 do
    begin
        if testArray[i] < start then
        begin
            res := false;
            break;
        end;
    end;

    TestResult('Test_1_IfStart', res)
end;

procedure Test_2_IfEnding();
var
    testArray: IntArray;
    i, start, ending, amount: Integer;
    res: boolean = true;
begin
    start := 10;
    ending := 100;
    amount := 50;

    SetLength(testArray, amount);
    FillRandomArray(testArray, start, ending, amount);

    for i := 0 to amount - 1 do
    begin
        if testArray[i] > ending then
        begin
            res := false;
            break;
        end;
    end;

    TestResult('Test_2_IfEnding', res)
end;

procedure Test_3_IfFilled();
var
    testArray: IntArray;
    i, start, ending, amount: Integer;
    res: boolean = true;
begin
    start := 10;
    ending := 100;
    amount := 50;

    SetLength(testArray, amount);
    FillRandomArray(testArray, start, ending, amount);

    for i := 0 to amount - 1 do
    begin
        if (testArray[i] < start) or (testArray[i] > ending) or (testArray[i] = 0) then
        begin
            res := false;
            break;
        end;
    end;

    TestResult('Test_3_IfFilled', res)
end;

procedure Test_4_IfSorted();
var
    testArray: IntArray;
    arraySize: Integer = 50;
    i: Integer;
    res: boolean = true;
begin
    SetLength(testArray, arraySize);
    FillRandomArray(testArray, 0, arraySize, arraySize);
    BubbleSort(testArray);

    for i := 0 to arraySize - 2 do
    begin
        if testArray[i] > testArray[i + 1] then
        begin
            res := false;
            break;
        end;
    end;

    TestResult('Test_4_IfSorted', res)
end;

procedure Test_5_SortSorted();
var
    testArray: IntArray;
    arraySize: Integer = 50;
    i: Integer;
    res: boolean = true;
begin
    SetLength(testArray, arraySize);
    FillRandomArray(testArray, 0, arraySize, arraySize);
    BubbleSort(testArray);
    BubbleSort(testArray);

    for i := 0 to arraySize - 2 do
    begin
        if testArray[i] > testArray[i + 1] then
        begin
            res := false;
            break;
        end;
    end;

    TestResult('Test_5_SortSorted', res)
end;

var
    testArray: IntArray;
    arraySize: Integer = 50;

begin
    SetLength(testArray, arraySize);
    FillRandomArray(testArray, 0, 100, arraySize);
    writeln('Array before sorting:');
    PrintArray(testArray);

    BubbleSort(testArray);
    writeln('Array after sorting:');
    PrintArray(testArray);

    writeln;
    writeln('Running tests...');
    Test_1_IfStart();
    Test_2_IfEnding();
    Test_3_IfFilled();
    Test_4_IfSorted();
    Test_5_SortSorted()
end.