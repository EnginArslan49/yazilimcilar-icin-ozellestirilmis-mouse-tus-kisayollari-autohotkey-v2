; makro_hy_x6.ahk -- AutoHotkey v2
#Requires AutoHotkey v2.0
#SingleInstance Force

; ---------- Ayarlar ----------
enabled := true
tooltipDuration := 1000      ; Kopyalandı bildirimi süresi (ms)

; ---------- Yardımcı fonksiyonlar ----------
ShowTempTip(text, ms := tooltipDuration) {
    ToolTip(text)
    Sleep(ms)
    ToolTip()
}

WarnIfAdminMismatch() {
    if WinActive("ahk_exe devenv.exe") && !A_IsAdmin {
        ShowTempTip("Uyarı: Visual Studio yönetici modunda. AHK'yi de yönetici olarak çalıştır.", 2500)
    }
}

; ---------- Başlangıç bildirimi ----------
ShowTempTip("Mouse Kısayolları devrede")

; ---------- Toggle (F8) ----------
F8:: {
    global enabled
    enabled := !enabled
    if enabled
        ShowTempTip("Mouse Kısayolları: devrede")
    else
        ShowTempTip("Mouse Kısayolları: devre dışı")
    return
}

; ---------- Hotkeyler ----------

; Visual Studio
#HotIf enabled && WinActive("ahk_exe devenv.exe")
XButton1:: {
    WarnIfAdminMismatch()
    Send("{F5}")       ; Build + Run
}
XButton2:: {
    Send("^c")          ; Kopyala
    ShowTempTip("Metin kopyalandı")
}
q:: {
    Send("^v")          ; Q tuşuna basınca yapıştır
    ShowTempTip("Yapıştırıldı")
}
#HotIf

; VS Code
#HotIf enabled && WinActive("ahk_exe code.exe")
XButton2:: {
    Send("^c")          ; Kopyala
    ShowTempTip("Metin kopyalandı")
}
XButton1:: {
    Send("^v")          ; Yapıştır
    ShowTempTip("Metin yapıştırıldı")
}
#HotIf

; Tarayıcılar: Chrome, Edge, Firefox
#HotIf enabled && (WinActive("ahk_exe chrome.exe") || WinActive("ahk_exe msedge.exe") || WinActive("ahk_exe firefox.exe") || WinActive("ahk_exe brave.exe"))
XButton2:: {
    Send("^c")          ; Kopyala
    ShowTempTip("Metin kopyalandı")
}
XButton1:: {
    Send("^v")          ; Yapıştır
    ShowTempTip("Metin yapıştırıldı")
}
#HotIf

; Genel kullanım / masaüstü / diğer pencereler
#HotIf enabled
XButton2:: {
    Send("^c")          ; Kopyala
    ShowTempTip("Metin kopyalandı")
}
XButton1::Send("^v")    ; Yapıştır
#HotIf
