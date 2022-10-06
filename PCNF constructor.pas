{
  тестовые наборы
  ((((A>B)>!A)>!B)>!C) -> (A+B+!C)&(!A+B+!C)&(!A+!B+!C)   a+b+c+d+e+f+g+h+i+k+l+m+n+o+p+q+r+s+t+u+v+w+x+y+z
}
        type
          logvar = record
            tbl : array of boolean;            
          end;
              
               const alf = '()10+∨|&∧*>→!¬~⊕';
                   opers = '()+∨&∧>→!¬~⊕';
                       
                       var absolutetruth,absolutefalse: array of boolean;
                          var warnames : array of char;
                             var lvar : array of logvar;
                                var numofwars : integer;

                                procedure helper(); 
                              begin
                                println;
                                Println($'В благородство играть не буду, будете соблюдать правила - получите свою формулу, нет - пиняйте на себя');
                                println('-'*43);
                                Println($'Правила поведения на моей страничке:');
                                Println($'Переменными будут считаться все одиночные символы, кроме пробела и операторов. Кстати, вот они сверху вниз:');
                                Println($'       {alf[1]}       =      открывающая скобка'); println($'       {alf[2]}       =      закрывающая скорбка');println($'       {alf[3]}       =      тождественная истина');
                                println($'       {alf[4]}       =      тождественная ложь'); println($' {alf[5]} или {alf[6]} или {alf[7]} =      дизъюнкция'); println($' {alf[8]} или {alf[9]} или {alf[10]} =      конъюнкция');
                                println($'    {alf[11]} или {alf[12]}    =      импликация'); println($'    {alf[13]} или {alf[14]}    =     отрицание'); println($'       {alf[15]}       =      эквиваленция');
                                println($'       {alf[16]}      =       хрень какая-то, хз зачем нужна штука, равная отрицанию эквиваленции');
                                println('-'*43);
                                Println($'Если теперь вы готовы ->');
                                println; // если не знаешь, с чего начать программу - начинай с разъяснения ее функций
                              end;
                            
                              procedure pin(var str:string);
                            begin
                              str:=readstring('Введите ваш запрос:');
                              if str.toupper='HELP' then
                                begin
                                  helper();
                                  pin(str);
                                end;
                            end;
                    
                            procedure spacenormalise(var str:string);
                          begin
                            Insert('(',str,1);
                            Insert(')',str,str.Length+1);
                            //Println(str);
                            var i := 1;
                            while i < Str.length do
                              begin
                                if str[i] = ' ' then //begin
                                  Delete(str,I,1) //Println('-1',str,I, str[i]=' '); end
                                else
                                  I += 1;
                              end;
                            //Println(str);
                            //Delete(str,1,1);
                            //Delete(str,str.Length,1);
                          end;
          
                          procedure VarsName(Str:string; var num:integer; var Res:set of char; var Err:integer);
                      begin //я хз зачем тут считается множество, оно просто всегда тут было. Без него - не было бы и этой функции, так что лучше скажите ему спасибо
                        var ind := 1;
                        var names : set of char = [];
                        var prevvar := false;
                        var counter := 0;
                        var (OpBrac,EdBrac) := (0,0);
                        
                          while ind <= str.Length do
                            if not (Str[ind] in alf) then
                              begin
                                if not(Str[ind] in names) then
                                  counter += 1;
                                names += [Str[ind]];
                                if prevvar then Err := 1;
                                  prevvar := true;
                                ind += 1;
                              end
                            else
                              begin
                                if Str[ind] = '(' then OpBrac += 1;
                                if Str[ind] = ')' then EdBrac += 1;
                                if EdBrac > OpBrac then Err := 2;
                                ind += 1;
                                prevvar := false;
                              end;
                              
                        num := counter;
                        res := names;
                        if OpBrac <> EdBrac then Err := 3;
                      end;
            
                        function getvarsname(str:string; num, err:integer):array of char;
                      begin
                        var name := new char[num];
                        var ind := 1;
                        var prevvar := false;
                        var counter := 0;
                        
                          while ind <= str.Length do
                            if not (Str[ind] in alf) then
                              begin
                                //var isin:=false;
                                if not (name.Contains(str[ind])) then 
                                begin
                                  name[counter] := Str[ind];
                                  counter += 1;
                                end;  
//                                for var i:=0 to counter-1 do
//                                  if str[ind] = name[i] then isin := true;
                                //if not isin then
                                  
                                if prevvar then Err := 1;
                                  prevvar := true;
                                ind += 1;
                                
                              end
                            else
                              begin
                                ind += 1;
                                prevvar := false;
                              end;
                        
                        Result := name;
                      end;
                    
                      function priority(oper:char):integer;
                      begin
                        case oper of // смотришь и глаз радуется
                        '!','¬'    :      result := 3;
                        '&','∧','*':      result := 2;
                        '+','∨','|':      result := 1;
                        '>','→','~','⊕' : result := 0;
                        '(',')'    :      result := -1;
                        end;
                      end;
                    
                    function polish(Str:string):string;
                    begin
                      var (temp,res,i,unary) := ('','',1,true);
                      
                      Insert('(',Str,1);
                      Insert(')',Str,Str.length+1);
                      
                      //Println(Str);
                      var lastunary := false;
                      while I <= Str.length do
                      begin
                        if not(Str[i] in opers) then
                        begin
                          res += str[i];
                          //Println($'{i} lol -1 {Str[i]} temp={temp} res={res} {unary}');
                        end
                        else
                        begin
                          case str[I] of
                              '(':   begin
                                       temp += Str[I];
                                       //Println($'{i} lol 0 {Str[i]} temp={temp} res={res} {unary}');
                                     end;
                              ')':   begin
                                      //Println($'{i} lol 1 {Str[i]} temp={temp} res={res} {unary}');
                                       while temp[temp.length] <> '(' do
                                       begin
                                         Res += temp[temp.length];
                                         Delete(temp,temp.length,1);
                                         //Println($'{i} lol 2 {Str[i]} temp={temp} res={res} {unary}');
                                       end;
                                       Delete(temp,temp.Length,1);
                                     end;
                            '!','¬': begin
                                       while (Str[i] = '!') or (Str[i] = '¬') do
                                       begin
                                         temp += Str[i];
                                         i += 1;
                                       end;
                                       if str[i] = '(' then temp += Str[i]
                                       else
                                       begin
                                         res += Str[i];
                                         while (temp[temp.Length] = '!')or(temp[temp.Length] = '¬') do
                                         begin
                                           res += temp[temp.Length];
                                           Delete(temp,temp.Length,1);
                                         end;
                                       end;
                                     end;
                            else begin
                                   //Println($'{i} lol 3 {Str[i]} temp={temp} res={res} {unary} {priority(temp[temp.length])>=priority(Str[i])}');
                                   while (priority(temp[temp.length]) >= priority(Str[i])) do
                                   begin
                                     res += temp[temp.length];
                                     Delete(temp,temp.length,1);
                                     //Println($'{i} lol 4 {Str[i]} temp={temp} res={res} {unary}');
                                   end;
                                   temp += Str[i];
                                 end;
                          end;
                        end;
                        i += 1;
                      end;
                      Result := res;
                    end;
                  
                  function binor(tt1, tt2:array of boolean; num:integer):array of boolean;
                  begin
                    var tt3 := new boolean[Floor(Power(2,num))];
                    for var i := 0 to Floor(Power(2,num))-1 do
                      tt3[i] := tt1[i] or tt2[i];
                    result := tt3;
                  end;
                  
                function binand(tt1, tt2:array of boolean; num:integer):array of boolean;
                begin
                  var tt3 := new boolean[Floor(Power(2,num))];
                  for var i := 0 to Floor(Power(2,num))-1 do
                    tt3[i] := tt1[i] and tt2[i];
                  Result := tt3;
                end;
                  
              function binimp(tt1, tt2:array of boolean; num:integer):array of boolean;
                begin
                  var tt3 := new boolean[Floor(Power(2,num))];
                  for var i := 0 to Floor(Power(2,num))-1 do
                    tt3[i] := not tt1[i] or tt2[i];
                  Result := tt3;
                end;
            
            function binXOR(tt1, tt2:array of boolean; num:integer):array of boolean;
              begin
                var tt3 := new boolean[Floor(Power(2, num))];
                for var i := 0 to Floor(Power(2, num)) - 1 do
                  tt3[i] := (not tt1[i] and tt2[i]) or (tt1[i] and not tt2[i]);
                Result := tt3;
              end;
            
          function binXNOR(tt1, tt2:array of boolean; num:integer):array of boolean;
            begin
              var tt3 := new boolean[Floor(Power(2, num))];
              for var i := 0 to Floor(Power(2, num)) - 1 do
                tt3[i] := (tt1[i] and tt2[i]) or (not tt1[i] and not tt2[i]);
              Result := tt3;
            end;
        
        function binnot(tt1:array of boolean; num:integer):array of boolean;
          begin
            var tt3 := new boolean[Floor(Power(2, num))];
            for  var i := 0 to Floor(Power(2, num)) - 1 do
              tt3[i] := not tt1[i];
            Result := tt3;
          end;
          //a&(b+c)+d  abc+&d+
      
    function pcnf(tt:array of boolean; names:array of char):string;
    begin // alkorithm woobshe brilliant
      var cnf := '';
      for var i := 0 to tt.Length - 1 do
        if not tt[i] then
        begin
        cnf += '(';
          for var j := 0 to names.Length - 1 do
            begin
              if (i mod Floor(Power(2, names.Length - j)))<(Power(2, names.Length - 1 - j)) then 
              begin
                cnf += names[j];
              end
              else
              begin
                cnf += '!';
                cnf += names[j];
              end;
              cnf += '∨';
            end;
          Delete(cnf, cnf.Length, 1);
          cnf += ')∧';
        end;
      Delete(cnf, cnf.Length, 1);
      Result := cnf;
    end;
  
//непосредственно непосредственная программа

begin

  println($'Данная программа делает скнф/кнф; сднф/днф для дополнительной информации - наберите help');
  println;
  
    var cin := ''; 
  
  pin(cin);
  
  spacenormalise(cin);
  
    numOfwars := 0;
    
    var names : set of char = [];
    var err := 0;
    
  VarsName(cin, numOfwars, names, err);
    
  //Println(numOfwars, names);
    
  if numOfwars = 0 then
    begin
      Println($'меня обманули - обиделся(грустный смайлик)');
      exit;
    end;
  
  warnames := getvarsname(cin, numofwars, err);
  
  if err <> 0 then
    begin
      Println($'Crringe');
      Assert(err = 0,'Ошибка компиляции - нелогичное выражение');
      //тут будет кейс с ошибками, но он особо не нужен
    end;
  
  //println(warnames);
  
    lvar := new logvar[numofwars];
  
  //Println(lvar);
  
  for var inc := 0 to numofwars - 1 do
    lvar[Inc].tbl := new boolean[Floor(Power(2, numofwars))];
  
  absolutefalse := new boolean[Floor(Power(2, numofwars))];
  absolutetruth := new boolean[Floor(Power(2, numofwars))];
  
  for var inc := 0 to Floor(Power(2, numofwars))-1 do
    (absolutetruth[inc], absolutefalse[inc]) := (true, false);
  //Println(absolutefalse,absolutetruth);
  //Println(lvar);
      //лично задаю базовые значения для переменных
  for var inc1 := numofwars - 1 downto 0 do
    for var inc2 := 0 to Floor(Power(2, numofwars)) - 1 do
      begin
        if (Inc2 mod (Floor(Power(2, Inc1 + 1))))<(Floor(Power(2, inc1))) then
          lvar[numOfwars - 1 - inc1].tbl[Inc2] := false
        else 
          lvar[numOfwars - 1 - inc1].tbl[Inc2] := true;
        //Println(inc1,inc2,lvar[inc1],Inc2 mod (Floor(Power(2,inc1+1))),Floor(Power(2,inc1)));
      end;
  
  //Println(lvar);
  //Println('///////////////////////');
  Println($'Таким образом имеем для вас:');
  //Println(cin);
  
  var goodboi := polish(cin);
  
  //Println(goodboi);
  //Println;
  
  //Println(lvar);
  
  //Println($'ха, лол, таблицы исправляй');
  //Println(TTmaker(goodboi, warnames));
  
  if err <> 0 then
    begin
      Println($'Crringe');
      Assert(err = 0,'Ошибка компиляции - нелогичное выражение');
      //тут будет кейс с ошибками, но он особо не нужен
    end;
  
  //a&(b+c)+d
  var stuck := new Stack <array of boolean>;
  //var cin := ReadString('');
  var i := 1;
  
  cin:=goodboi;
  
  while i <= cin.Length do
  begin
    //Println(stuck);
    if cin[i] in opers then 
    begin
      if (cin[i] = '!') or (cin[i] = '¬') then
      begin
        var tp := stuck.Pop;
        tp := binnot(tp, numofwars);
        stuck.Push(tp);
      end
      else
      begin
        var tp1, tp2 : array of boolean;
        tp2 := stuck.Pop;
        tp1 := stuck.Pop;
        case cin[i] of
         '+','∨' : begin
                     var tp:array of boolean;
                     tp:=binor(tp1,tp2,numofwars);
                     stuck.Push(tp);
                   end;
         '&','∧' : begin
                     var tp:array of boolean;
                     tp:=binand(tp1,tp2,numofwars);
                     stuck.Push(tp);
                   end;
         '>','→' : begin
                     var tp:array of boolean;
                     tp:=binimp(tp1,tp2,numofwars);
                     stuck.Push(tp);
                   end;
           '~'   : begin
                     var tp:array of boolean;
                     tp:=binxnor(tp1,tp2,numofwars);
                     stuck.Push(tp);
                   end;
           '⊕'   : begin
                     var tp:array of boolean;
                     tp:=binxor(tp1,tp2,numofwars);
                     stuck.Push(tp);
                   end;
        end;
      end;
      
    end
    else
    begin
      
      if cin[i] = '1' then
        stuck.Push(absolutetruth)
      else
      if cin[i] = '0' then
        stuck.Push(absolutefalse)
      else
      begin
        var thatsame := 0;
        for thatsame := 0 to numofwars - 1 do
          if warnames[thatsame] = cin[i] then 
            break;
        stuck.push(lvar[thatsame].tbl);
      end;
    end;
    i+=1;
  end;
  
  var logout:=stuck.pop;
  
  //Println(logout);
  
  var cout:=pcnf(logout,warnames);
  if cout='' then 
    Println('Скнф не существует')
  else
    Println(cout);
  
  var s:='';
  Read(s);
  Assert(s<>'','Программа закончилась');
  
end.