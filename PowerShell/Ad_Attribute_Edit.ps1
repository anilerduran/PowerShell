$ErrorActionPreference = "SilentlyContinue"
Import-Module activedirectory
$UserName = read-host "Kullanıcı İsmini Girin"
$UserNamecontrol = Get-ADUser -Filter {Name -like $UserName}
If ($UserNamecontrol -eq $Null) {"Bu kullanıcı adı bulunamadı. Scripti baştan başlatın"}
Else {
$SicilNo = Read-Host "Sicil No Girin"
$DogumTarihi = Read-Host "Dogum Tarihi Girin"
$Pozisyon = Read-Host "Yönetici yada Çalışan Girin"
$IseGirisTarihi = Read-Host "Ise Giris Tarihi Girin"
$GrubaGirisTarihi = Read-Host "Gruba Giris Tarihi Girin"
$MailAddress = Read-Host "Mail Adresini Girin"
$Telefon = Read-Host "Telefon No Girin"
$Title = Read-Host "Title Girin"
$Manager = Read-Host "Manager Girin"
$managercontrol = Get-ADUser -Filter {Name -like $Manager}
If ($managercontrol -eq $Null) {"Manager için $Manager kullanıcısı bulunamadı. Scripti baştan başlatın"}
Else {
$managerSAM = $managercontrol.SamAccountName
set-aduser $UserName -Add @{SicilNo="$SicilNo"}
set-aduser $UserName -Add @{dogumTarihi="$DogumTarihi"}
set-aduser $UserName -Add @{pozisyon="$Pozisyon"}
set-aduser $UserName -Add @{iseGirisTarihi="$IseGirisTarihi"}
set-aduser $UserName -Add @{grubaGirisTarihi="$GrubaGirisTarihi"}
$MailControl0 = Get-ADUser -Filter {Name -like $UserName} -Properties mail
$MailControl = $MailControl0.mail
If ($MailControl -ne $Null) {"Bir Mail adresi zaten var. Yazılan eklenmeyecek"}
Else {
set-aduser $UserName -emailaddress $MailAddress
}
$TelControl0 = Get-ADUser -Filter {Name -like $UserName} -Properties officephone
$TelControl = $TelControl0.officephone
If ($TelControl -ne $Null) {"Bir Tel No zaten var. Yazılan eklenmeyecek"}
Else {
set-aduser $UserName -officephone $Telefon
}
$TitleControl0 = Get-ADUser -Filter {Name -like $UserName} -Properties title
$TitleControl = $TitleControl0.title
If ($TitleControl -ne $Null) {"Bir Title zaten var. Yazılan eklenmeyecek"}
Else {
set-aduser $UserName -Title $Title
}
$ManagerControl0 = Get-ADUser -Filter {Name -like $UserName} -Properties Manager
$ManagerControl = $ManagerControl0.Manager
If ($ManagerControl -ne $Null) {"Bir Manager zaten var. Yazılan eklenmeyecek"}
Else {
set-aduser $UserName -Manager $managerSAM
}
}
}