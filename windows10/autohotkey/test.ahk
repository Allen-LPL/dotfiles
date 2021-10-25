<<<<<<< HEAD
pwb := ComObjCreate("InternetExplorer.Application")
pwb.Visible := 1
pwb.Navigate("https://passport.baidu.com/?login&tpl=mn")
while pwb.ReadyState <> 4
{}
pwb.document.getElementById("username").value := "ahk_test"
pwb.document.getElementById("normModPsp").value := "qwe123"
=======
pwb := ComObjCreate("InternetExplorer.Application")
pwb.Visible := 1
pwb.Navigate("https://passport.baidu.com/?login&tpl=mn")
while pwb.ReadyState <> 4
{}
pwb.document.getElementById("username").value := "ahk_test"
pwb.document.getElementById("normModPsp").value := "qwe123"
>>>>>>> 5e01a4ce960268d5ea2cc71b2c70622b54235265
pwb.document.all(137).click()