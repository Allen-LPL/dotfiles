;=====================================================================o
;                   Feng Ruohang's AHK Script                         |
;                      CapsLock Enhancement                           |
;---------------------------------------------------------------------o
;Description:                                                         |
;    This Script is wrote by Feng Ruohang via AutoHotKey Script. It   |
; Provieds an enhancement towards the "Useless Key" CapsLock, and     |
; turns CapsLock into an useful function Key just like Ctrl and Alt   |
; by combining CapsLock with almost all other keys in the keyboard.   |
;                                                                     |
;Summary:                                                             |
;o----------------------o---------------------------------------------o
;|CapsLock;             | {ESC}  Especially Convient for vim user     |
;|CaspLock + `          | {CapsLock}CapsLock Switcher as a Substituent|
;|CapsLock + hjklwb     | Vim-Style Cursor Mover                      |
;|CaspLock + uiop       | Convient Home/End PageUp/PageDn             |
;|CaspLock + nm,.       | Convient Delete Controller                  |
;|CapsLock + zxcvay     | Windows-Style Editor                        |
;|CapsLock + Direction  | Mouse Move                                  |
;|CapsLock + Enter      | Mouse Click                                 |
;|CaspLock + {F1}~{F6}  | Media Volume Controller                     |
;|CapsLock + qs         | Windows & Tags Control                      |
;|CapsLock + ;'[]       | Convient Key Mapping                        |
;|CaspLock + dfert      | Frequently Used Programs (Self Defined)     |
;|CaspLock + 123456     | Dev-Hotkey for Visual Studio (Self Defined) |
;|CapsLock + 67890-=    | Shifter as Shift                            |
;-----------------------o---------------------------------------------o
;|Use it whatever and wherever you like. Hope it help                 |
;=====================================================================o


;=====================================================================o
;                       CapsLock Initializer                         ;|
;---------------------------------------------------------------------o
SetCapsLockState, AlwaysOff                                          ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                       CapsLock Switcher:                           ;|
;---------------------------------o-----------------------------------o
;                    CapsLock + ` | {CapsLock}                       ;|
;---------------------------------o-----------------------------------o
CapsLock & `::                                                       ;|
GetKeyState, CapsLockState, CapsLock, T                              ;|
if CapsLockState = D                                                 ;|
    SetCapsLockState, AlwaysOff                                      ;|
else                                                                 ;|
    SetCapsLockState, AlwaysOn                                       ;|
KeyWait, ``                                                          ;|
return                                                               ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                         CapsLock Escaper:                          ;|
;----------------------------------o----------------------------------o
;                        CapsLock  |  {ESC}                          ;|
;----------------------------------o----------------------------------o
CapsLock::
    if WinActive("ahk_exe goland64.exe") {
        SetEN() ;切换为英文0x4090409=67699721
        Send,{ESC}
    } Else if WinActive("ahk_exe happ.exe") {
        SetEN() ;切换为英文0x4090409=67699721
        Send,{ESC}
    } else{
        Send, {ESC}
    }
return
                                              ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                    CapsLock Direction Navigator                    ;|
;-----------------------------------o---------------------------------o
;                      CapsLock + h |  Left                          ;|
;                      CapsLock + j |  Down                          ;|
;                      CapsLock + k |  Up                            ;|
;                      CapsLock + l |  Right                         ;|
;                      Ctrl, Alt Compatible                          ;|
;-----------------------------------o---------------------------------o
CapsLock & h::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {Left}                                                 ;|
    else                                                             ;|
        Send, +{Left}                                                ;|
    return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{Left}                                                ;|
    else                                                             ;|
        Send, +^{Left}                                               ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;-----------------------------------o                                ;|
CapsLock & j::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {Down}                                                 ;|
    else                                                             ;|
        Send, +{Down}                                                ;|
    return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{Down}                                                ;|
    else                                                             ;|
        Send, +^{Down}                                               ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;-----------------------------------o                                ;|
CapsLock & k::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {Up}                                                   ;|
    else                                                             ;|
        Send, +{Up}                                                  ;|
    return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{Up}                                                  ;|
    else                                                             ;|
        Send, +^{Up}                                                 ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;-----------------------------------o                                ;|
CapsLock & l::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {Right}                                                ;|
    else                                                             ;|
        Send, +{Right}                                               ;|
    return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{Right}                                               ;|
    else                                                             ;|
        Send, +^{Right}                                              ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                     CapsLock Home/End Navigator                    ;|
;-----------------------------------o---------------------------------o
;                      CapsLock + i |  Home                          ;|
;                      CapsLock + o |  End                           ;|
;                      Ctrl, Alt Compatible                          ;|
;-----------------------------------o---------------------------------o
CapsLock & i::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {Home}                                                 ;|
    else                                                             ;|
        Send, +{Home}                                                ;|
    return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{Home}                                                ;|
    else                                                             ;|
        Send, +^{Home}                                               ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;-----------------------------------o                                ;|
CapsLock & o::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {End}                                                  ;|
    else                                                             ;|
        Send, +{End}                                                 ;|
    return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{End}                                                 ;|
    else                                                             ;|
        Send, +^{End}                                                ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                      CapsLock Page Navigator                       ;|
;-----------------------------------o---------------------------------o
;                      CapsLock + u |  PageUp                        ;|
;                      CapsLock + p |  PageDown                      ;|
;                      Ctrl, Alt Compatible                          ;|
;-----------------------------------o---------------------------------o
CapsLock & u::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {PgUp}                                                 ;|
    else                                                             ;|
        Send, +{PgUp}                                                ;|
    return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{PgUp}                                                ;|
    else                                                             ;|
        Send, +^{PgUp}                                               ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;-----------------------------------o                                ;|
CapsLock & p::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {PgDn}                                                 ;|
    else                                                             ;|
        Send, +{PgDn}                                                ;|
    return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{PgDn}                                                ;|
    else                                                             ;|
        Send, +^{PgDn}                                               ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                     CapsLock Mouse Controller                      ;|
;-----------------------------------o---------------------------------o
;                   CapsLock + Up   |  Mouse Up                      ;|
;                   CapsLock + Down |  Mouse Down                    ;|
;                   CapsLock + Left |  Mouse Left                    ;|
;                  CapsLock + Right |  Mouse Right                   ;|
;    CapsLock + Enter(Push Release) |  Mouse Left Push(Release)      ;|
;-----------------------------------o---------------------------------o
CapsLock & Up::    MouseMove, 0, -10, 0, R                           ;|
CapsLock & Down::  MouseMove, 0, 10, 0, R                            ;|
CapsLock & Left::  MouseMove, -10, 0, 0, R                           ;|
CapsLock & Right:: MouseMove, 10, 0, 0, R                            ;|
;-----------------------------------o                                ;|
CapsLock & Enter::                                                   ;|
SendEvent {Blind}{LButton down}                                      ;|
KeyWait Enter                                                        ;|
SendEvent {Blind}{LButton up}                                        ;|
return                                                               ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                           CapsLock Deletor                         ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + n  |  Ctrl + Delete (Delete a Word) ;|
;                     CapsLock + m  |  Delete                        ;|
;                     CapsLock + ,  |  BackSpace                     ;|
;                     CapsLock + ,  |  BackSpace                     ;|
;                     CapsLock + ,  |  BackSpace                     ;|
;                     CapsLock + .  |  Ctrl + BackSpace              ;|
;-----------------------------------o---------------------------------o
CapsLock & ,:: Send, {Del}                                           ;|
CapsLock & .:: Send, ^{Del}                                          ;|
CapsLock & m:: Send, {BS}                                            ;|
CapsLock & n:: Send, ^{BS}                                           ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                            CapsLock Editor                         ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + z  |  Ctrl + z (Cancel)             ;|
;                     CapsLock + x  |  Ctrl + x (Cut)                ;|
;                     CapsLock + c  |  Ctrl + c (Copy)               ;|
;                     CapsLock + v  |  Ctrl + z (Paste)              ;|
;                     CapsLock + a  |  Ctrl + a (Select All)         ;|
;                     CapsLock + y  |  Ctrl + z (Yeild)              ;|
;                     CapsLock + w  |  Ctrl + Right(Move as [vim: w]);|
;                     CapsLock + b  |  Ctrl + Left (Move as [vim: b]);|
;-----------------------------------o---------------------------------o
;CapsLock & z:: Send, ^z                                              ;|
;CapsLock & x:: Send, ^x                                              ;|
;CapsLock & c:: Send, ^c                                              ;|
;CapsLock & v:: Send, ^v                                              ;|
CapsLock & c:: 
    IfWinActive,ahk_exe ApplicationFrameHost.exe
    {
        Send,^+c
    } else{
        Send,^c
    }
return
CapsLock & v:: 
    IfWinActive,ahk_exe ApplicationFrameHost.exe
    {
        Send,^+v
    } Else if WinActive("ahk_exe Code.exe") {
        Send,s^v
    } else{
        Send,^v
    }
return
CapsLock & y:: Send, ^y                                              ;|
CapsLock & b:: Send, ^{Left}                                         ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                       CapsLock Media Controller                    ;|
;-----------------------------------o---------------------------------o
;                    CapsLock + F1  |  Volume_Mute                   ;|
;                    CapsLock + F2  |  Volume_Down                   ;|
;                    CapsLock + F3  |  Volume_Up                     ;|
;                    CapsLock + F3  |  Media_Play_Pause              ;|
;                    CapsLock + F5  |  Media_Next                    ;|
;                    CapsLock + F6  |  Media_Stop                    ;|
;-----------------------------------o---------------------------------o
CapsLock & F1:: Send, {Volume_Mute}                                  ;|
CapsLock & F2:: Send, {Volume_Down}                                  ;|
CapsLock & F3:: Send, {Volume_Up}                                    ;|
CapsLock & F4:: Send, {Media_Play_Pause}                             ;|
CapsLock & F5:: Send, {Media_Next}                                   ;|
CapsLock & F6:: Send, {Media_Stop}                                   ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                      CapsLock Window Controller                    ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + d  |  Ctrl + Tab (Swith Tag)        ;|
;                     CapsLock + s  |  Ctrl + shift + Tab (Swith Tag);|
;                     CapsLock + q  |  Ctrl + W   (Close Tag)        ;|
;   (Disabled)  Alt + CapsLock + s  |  AltTab     (Switch Windows)   ;|
;               Alt + CapsLock + q  |  Ctrl + Tab (Close Windows)    ;|
;                     CapsLock + g  |  AppsKey    (Menu Key)         ;|
;-----------------------------------o---------------------------------o
CapsLock & d::Send, ^{Tab}                                           ;|
CapsLock & s::Send, ^+{Tab}                                          ;|
;-----------------------------------o                                ;|
CapsLock & q::                                                       ;|
if GetKeyState("alt") = 0                                            ;|
{                                                                    ;|
    Send, ^w                                                         ;|
}                                                                    ;|
else {                                                               ;|
    Send, !{F4}                                                      ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;-----------------------------------o                                ;|
CapsLock & g:: Send, Allen{(}{!})1293233                                 ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                        CapsLock Self Defined Area                  ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + d  |  Alt + d(Dictionary)           ;|
;                     CapsLock + f  |  \                             ;|
;                     CapsLock + e  |  Open Search Engine            ;|
;                     CapsLock + r  |  Open vscode                    ;|
;                     CapsLock + t  |  Open Text Editor              ;|
;-----------------------------------o---------------------------------o
CapsLock & e::                                              ;|
    SetEN() ;切换为英文0x4090409=67699721
return                                                               ;|
CapsLock & w::                                         ;|
    SetCN()                                                  ;|
return

    



CapsLock & f::                                                ;|
if GetKeyState("alt") = 0                                            ;|
{                                                                    ;|
    Send, \\F                                                       ;|
}                                                                       ;|
else {                                                               ;|
    Send, \\f                                                     ;|
    return                                                           ;|
}                                                                    ;|
return                                                               ;|
;CapsLock & t:: Run C:\Program Files (x86)\Notepad++\notepad++.exe    ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                        CapsLock Char Mapping                       ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + ;  |  Enter (Cancel)                ;|
;                     CapsLock + '  |  =                             ;|
;                     CapsLock + [  |  Back         (Visual Studio)  ;|
;                     CapsLock + ]  |  Goto Define  (Visual Studio)  ;|
;                     CapsLock + /  |  +                             ;|
;                     CapsLock + \  |  Uncomment    (Visual Studio)  ;|
;                     CapsLock + 1  |  Build and Run(Visual Studio)  ;|
;                     CapsLock + 2  |  Debuging     (Visual Studio)  ;|
;                     CapsLock + 3  |  Step Over    (Visual Studio)  ;|
;                     CapsLock + 4  |  Step In      (Visual Studio)  ;|
;                     CapsLock + 5  |  Stop Debuging(Visual Studio)  ;|
;                     CapsLock + 6  |  Shift + 6     ^               ;|
;                     CapsLock + 7  |  Shift + 7     &               ;|
;                     CapsLock + 8  |  Shift + 8     *               ;|
;                     CapsLock + 9  |  Shift + 9     (               ;|
;                     CapsLock + 0  |  Shift + 0     )               ;|
;-----------------------------------o---------------------------------o
CapsLock & `;:: Send, {Enter}                                        ;|
CapsLock & ':: Send, =                                               ;|
CapsLock & [:: Send, ^-                                              ;|
CapsLock & ]:: Send, {F12}                                           ;|

CapsLock & /:: Send, {NumpadAdd}                                              ;|
;-----------------------------------o                                ;|
;CapsLock & /::                                                       ;|
;Send, ^e                                                             ;|
;Send, c                                                              ;|
;return                                                               ;|
;-----------------------------------o                                ;|
;CapsLock & \::                                                       ;|
;Send, ^e                                                             ;|
;Send, u                                                              ;|
;return                                                               ;|
;-----------------------------------o                                ;|
;CapsLock & 1:: Send,{F1}                                            ;|
;CapsLock & 2:: Send,{F5}                                             ;|
;CapsLock & 3:: Send,{F10}                                            ;|
;CapsLock & 4:: Send,{F11}                                            ;|
CapsLock & 5:: Send,^{F5}                                            ;|
;-----------------------------------o                                ;|
CapsLock & 6:: Send,+{F6}                                               ;|
CapsLock & 7:: Send,+7                                               ;|
CapsLock & 8:: Send,+8                                               ;|
CapsLock & 9:: Send,+9                                               ;|
CapsLock & 0:: Send,+0                                               ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                            vscode setting                          ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + x  |        展示所有标签列表(vscode)  ;|
;                     CapsLock + Alt + x  |  清空所有标签(vscode)     ;|
;                     CapsLock + e  |  Open Search Engine            ;|
;                     CapsLock + r  |  Open vscode                   ;|
;                     CapsLock + t  |  Open Text Editor              ;|
;-----------------------------------o---------------------------------o
; vscode中展开bookmarks列表 (需要将设置bookmarks列表快捷键设置为Ctrl + Win + Alt + ;)
; 快速启动autohostkey编译器
CapsLock & x::
    IfWinActive,ahk_exe Code.exe
    {
        if GetKeyState("alt") = 0                                       
        {                                                                    
            Send,#^!+;
        }  else {                                                              
            Send,#^!;                                                
        } 
    } else {
        hyf_onekeyWindow("D:\Soft\AutoHotkey\Compiler\Ahk2Exe.exe", "AutoHotkeyGUI", "\S")
    }
return

; 默认情况执行vscode时执行f1
RAlt::
    IfWinActive,ahk_exe Code.exe
    {
        Send,{F1}  
    } else {
        ;Send,#^!z
    }
return
;-----------------------------------o---------------------------------o
; 左win 与 左alter 互换
;LWin::LAlt
;LAlt::LWin


; 快速开启everything
CapsLock & z::
    IfWinNotActive,ahk_class EVERYTHING 
    {
        Run C:\Program Files\Everything\Everything.exe
    }
    else 
    {
        WinMinimize
    }
Return

;!1:: Send,#^{Left} ;按 Alt + ← 切换到左侧虚拟桌面
;!2:: Send,#^{Right} ;按 Alt + → 切换到右侧虚拟桌面
CapsLock & 1:: 
    IfWinActive,ahk_exe Code.exe
    {
        Send,^k^s
        ;Send,#1
    } Else if WinActive("ahk_exe EoCApp.exe") { ; 神界原罪2
        Send,{F1}
    }
    ;  Else if WinActive("ahk_exe goland64.exe") { ; 神界原罪2
     ;   Send,{F1}
    ;}
    else {
        hyf_onekeyWindow("C:\Users\RAZER\AppData\Local\JetBrains\Toolbox\apps\Goland\ch-0\211.7442.57\bin\goland64.exe", "SunAwtFrame", "\S")
        ;Send,#1
        ;hyf_onekeyWindow("D:\Soft\JetBrains\PyCharm 2021.2.1\bin\pycharm64.exe", "SunAwtFrame", "\S")
    }
return
CapsLock & 2:: 
    IfWinActive,ahk_exe EoCApp.exe
    {
        Send,{F2}
    } Else if WinActive("ahk_exe Code.exe") {
        Send,{ESC}{,}{,}s
    }  Else if WinActive("ahk_exe goland64.exe") {
        PostMessage, 0x50, 0, 0x4090409, , A ;切换为英文0x4090409=67699721
        Send,^;
    } else{
        Send,#2
    }
return

Space:: SendInput, {Space}

;CapsLock & 1::hyf_onekeyWindow("‪C:\Users\Administrator\AppData\Local\JetBrains\Toolbox\apps\PyCharm-P\ch-0\212.5080.64\bin\pycharm64.exe", "SunAwtFrame", "\S") 

; 快速开启goland64
;CapsLock & 2::hyf_onekeyWindow("C:\Users\RAZER\AppData\Local\Programs\Microsoft VS Code\Code.exe", "Chrome_WidgetWin_1", "\S")
;CapsLock & 2::hyf_onekeyWindow("C:\Soft\Microsoft VS Code\Code.exe", "Chrome_WidgetWin_1", "\S")
;CapsLock & 2::run,tencent://message/?uin=523720288
;CapsLock & 2::hyf_onekeyWindow("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe", "Chrome_WidgetWin_1", "\S")
;CapsLock & 2::hyf_onekeyWindow("C:\Users\Administrator\Downloads\Winbfy3.0c3.exe", "FMTFormMain", "\S")

CapsLock & 3:: 
    IfWinActive,ahk_exe EoCApp.exe
    {
        Send,{F5}
    } Else if WinActive("ahk_exe Code.exe") {
        Send,^+p  
    } Else if WinActive("ahk_exe goland64.exe") {
        ;Send,+{ESC}
        Send,^{F5}
    } else{
        ; 快速开启phpstorm64
        hyf_onekeyWindow("C:\Users\RAZER\AppData\Local\JetBrains\Toolbox\apps\PhpStorm\ch-0\211.7442.50\bin\phpstorm64.exe", "SunAwtFrame", "\S")
    }
return
CapsLock & 4:: 
    IfWinActive,ahk_exe EoCApp.exe
    {
        Send,{F8}
    } Else if WinActive("ahk_exe Code.exe") {
        Send,#1
        ;Send,#^!'
    }  else{
        Send,#1
        ;hyf_onekeyWindow("C:\Users\Administrator\AppData\Local\JetBrains\Toolbox\apps\PyCharm-P\ch-0\212.5080.64\bin\pycharm64.exe", "SunAwtFrame", "\S")
    }
return

;CapsLock & 4::hyf_onekeyWindow("C:\Program Files\Android\Android Studio\bin\studio64.exe", "SunAwtFrame", "\S")
;CapsLock & 4::hyf_onekeyWindow("C:\Program Files (x86)\Netease\CloudMusic\cloudmusic.exe", "OrpheusBrowserHost", "\S")
;CapsLock & 4::hyf_onekeyWindow("C:\Soft\Nox\bin\Nox.exe", "Qt5QWindowIcon", "\S")

; 快速开启XYplorer
;CapsLock & r::hyf_onekeyWindow("C:\Program Files (x86)\XYplorer\XYplorer.exe", "ThunderRT6FormDC", "\S")

;CapsLock & a:: #^!0
;CapsLock & a::hyf_onekeyWindow("C:\Users\Administrator\AppData\Local\Wox\app-1.4.1196\Wox.exe", "VirtualConsoleClass", "\S")
;return

; 快速开启wox
CapsLock & a::
    SetEN()
    Send,#^!0
return

; 快速开启Wechat.exe;
Space & 1::hyf_onekeyWindow("D:\Soft\Tencent\WeChat\WeChat.exe", "WeChatMainWndForPC", "\S")

; 快速开启chrome
Space & 2:: hyf_onekeyWindow("C:\Program Files\Google\Chrome\Application\chrome.exe", "Chrome_WidgetWin_1", "\S")

; 快速开启navicat
Space & 3::hyf_onekeyWindow("D:\Soft\Navicat Premium 15\navicat.exe", "TNavicatMainForm", "\S")

; vscode中快速启动终端 (需要将终端快捷键设置为Ctrl + Win + Alt + ')
; 快速开启MobaXterm
Space & 4::
    IfWinActive,ahk_exe Code.exe
    {
        ;Send,#^!'  
        hyf_onekeyWindow("D:\Soft\MobaXterm_Portable\MobaXterm_Personal_20.0.exe", "TMobaXtermForm", "\S")
    } else {
        hyf_onekeyWindow("D:\Soft\MobaXterm_Portable\MobaXterm_Personal_20.0.exe", "TMobaXtermForm", "\S")
    }
return

; 快速开启goland
Space & 5::hyf_onekeyWindow("C:\Users\RAZER\AppData\Local\JetBrains\Toolbox\apps\Goland\ch-0\211.7442.57\bin\goland64.exe", "SunAwtFrame", "\S")
Space & 6::Run, %ComSpec% /k Ahk2Exe.exe /in D:\Code\dotfiles\windows10\autohotkey\CapsLockSmall.ahk /out D:\Code\dotfiles\windows10\autohotkey\CapsLockSmall.exe
Space & 7::Run, %ComSpec% /k D:\Code\dotfiles\windows10\docker-ip-setting.bat

; 快速启动程序的核心程序
hyf_onekeyWindow(exePath, titleClass := "", titleReg := "")
{ ;有些窗口用Ahk_exe exeName判断不准确，所以自定义个titleClass
    SplitPath, exePath, exeName, , , noExt
    If !hyf_processExist(exeName)
    {
        ;hyf_tooltip("启动中，请稍等...")
        Run,% exePath
        ;打开后自动运行 TODO
        funcName := noExt . "_runDo"
        If IsFunc(funcName)
        {
            ;hyf_tooltip("已自动执行函数：" . funcName)
            Func(funcName).Call()
        }
        Else If titleClass
        {
            WinWait, Ahk_class %titleClass%, , 1
            WinActivate Ahk_class %titleClass%
        } 
    }
    Else If WinActive("Ahk_exe " . exeName)
    {
        funcName := noExt . "_hideDo"
        If IsFunc(funcName)
            Func(funcName).Call()
        ;WinHide
        WinMinimize
        ;激活鼠标所在窗口 TODO
        MouseGetPos, , , idMouse
        WinActivate Ahk_id %idMouse%
    }
    Else
    {
        If titleReg
            titleClass := "Ahk_id " . hyf_getMainIDOfProcess(exeName, titleClass, titleReg)
        Else If titleClass
            titleClass := "Ahk_class " . titleClass
        Else
            titleClass := "Ahk_exe " . exeName
        WinShow %titleClass%
        WinActivate %titleClass%
        funcName := noExt . "_activeDo"
        If IsFunc(funcName)
        {
            ;hyf_tooltip("已自动执行函数：" . funcName)
            Func(funcName).Call()
        }
    }
}

hyf_processExist(n) ;判断进程是否存在（返回PID）
{ ;n为进程名
    Process, Exist, %n% ;比IfWinExist可靠
    Return ErrorLevel
}
 
hyf_tooltip(str, t := 1, ExitScript := 0, x := "", y := "")  ;提示t秒并自动消失
{
    t *= 1000
    ToolTip, %str%, %x%, %y%
    SetTimer, hyf_removeToolTip, -%t%
    If ExitScript
    {
        Gui, Destroy
        Exit
    }
}
 
hyf_getMainIDOfProcess(exeName, cls, titleReg := "") ;获取类似chrome等多进程的主程序ID
{
    DetectHiddenWindows, On
    WinGet, arr, List, Ahk_exe %exeName%
    Loop,% arr
    {
        n := arr%A_Index%
        WinGetClass, classLoop, Ahk_id %n%
        ;MsgBox,% A_Index . "/" . arr . "`n" . classLoop . "`n" . cls
        If (classLoop = cls)
        {
            If !StrLen(titleReg) ;不需要判断标题
                Return n
            WinGetTitle, titleLoop, Ahk_id %n%
            ;MsgBox,% A_Index . "/" . arr . "`n" . classLoop . "`n" . titleLoop
            If (titleLoop ~= titleReg)
                Return n
        }
        Continue
    }
    Return False
}
 
hyf_removeToolTip() ;清除ToolTip
{
    ToolTip
}

; 自动 开启/激活窗口/最小化或关闭窗口
AutoExec(CLASS, PATH, ISCLOSE = false) 
{
    IfWinNotExist,ahk_exe %CLASS%
    {
        Run %PATH%
        WinActivate
    }
    Else IfWinNotActive,ahk_exe %CLASS%
    {
        WinActivate
    }
    Else
    {
        if !ISCLOSE 
            WinMinimize
        Else 
            WinClose
        
    }
    
    Return
}

SetEN()
{
    PostMessage, 0x50, 0, 0x4090409, , A ;切换为英文0x4090409=67699721
}

SetCN()
{
    PostMessage, 0x50, 0, 0x4090409, , A ;切换为英文0x4090409=67699721
    PostMessage, 0x50, 0, 0x8040804, , A ;切换为中文，可以在搜狗输入法中设置默认为英文输入
}

; 示例 : 在任务栏上滚动鼠标来调节音量.ddd
#If MouseIsOver("ahk_class Shell_TrayWnd")
WheelUp::Send {Volume_Up}
WheelDown::Send {Volume_Down}

MouseIsOver(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle . " ahk_id " . Win)
}
Return

;;;;;;;;[ahk]AutoHotkey从EXCEL 获取单元格内容;;;;;;;;;;

;excel := ComObjActive("Excel.Application") ; 创建Excel 对象
;Sheet:=excel.Worksheets["Sheet1"]
;获取Sheet1的A1 单元格内容
;MsgBox % Sheet.Cells[1,1].Value

;代码块快速注释
#c:: 
    send ^c
    thisvar := clipboard 
    thisvar := "<!--" . thisvar . "-->" 
    clipboard := thisvar
    send ^v 
return 

#z::
    send ^c
    thisvar := clipboard
    thisvar := "/*" . thisvar . "*/"
    clipboard := thisvar
    send ^v
return
   


;;; 复制文件的路径;
^+c::
; null= 
send ^c
sleep,200
clipboard=%clipboard% ;%null%
tooltip,%clipboard%
sleep,500
tooltip,
return


