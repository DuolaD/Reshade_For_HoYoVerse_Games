@echo off

chcp 936

title HoYoShade Starter
cls

net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

set files_to_check=("inject.exe" "ReShade64.dll" "InjectResource" "convert_encoding.bat" "InjectResource\INIBuild.exe" "InjectResource\msyhbd.ttc")

setlocal enabledelayedexpansion
cd /d "%~dp0"

set missing_file=0
for %%f in %files_to_check% do (
    if not exist %%~f (
        set missing_file=1
    )
)

if %missing_file% equ 1 (
    title HoYoShade啓動器
    cls
    echo 歡迎使用HoYoShade啓動器！
    echo\
    echo 模組版本：V2.4.0 Stable
    echo 開發者：DuolaDStudio X 阿向菌AXBro X Ex_M
    echo\
    echo 我們檢測到（Open）HoYoShade框架注入所需的必要文件不存在。
    echo\
    echo 出現這個提示的原因可能有：
    echo 1:你在解壓壓縮包時沒有解壓全部文件。
    echo 2:你在進行覆蓋更新操作的時候沒有粘貼全部文件。
    echo 3:你係統上的殺毒軟件/其它程序誤將（Open）HoYoShade識別爲病毒，然後刪除了某些文件。
    echo 4:你無意/有意重命名了部分關鍵文件。
    echo\
    echo 按下任意鍵後啓動器將會退出運行。
    echo 如果你想繼續運行（Open）HoYoShade，請訪問我們的GitHub倉庫（https://github.com/DuolaD/HoYoShade）重新下載最新版Releases界面中提供的壓縮包，並解壓全部文件。
    pause
    exit
)

set "filepath=%~dp0Reshade.ini"

if exist "%filepath%" (
    goto menu
) else (
    cls
    start "" /wait /b ".\InjectResource\INIBuild.exe"
    start "" "convert_encoding.bat"
    :FileCheck
    cls
    echo 歡迎使用HoYoShade啓動器！
    echo\
    echo 模組版本：V2.4.0 Stable
    echo 開發者：DuolaDStudio X 阿向菌AXBro X Ex_M
    echo\
    echo 我們檢測到你是第一次使用本模組，Reshade.ini現已生成至模組根目錄中。
    echo 你需要將Reshade.ini複製到遊戲進程根目錄，然後才能使用本模組。
    echo\
    echo 如何找到遊戲進程根目錄？  
    echo 對於HoYoPlay（米哈遊啟動器）:點擊開始啟動按鈕旁的更多圖標-遊戲設定即可查看遊戲進程根目錄。  
    echo 點選'開啟所在目錄'即可使用資源管理器開啟遊戲進程根目錄。  
    echo\
    echo 對於StarWard:點擊開始啟動按鈕旁的齒輪圖標即可查看遊戲進程根目錄。  
    echo 點選遊戲進程根目錄即可使用資源管理器開啟遊戲進程根目錄。  
    echo\
    echo 仍然不懂如何操作？你可以在模組根目錄/Tutorial資料夾中查看用戶協議和圖文安裝說明。
    echo\
    pause
    goto menu
)

:menu
title HoYoShade Starter
cls
echo 歡迎使用HoYoShade啓動器！
echo\
echo 模組版本：V2.4.0 Stable
echo 開發者：DuolaDStudio X 阿向菌AXBro X Ex_M
echo\
echo 請注意，你需要將Reshade.ini複製到遊戲進程根目錄，然後才能使用本模組。
echo\
echo 本模組僅用於遊戲畫面調色使用，請遵守本Mod的用戶協議及遊戲及其開發/發行商相關條例。
echo 你可以在模組根目錄/Tutorial資料夾中查看使用者協定和圖文安裝說明。
REM 我還是更愿意當一個在背後默默付出的人 XD
echo\
echo [1]重置模組根目錄中的ReShade.ini
echo [2]注入至原神（中國大陸服/嗶哩嗶哩服客戶端）
echo [3]注入至原神（國際服客戶端/Epic客戶端）
echo [4]注入至崩壞三（通用客戶端）
echo [5]注入至崩壞：星穹鐵道（通用客戶端）
echo [6]注入至絕區零（通用客戶端）
echo [7]切換至測試服客戶端注入列表
echo [8]聯動Blender/留影機插件注入至原神
echo [9]其它選項
echo [10]退出程序

echo\
set /p "content=在此輸入選項前面的數字："

echo\

if "%content%" == "1" (
    goto ini_Reset
) else if "%content%" == "2" (
    :YS_CheckProcess
    tasklist /FI "IMAGENAME eq YuanShen.exe" | find /i "YuanShen.exe" >nul
    if not errorlevel 1 (
        taskkill /IM YuanShen.exe /F >nul 2>&1
        goto YS_CheckProcess
    )
    echo 你所選擇的注入目標為:原神（中國大陸服/嗶哩嗶哩服客戶端）
    echo 注入器現已啟動。確保ReShade.ini複製到正確的遊戲進程根目錄之後，你現在可以使用啟動器啟動遊戲了。注入器會一併注入。
    echo 如果你選擇了錯誤的注入目標，只需關閉此視窗後重新運行啟動器重新選擇即可。
    echo\
    start "" /wait /b inject.exe YuanShen.exe
    exit
) else if "%content%" == "3" (
    :GI_CheckProcess
    tasklist /FI "IMAGENAME eq GenshinImpact.exe" | find /i "GenshinImpact.exe" >nul
    if not errorlevel 1 (
        taskkill /IM GenshinImpact.exe /F >nul 2>&1
        goto GI_CheckProcess
    )
    echo 你所選擇的注入目標為:原神（國際服客戶端/Epic客戶端）
    echo 注入器現已啟動。確保ReShade.ini複製到正確的遊戲進程根目錄之後，你現在可以使用啟動器啟動遊戲了。注入器會一併注入。
    echo 如果你選擇了錯誤的注入目標，只需關閉此視窗後重新運行啟動器重新選擇即可。
    echo\
    start "" /wait /b inject.exe GenshinImpact.exe
    exit
) else if "%content%" == "4" (
    echo 你所選擇的注入目標為:崩壞三（通用客戶端）
    echo 注入器現已啟動。確保ReShade.ini複製到正確的遊戲進程根目錄之後，你現在可以使用啟動器啟動遊戲了。注入器會一併注入。
    echo 如果你選擇了錯誤的注入目標，只需關閉此視窗後重新運行啟動器重新選擇即可。
    echo\
    start "" /wait /b inject.exe BH3.exe
    exit
) else if "%content%" == "5" (
    echo 你所選擇的注入目標為:崩壞：星穹鐵道（通用客戶端）
    echo 注入器現已啟動。確保ReShade.ini複製到正確的遊戲進程根目錄之後，你現在可以使用啟動器啟動遊戲了。注入器會一併注入。
    echo 如果你選擇了錯誤的注入目標，只需關閉此視窗後重新運行啟動器重新選擇即可。
    echo\
    start "" /wait /b inject.exe StarRail.exe
    exit
) else if "%content%" == "6" (
    echo 你所選擇的注入目標為:絕區零（通用客戶端）
    echo 注入器現已啟動。確保ReShade.ini複製到正確的遊戲進程根目錄之後，你現在可以使用啟動器啟動遊戲了。注入器會一併注入。
    echo 如果你選擇了錯誤的注入目標，只需關閉此視窗後重新運行啟動器重新選擇即可。
    echo\
    start "" /wait /b inject.exe ZenlessZoneZero.exe
    exit
) else if "%content%" == "7" (
    goto beta_client_inject_choice_menu
) else if "%content%" == "8" (
    goto blender_hook_check
) else if "%content%" == "9" (
    goto other
) else if "%content%" == "10" (
    exit
) else (
    echo 輸入錯誤。
    timeout /t 2
    goto menu
    )
exit

:other
title HoYoShade Starter
cls
echo 歡迎使用HoYoShade啓動器！
echo\
echo 模組版本：V2.4.0 Stable
echo 開發者：DuolaDStudio X 阿向菌AXBro X Ex_M
echo\
echo 如果你需要檢查版本更新，可以去訪問我們的倉庫查看是否有發行更新版本
echo 注意！開發者選項僅用於調試/檢測錯誤需求。除非開發者明確要求你這樣做，或者你很清楚知道自己在做什麼，否則請勿輕易使用！
echo\
echo 註：CYteam下載站除了提供本模組的鏡像下載之外，還在中國大陸地區提供免費的國際服原神/崩鐵/HoYoLAB安裝包和私服資源。
echo 除此之外，CYteam也提供一些安卓的搞機資源。有興趣的可以去看一看~
echo 感謝CYteam提供的下載站服務
echo\
echo [1]訪問我們的GitHub倉庫
echo [2]訪問由CYteam提供的下載站服務
echo [3]贊助本Mod
echo [4]聯係我們
echo [5]關於HoYoShade
echo [6]開發者選項
echo [7]返回主介面
echo [8]退出程序

echo\
set /p "content=在此輸入選項前面的數字："

if "%content%" == "1" (
    start "" "https://github.com/DuolaD/HoYoShade/"
    goto other
) else if "%content%" == "2" (
    start "" "https://d.cyteam.cn/"
    goto other
) else if "%content%" == "3" (
    start "" "https://github.com/DuolaD/HoYoShade/blob/V2.X.X-Stable/Readme.Chinese_Traditional.md#%E3%80%A2-%E8%B4%8A%E5%8A%A9"
    goto other
) else if "%content%" == "4" (
    start "" "https://github.com/DuolaD/HoYoShade/blob/V2.X.X-Stable/Readme.Chinese_Traditional.md#%E3%80%A2-%E8%81%AF%E7%B9%AB%E6%88%91"
    goto other
) else if "%content%" == "5" (
    goto about_HoYoShade
) else if "%content%" == "6" (
    goto develop
) else if "%content%" == "7" (
    goto menu
) else if "%content%" == "8" (
    exit
) else (
    echo\
    echo 輸入錯誤。
    timeout /t 2
    goto other
)
goto other

:develop
title HoYoShade Starter(你已進入開發者選項！！！)
cls
echo 歡迎使用HoYoShade啓動器！
echo\
echo 模組版本：V2.4.0 Stable
echo 開發者：DuolaDStudio X 阿向菌AXBro X Ex_M
echo\
echo 注意！開發者選項僅用於調試/檢測錯誤需求。除非開發者明確要求你這樣做，或者你很清楚知道自己在做什麼，否則請勿輕易使用！
echo\
echo [1]自定義注入
echo [2]返回主界面
echo [3]返回其它選項
echo [4]退出程序

echo\
set /p "content=在此輸入選項前面的數字："

if "%content%" == "1" (
    goto customize_inject
) else if "%content%" == "2" (
    goto menu
) else if "%content%" == "3" (
    goto other
) else if "%content%" == "4" (
    exit
) else (
    echo\
    echo 輸入錯誤。
    timeout /t 2
    goto develop
)
goto develop@echo off

:customize_inject
title HoYoShade Starter(你已進入自定義注入界面！！！)
cls
echo 歡迎使用HoYoShade啓動器！
echo\
echo 模組版本：V2.4.0 Stable
echo 開發者：DuolaDStudio X 阿向菌AXBro X Ex_M
echo\
echo 注意！此功能僅供開發者測試新遊戲使用。這意味着可能會存在未知風險/Bug。
echo 除非開發者明確要求你這樣做，或者你很清楚知道自己在做什麼，否則請不要擅自使用此功能注入Reshade至其它遊戲內。
echo\
echo 使用方法：輸入目標程序文件名即可，無需添加'.exe'後綴，按回車確定。
echo 等待注入窗口界面彈出後啓動目標程序即可。
echo 輸入'\exit'即可返回開發界面。
echo\
set /p "content=在此輸入："
if "%content%" == "\exit" (
    goto develop
) else (
    echo 你所選擇的注入目標為:%content%.exe
    echo 注入器現已啟動。確保ReShade.ini複製到正確的遊戲進程根目錄之後，你現在可以使用啟動器啟動遊戲了。注入器會一併注入。
    echo 如果你選擇了錯誤的注入目標，只需關閉此視窗後重新運行啟動器重新選擇即可。
    echo\
    start "" /wait /b inject.exe %content%.exe
    exit
)

:about_HoYoShade
title HoYoShade
cls
echo HoYoShade
echo HoYo it,Great it.
echo 使ReShade支持米哈遊旗下所有可在PC端運行的遊戲。
echo 然後，彼此成就，彼此閃耀。
echo\
echo DuolaDStudio X 阿向菌AXBro x Ex_M
echo 聯合鉅獻
echo\
echo 模組版本：V2.4.0 Stable
echo\
echo HoYoShade基於ReShade官方組件和OpenHoYoShade框架二次開發，除效果庫/預設之外的所有文件均遵守BSL-3開源協定在GitHub上開源。
echo 你可以在Reshade.me網站中查看ReShade官方資訊。
echo Modify By DuolaDStudio Hong Kong Ltd,All rights reserved.
echo\
echo 請注意：HoYoShade爲免費開源Mod，ReShade爲免費開源插件，OpenHoYoShade爲免費開源框架。
echo 所有原始碼都可以在GitHub上獲取，如果你是付費購買了未經修改/二次開發的(Open)HoYoShade
echo 請立即退款！商家行爲和所有開發者無關！
echo\
echo 詳細開發名單：
echo -DuolaDStudio Hong Kong Ltd.
echo   ——哆啦D夢DuolaD[RE適配/大版本更新開發/啓動器/預設]
echo   ——琳妮特LynetteNotFound[HoYoShade小版本更新開發/維護]
echo -Ex_M[技術支援/指導/GUI製作]
echo -阿向菌AXBro[宣傳/面向技術支持]
echo\
echo 鳴謝：
echo -CYTeam[HoYoShade合作伙伴/微軟企業儲存計劃提供/動態轉靜態連結解決方案]
echo -Cloudflare, Inc.[網域託管與管理]
echo\
echo 感謝有你！HoYoShade明天會更好！
pause
goto other

:ini_Reset
title HoYoShade Starter
cls
echo 歡迎使用HoYoShade啓動器！
echo\
echo 模組版本：V2.4.0 Stable
echo 開發者：DuolaDStudio X 阿向菌AXBro X Ex_M
echo\
echo 請注意：你只需要在模組目錄移動後才需要重置ReShade.ini
echo 除此之外，一般情況下你都不需要進行重置操作。
echo\
echo 重置完畢後，你需要重新複製ReShade.ini至遊戲進程根目錄
echo 是否繼續重置操作？
echo\
echo [1]是
echo [2]否(返回啓動器主菜單)
echo\
set /p "content=在此輸入選項前面的數字："

if "%content%" == "1" (
    start "" /wait ".\InjectResource\INIBuild.exe"
    start "" "convert_encoding.bat"
    :File_Reset
    cls
    echo 歡迎使用HoYoShade啓動器！
    echo\
    echo 模組版本：V2.4.0 Stable
    echo 開發者：DuolaDStudio X 阿向菌AXBro X Ex_M
    echo\
    echo 重置成功！重置後的ReShade.ini現已替換模組根目錄中的舊版ReShade.ini。
    echo 你需要將重置後的ReShade.ini替換遊戲進程根目錄原有的ReShade.ini，然後才能使用本模組。
    echo\
    echo 如何找到遊戲進程根目錄？  
    echo 對於HoYoPlay（米哈遊啟動器）:點擊開始啟動按鈕旁的更多圖標-遊戲設定即可查看遊戲進程根目錄。  
    echo 點選'開啟所在目錄'即可使用資源管理器開啟遊戲進程根目錄。  
    echo\
    echo 對於StarWard:點擊開始啟動按鈕旁的齒輪圖標即可查看遊戲進程根目錄。  
    echo 點選遊戲進程根目錄即可使用資源管理器開啟遊戲進程根目錄。  
    echo\
    echo 仍然不懂如何操作？你可以在模組根目錄/Tutorial資料夾中查看用戶協議和圖文安裝說明。
    echo\
    pause
    goto menu
) else if "%content%" == "2" (
    goto menu
) else (
    echo\
    echo 輸入錯誤。
    timeout /t 2
    goto ini_Reset
)

:beta_client_inject_choice_menu
title HoYoShade啓動器
cls
echo 歡迎使用HoYoShade啓動器！
echo\
echo 模組版本：V2.4.0 Stable
echo 開發者：DuolaDStudio X 阿向菌AXBro X Ex_M
echo\
echo 請注意，你需要將Reshade.ini複製到遊戲進程根目錄，然後才能使用本模組。
echo\
echo 本模組僅用於遊戲畫面調色使用，請遵守本Mod的用戶協議和遊戲及其開發/發行商相關條例。
echo 你可以在模組根目錄/Tutorial文件夾中查看用戶協議和圖文安裝說明。
echo 使用模組拍攝素材發佈視頻時，請備註:"該視頻由GitHub@DuolaD/HoYoShade提供渲染支持"。
echo 如因特殊原因無法備註，請通過"其它選項"中的聯繫方式聯繫開發者進行說明。
echo\
echo 以下客戶端注入選項均只能用於注入至測試服客戶端。
echo\
echo 如果你想使用的測試服客戶端不在此列表，或者注入器未對遊戲啓動做出響應，則說明:
echo 1:你想使用的測試服客戶端注入選項與公開客戶端注入選項通用，請先嚐試使用公開客戶端注入列表嘗試注入。
echo 2:HoYoShade暫未適配你目前正在使用的測試服客戶端。
echo 如需適配，請在我們的訪問我們的GitHub倉庫（https://github.com/DuolaD/HoYoShade）提交issues。
echo\
echo [1]重置模組根目錄中的ReShade.ini
echo [2]注入至原神（部分公測前海外內測客戶端）
echo [3]注入至絕區零（通用公測前內測客戶端）
echo [4]注入至絕區零（通用公測後內測客戶端）
echo [5]切換至公開客戶端注入列表
echo [6]其它選項
echo [7]退出程序

echo\
set /p "content=在此輸入選項前面的數字："

echo\

if "%content%" == "1" (
    goto ini_Reset
) else if "%content%" == "2" (
    :GICBT_CheckProcess
    tasklist /FI "IMAGENAME eq Genshin.exe" | find /i "Genshin.exe" >nul
    if not errorlevel 1 (
        taskkill /IM Genshin.exe /F >nul 2>&1
        goto GICBT_CheckProcess
    )
    echo 你所選擇的注入目標為:原神（部分公測前海外內測客戶端）
    echo 注入器現已啟動。確保ReShade.ini複製到正確的遊戲進程根目錄之後，你現在可以使用啟動器啟動遊戲了。注入器會一併注入。
    echo 如果你選擇了錯誤的注入目標，只需關閉此視窗後重新運行啟動器重新選擇即可。
    echo\
    start "" /wait /b inject.exe Genshin.exe
    exit
) else if "%content%" == "3" (
    echo 你所選擇的注入目標為:绝区零（通用公测前内测客户端）
    echo 注入器現已啟動。確保ReShade.ini複製到正確的遊戲進程根目錄之後，你現在可以使用啟動器啟動遊戲了。注入器會一併注入。
    echo 如果你選擇了錯誤的注入目標，只需關閉此視窗後重新運行啟動器重新選擇即可。
    echo\
    start "" /wait /b inject.exe ZZZ.exe
    exit
) else if "%content%" == "4" (
    echo 你所選擇的注入目標為:绝区零（通用公测后内测客户端）
    echo 注入器現已啟動。確保ReShade.ini複製到正確的遊戲進程根目錄之後，你現在可以使用啟動器啟動遊戲了。注入器會一併注入。
    echo 如果你選擇了錯誤的注入目標，只需關閉此視窗後重新運行啟動器重新選擇即可。
    echo\
    start "" /wait /b inject.exe ZenlessZoneZeroBeta.exe
    exit
) else if "%content%" == "5" (
    goto menu
) else if "%content%" == "6" (
    goto other
) else if "%content%" == "7" (
    exit
) else (
    echo\
    echo 輸入錯誤。
    timeout /t 2
    goto menu
    )
exit


:blender_hook_check

if not exist "%~dp0loader.exe.lnk" (
    echo\
    echo 自檢未通過，模組根目錄下並沒有找到名爲loader.exe的快捷方式。
    echo 請在模組根目錄下創建一個指向Blender/留影機插件注入程序（loader.exe）的快捷方式，然後將其命名爲loader.exe，然後再試一次。
    pause
    goto menu
)

curl --version >nul 2>&1
if errorlevel 1 (
    set missing_curl="1"
    goto blender_hook_menu
)

set "apiUrl=fromcnornot.165683.xyz"
for /f "tokens=* delims=" %%i in ('curl -s -o nul -w "%%{http_code}" %apiUrl%') do (
    set "statusCode=%%i"
)

if "%statusCode%"=="403" (
    :blender_hook_not_in_cn
    cls
    title HoYoShade啓動器
    cls
    echo 歡迎使用HoYoShade啓動器！
    echo\
    echo 模組版本：V2.4.0 Stable
    echo 開發者：DuolaDStudio X 阿向菌AXBro X Ex_M
    echo\
    echo 我們檢測到當前你可能不在中國大陸/港澳臺地區，
    echo 這可能會導致本Mod的聯動注入功能和Blender/留影機插件無法在你所在的國家及地區獲得完整技術支持,或不予對你提供任何技術支持。
    echo\
    echo 是否確認嘗試繼續操作？
    echo\
    echo [1]是
    echo [2]否（返回啓動器主菜單）
    echo\
    set /p "content=在此輸入選項前面的數字："
    if "%content%" == "1" (
        goto blender_hook_menu
    ) else if "%content%" == "2" (
        goto menu
    ) else (
        echo\
        echo 輸入錯誤。
        timeout /t 2
        goto blender_hook_not_in_cn
    )
)

:blender_hook_menu
cls
title HoYoShade啓動器
cls
echo 歡迎使用HoYoShade啓動器！
echo\
echo 模組版本：V2.4.0 Stable
echo 開發者：DuolaDStudio X 阿向菌AXBro X Ex_M
echo\
if "%missing_curl%"=="1" (
    echo 我們檢測到當前操作系統中並不包含curl組件，這會導致地區檢測功能無法工作。
    echo\
    echo 你仍然可以繼續使用此Mod的聯動注入功能。
    echo 但如果你並不處於中國大陸/港澳臺地區，可能會導致本Mod的聯動注入功能和Blender/留影機插件無法在你所在的國家及地區獲得完整技術支持,或不予對你提供任何技術支持。
    echo\
)
echo 注意：如果你使用聯動注入功能，需要選擇你在Blender/留影機插件中綁定的對應服務器的客戶端，否則ReShade無法正常注入。
echo 如果這是你第一次啓動Blender/留影機插件，請確保在此處選擇的目標客戶端和你接下來在Blender/留影機插件中綁定的目標客戶端一致，否則ReShade無法正常注入。
echo\
echo [1]重置模組根目錄中的ReShade.ini
echo [2]聯動Blender/留影機插件注入至原神（中國大陸/嗶哩嗶哩客戶端）
echo [3]聯動Blender/留影機插件注入至原神（國際服客戶端/Epic客戶端）
echo [4]僅啓動Blender/留影機插件
echo [5]同步當前系統時間以修復系統時間不同步的提示
echo [6]返回主界面
echo [7]退出程序
echo\
set /p "choice=在此輸入選項前面的數字："
echo\
if "%choice%"=="1" (
    goto ini_Reset
) else if "%choice%"=="2" (
    :YSBL_CheckProcess
    tasklist /FI "IMAGENAME eq YuanShen.exe" | find /i "YuanShen.exe" >nul
    if not errorlevel 1 (
        taskkill /IM YuanShen.exe /F >nul 2>&1
        goto YSBL_CheckProcess
    )
    echo 你選擇的注入目標爲:原神（中國大陸/嗶哩嗶哩客戶端）
    echo\
    echo ReShade和Blender/留影機插件注入器現已啓動。請不要關閉本窗口。
    echo Blender/留影機插件注入器啓動遊戲後，ReShade將會自動注入並關閉該窗口。
    echo 如果ReShade.ini複製到了正確的遊戲進程根目錄，那麼ReShade將會正確設置並啓動。
    echo\
    echo 如果你選擇了錯誤的注入目標，只需關閉此窗口和Blender/留影機插件注入器窗口後重新運行啓動器重新選擇即可。
    echo\
    start "" "%~dp0loader.exe.lnk"
    start "" /wait /b inject.exe YuanShen.exe
    exit
) else if "%choice%"=="3" (
    :GIBL_CheckProcess
    tasklist /FI "IMAGENAME eq GenshinImpact.exe" | find /i "GenshinImpact.exe" >nul
    if not errorlevel 1 (
        taskkill /IM GenshinImpact.exe /F >nul 2>&1
        goto GIBL_CheckProcess
    )
    echo 你選擇的注入目標爲:原神（國際服客戶端/Epic 客戶端）
    echo\
    echo ReShade和Blender/留影機插件注入器現已啓動。請不要關閉本窗口。
    echo Blender/留影機插件注入器啓動遊戲後，ReShade將會自動注入並關閉該窗口。
    echo 如果ReShade.ini複製到了正確的遊戲進程根目錄，那麼ReShade將會正確設置並啓動。
    echo\
    echo 如果你選擇了錯誤的注入目標，只需關閉此窗口和Blender/留影機插件注入器窗口後重新運行啓動器重新選擇即可。
    echo\
    start "" "%~dp0loader.exe.lnk"
    start "" /wait /b inject.exe GenshinImpact.exe
    exit
) else if "%choice%"=="4" (
    start "" "%~dp0loader.exe.lnk"
    exit
) else if "%choice%"=="5" (
    cls
    echo 同步系統時間的耗時取決於你當前的網絡情況。
    echo 如果當前網絡較差，耗時可能會比預期較長。請耐心等待。
    echo\
    echo 正在檢查並啓動 Windows Time 服務...
    net start w32time >nul 2>&1
    echo\
    for /f "tokens=* delims=" %%i in ('curl -s -o nul -w "%%{http_code}" %apiUrl%') do (
        set "statusCode=%%i"
    )
    if "%statusCode%"=="201" (
        w32tm /config /manualpeerlist:"ntp.ntsc.ac.cn" /syncfromflags:manual /reliable:YES /update >nul 2>&1
        net stop w32time >nul 2>&1
        net start w32time >nul 2>&1
        echo 檢測到你當前位於中國大陸，可能難以訪問微軟官方時間源同步服務器。
        echo 當前你的操作系統同步時間源已更改爲中國大陸科學院國家授時中心官方時間源同步服務器，以方便鏈接服務器同步時間。
        echo\
    )
    echo 正在嘗試同步時間...
    echo\
    w32tm /resync >nul 2>&1
    if %errorlevel% == 0 (
        echo 時間同步成功！可訪問 https://time.is 以檢測時間是否已同步，然後重新嘗試運行Blender/留影機插件。
    ) else (
        echo 時間同步失敗，可能是因爲沒有正確配置NTP時間服務器或其他錯誤。
        echo 請確保NTP時間服務器設置正確，並且網絡連接正常。
        echo 你可以嘗試稍後再試，或訪問系統設置-時間和語言-日期和時間進行手動設置。
    )
    echo\
    echo ========================
    echo\
    echo 注意：如果日後在使用過程中，Blender/留影機插件仍然經常性報錯系統時間不同步的提示/你需要經常性使用本功能來修復報錯/系統時間和現實時間經常性不符。
    echo 你可以在下次出現提示前先前往 https://time.is 以檢測是否爲誤報，然後再使用本功能進行修復。
    echo\
    echo 如果這並不是誤報，那麼說明當前設備的時鐘電路極有可能未能在斷電/關機/休眠/睡眠的情況下正常工作。
    echo 你可以優先檢查設備主板BIOS的電池電量（通常爲CR2032，電壓低於2V說明電池電量耗盡）。
    echo 如果電壓過低，請嘗試更換全新的電池，並在BIOS中設置正確的時間，然後使用本功能同步系統時間。
    echo\
    echo 如果更換電池後故障依舊/當前設備因相關條款無法自行更換，請聯繫你的設備製造商/第三方維修機構尋求幫助。
    echo\
    echo ========================
    echo\
    pause
    goto blender_hook_menu
) else if "%choice%"=="6" (
    goto menu
) else if "%choice%"=="7" (
    exit
) else (
    echo 輸入錯誤。
    timeout /t 2
    goto blender_hook_menu
)