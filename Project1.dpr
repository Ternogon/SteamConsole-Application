program Project1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Tlhelp32,
  Winapi.Windows, ShellApi;

var
  ent: integer;
  hCon: integer;

  function KillTask(ExeFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(
                        OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

procedure CLRSCR;
Var Max, Coord : TCoord;
ConHandle : THandle;
tmp : cardinal;
begin
ConHandle := GetStdHandle(STD_OUTPUT_HANDLE);
Coord.X := 0;
Coord.Y := 0;
Max := GetLargestConsoleWindowSize(ConHandle);
FillConsoleOutputCharacter(ConHandle, ' ', Max.X * Max.Y, Coord, tmp);
SetConsoleCursorPosition(ConHandle, Coord);
end;

Procedure Header;
begin
  CLRSCR;
hCon := GetStdHandle(STD_OUTPUT_HANDLE);
SetConsoleTextAttribute(hCon, 8);
WriteLn('Steamconsole by Ternogon | 16 apr 2017 | ternogon.net');
WriteLn('*****************************************************');
SetConsoleTextAttribute(hCon, 3);
WriteLn('Addicional information about steps:');
WriteLn('');
hCon := GetStdHandle(STD_OUTPUT_HANDLE);
SetConsoleTextAttribute(hCon, 10);
WriteLn('-------------------------');
WriteLn('|  Selected command: '+IntToStr(ent)+'  |');
WriteLn('-------------------------');
hCon := GetStdHandle(STD_OUTPUT_HANDLE);
SetConsoleTextAttribute(hCon, 3);
WriteLn('');
end;

function Realise(AppCode: Integer): Integer;
begin
Header;
WriteLn(' * Any program can start only if you manually installed via Steam!');
SetConsoleTextAttribute(hCon, 7);
WriteLn('');
ShellExecute(0, 'open',PWideChar(WideString('steam://rungameid/'+ (IntToStr(AppCode)))), nil, nil, SW_SHOWNORMAL);
Sleep(1500);
WriteLn('');
WriteLn('');
WriteLn(' - '+ IntToStr(AppCode) +' Launched!');
WriteLn('');
WriteLn('');
Write('Sc being killed after 3 sec. Dont close its manual!');
Sleep(3000);
Halt;
end;

begin
WriteLn('Steamconsole by Ternogon | 16 apr 2017 | ternogon.net');
WriteLn('*****************************************************');
WriteLn('Hello! Choose your command for Steamconsole...');
WriteLn('');
WriteLn('----------------------------------------------------');
WriteLn('  + Control Steam boot:');
WriteLn('1. Destroy Steam boot (Steam.exe)');
WriteLn('2. Destroy Steam webs (Steamwebhelper.exe)');
WriteLn('3. Instant destroy Steam (All Steam services)');
WriteLn(' - - - - - - - - - - - - ');
WriteLn('  + Launch Steam by def catalogs:');
WriteLn('4. Launch Steam of (C:\*)');
WriteLn('5. Launch Steam of (D:\*)');
WriteLn('6. Launch Steam of (E:\*)');
WriteLn(' - - - - - - - - - - - - ');
WriteLn('  + Launch apps by Steam:');
WriteLn('7.  Easy Anti-Cheat');
WriteLn('8.  Counter-Strike: Global Offensive');
WriteLn('9.  Defense of the Ancients 2');
WriteLn('10. Black Mesa');
WriteLn('11. Counter-Strike');
WriteLn('12. Counter-Strike: Source');
WriteLn(' - - - - - - - - - - - - ');
WriteLn('0. Exit');
WriteLn('----------------------------------------------------');
WriteLn('');
WriteLn('');
WriteLn('');
  Write('Enter your command: ');
  Read(ent);
  if ent=1 then
  begin
    Header;
WriteLn('This command stops the process Steam.exe not avoiding all the ');
WriteLn('possible problems and side effects from the abrupt stop of the process.');
SetConsoleTextAttribute(hCon, 7);
    WriteLn('');
    WriteLn('');
    Killtask('Steam.exe');
    Sleep(1000);
    WriteLn(' - Succefuly destroyed!');
    WriteLn('');
    WriteLn('');
    WriteLn('');
    Write('Press enter for kill me :D');
  end
  else if ent=2 then
       begin
         Header;
         WriteLn('This command stops the process Steam.exe not avoiding all the ');
         WriteLn('possible problems and side effects from the abrupt stop of the process.');
         SetConsoleTextAttribute(hCon, 7);
         WriteLn('');
         Killtask('steamwebhelper.exe');
         WriteLn(' - Successfuly destroyed!');
         WriteLn('');
         WriteLn('');
         WriteLn('');
         Write('Press enter for kill me :D');
       end
       else if ent=3 then
            begin
              Header;
              WriteLn('This command stops the process Steam.exe not avoiding all the ');
              WriteLn('possible problems and side effects from the abrupt stop of the process.');
              SetConsoleTextAttribute(hCon, 7);
              WriteLn('');
              Killtask('steam.exe');
              Killtask('steamwebhelper.exe');
              WriteLn(' - Successfuly destroyed!');
              WriteLn(' - Logs cleared and removed .bak files!');
              WriteLn('');
              WriteLn('');
              WriteLn('');
              Write('Press enter for kill me :D');
            end
            else if ent=4 then
                 begin
                   Header;
                   SetConsoleTextAttribute(hCon, 7);
                   WriteLn('');
                   ShellExecute(0, 'open','C:\Program Files (x86)\Steam\Steam.exe', nil, nil, SW_SHOWNORMAL);
                   //ExecAndWait( 'C:\Program Files (x86)\Steam\Steam.exe', '', SW_SHOWNORMAL);
                   WriteLn(' - Tryed a launch!');
                   Sleep(200);
                   WriteLn('');
                   WriteLn('If Steam does not start after you have specified the wrong directory when you install Steam.');
                   WriteLn('Stock directory for this command: "C:\Program Files (x86)\Steam\Steam.exe"');
                   WriteLn('');
                   WriteLn('');
                   WriteLn('');
                   Write('Press enter for kill me :D');
                 end
                 else if ent=5 then
                      begin
                        Header;
                        SetConsoleTextAttribute(hCon, 7);
                        WriteLn('');
                        ShellExecute(0, 'open','D:\Program Files (x86)\Steam\Steam.exe', nil, nil, SW_SHOWNORMAL);
                        //ExecAndWait( 'D:\Program Files (x86)\Steam\Steam.exe', '', SW_SHOWNORMAL);
                        //WriteLn('SteamDestroyer by Ternogon | 1 dec 2015 | netcomposition.ru');
                        //WriteLn('----------------------------------------------------');
                        //WriteLn('');
                        WriteLn(' - Tryed a launch!');
                        Sleep(200);
                        WriteLn('');
                        WriteLn('If Steam does not start after you have specified the wrong directory when you install Steam.');
                        WriteLn('Stock directory for this command: "D:\Program Files (x86)\Steam\Steam.exe"');
                        WriteLn('');
                        WriteLn('');
                        WriteLn('');
                        Write('Press enter for kill me :D');
                      end
                                else if ent=6 then                              //swap command
                                     begin
                                       Header;
                                       SetConsoleTextAttribute(hCon, 7);
                                       WriteLn('');
                                       ShellExecute(0, 'open','E:\Program Files (x86)\Steam\Steam.exe', nil, nil, SW_SHOWNORMAL);
                                       WriteLn(' - Tryed a launch!');
Sleep(200);
WriteLn('');
WriteLn('If Steam does not start after you have specified the wrong directory when you install Steam.');
WriteLn('Stock directory for this command: "E:\Program Files (x86)\Steam\Steam.exe"');
WriteLn('');
WriteLn('');
WriteLn('');
Write('Press enter for kill me :D');
                                     end
                                     else if ent=7 then
                                          begin
                                            Realise(282660);
                                          end
                                          else if ent=8 then
                                               begin
                                                 Realise(730);
                                               end
                                               else if ent=9 then
                                                    begin
                                                      Realise(570);
                                                    end
                                                    else if ent=10 then
                                                         begin
                                                           Realise(362890);
                                                         end
                                                         else if ent=11 then
                                                              begin
                                                                Realise(10);
                                                              end
                                                              else if ent=12 then
                                                                   begin
                                                                     Realise(240);
                                                                   end
                                                                   else if ent=13 then
                                                                     begin
                                                                       Realise(70);
                                                                     end
                      else
                      begin
                      WriteLn('Unknown command!');
                      WriteLn('');
                      WriteLn('');
                      Sleep(1000);
                      WriteLn('Press enter for kill me :D');
                      end;
ReadLn;
ReadLn;
end.

