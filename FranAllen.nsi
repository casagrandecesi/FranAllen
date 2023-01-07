!define PRODUCT "Frances E. Allen"
!define VERSION "1.0"
!define COMPANY "IIS Casagrande-Cesi"

!define UNINST_KEY \
  "Software\Microsoft\Windows\CurrentVersion\Uninstall\FranAllen"
!define MULTIUSER_INSTALLMODE_COMMANDLINE
!include "MultiUser.nsh"

OutFile "FranAllen.exe"
InstallDir "C:\FranAllen"
;RequestExecutionLevel admin
RequestExecutionLevel user
CRCCheck on
; set the compression algorithm used, zlib | bzip2 | lzma
SetCompressor /SOLID lzma
;SetCompress off
; The name displayed by the installer
Name "${PRODUCT} ${VERSION}"
BrandingText "${COMPANY} ${PRODUCT} ${VERSION}"

!include MUI2.nsh

!define MUI_ICON "images\cc.ico"
;!define MUI_WELCOMEFINISHPAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Wizard\orange.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP "images\nsis_welcomefinish.bmp"
;!define MUI_WELCOMEFINISHPAGE_BITMAP_STRETCH AspectFitHeight
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "images\nsis_header.bmp"
;!define MUI_HEADERIMAGE_BITMAP_STRETCH AspectFitHeight
!define MUI_HEADERIMAGE_RIGHT

;Uninstaller
!define MUI_UNICON "images\cc.ico"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "images\nsis_welcomefinish.bmp"
;!define MUI_UNWELCOMEFINISHPAGE_BITMAP_STRETCH AspectFitHeight
!define MUI_UNCONFIRMPAGE_TEXT_TOP "Uninstall ${PRODUCT}"
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!define MUI_PAGE_HEADER_TEXT "License Agreement"
!define MUI_PAGE_HEADER_SUBTEXT "Please review the license terms before installing ${PRODUCT}."
!define MUI_WELCOMEPAGE_TITLE "Welcome to the ${PRODUCT} ${VERSION} Setup Wizard"
!define MUI_WELCOMEPAGE_TEXT "This wizard will guide you through the installation of ${PRODUCT} ${VERSION}.$\r$\n$\r$\nClick Next to continue."
;Extra space for the title area
;!insertmacro MUI_WELCOMEPAGE_TITLE_3LINES
!define MUI_LICENSEPAGE_TEXT_TOP "Press Page Down to see the rest of the agreement"
!define MUI_LICENSEPAGE_TEXT_BOTTOM "If you accept the terms of the agreement, click I Agree to continue. You must accept the agreement to install ${PRODUCT}"
!define MUI_LICENSEPAGE_BUTTON "I Agree"
;Display a checkbox the user has to check to agree with the license terms.
;!define MUI_LICENSEPAGE_CHECKBOX
;!define MUI_LICENSEPAGE_CHECKBOX_TEXT "I accept the terms and conditions."

!define MUI_INSTFILESPAGE_FINISHHEADER_TEXT "Installation finished."
!define MUI_INSTFILESPAGE_FINISHHEADER_SUBTEXT "TODO was installed correctly."
!define MUI_INSTFILESPAGE_ABORTHEADER_TEXT "Installation aborted."
!define MUI_INSTFILESPAGE_ABORTHEADER_SUBTEXT "Patience is a virtue you know. I guess you aren't terribly virtuous."
!define MUI_FINISHPAGE_TITLE "${PRODUCT} setup completed"
;!define MUI_FINISHPAGE_TITLE_3LINES
!define MUI_FINISHPAGE_TEXT "${PRODUCT} has been installed on your computer$\r$\n$\r$\nClick Finish to close Setup."
;Extra space for the text area (if using checkboxes).
;!define MUI_FINISHPAGE_TEXT_LARGE
!define MUI_FINISHPAGE_BUTTON "Finish"
;!define MUI_FINISHPAGE_SHOWREADME "README.txt"
;Don't make this label too long or it'll cut on top and bottom.
;!define MUI_FINISHPAGE_SHOWREADME_TEXT "This would open a README if there was one."
;!define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
;MUI_FINISHPAGE_SHOWREADME_FUNCTION Function
!define MUI_FINISHPAGE_LINK "Vist our website for the latest news"
!define MUI_FINISHPAGE_LINK_LOCATION "https://www.casagrandecesi.edu.it/"
;!define MUI_FINISHPAGE_LINK_COLOR RRGGBB
!define MUI_FINISHPAGE_NOREBOOTSUPPORT

;pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "LICENSE.txt"
;!insertmacro MUI_PAGE_COMPONENTS
!define MUI_PAGE_HEADER_TEXT "Choose Install Location"
!define MUI_PAGE_HEADER_SUBTEXT "Choose the folder in which to install ${PRODUCT}."
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

# default section start; every NSIS script has at least one section.
Section
    # define the output path for this file
    SetOutPath "$INSTDIR"

    #define what to install and place it in the output path
    File /r "BuildWin\*"

    # define uninstaller name
    WriteUninstaller "$INSTDIR\uninstaller.exe"
	
	; Create application shortcut (first in installation dir to have the correct "start in" target)
	CreateShortCut "$INSTDIR\Frances E. Allen.lnk" "$INSTDIR\FranAllen3D.exe"
	CreateShortCut "$INSTDIR\Disinstalla.lnk" "$INSTDIR\uninstaller.exe"

	; Start menu entries
	SetOutPath "$SMPROGRAMS\Frances E. Allen"
	CopyFiles "$INSTDIR\Frances E. Allen.lnk" "$SMPROGRAMS\Frances E. Allen\"
	CopyFiles "$INSTDIR\Disinstalla.lnk" "$SMPROGRAMS\Frances E. Allen\"
	CopyFiles "$INSTDIR\Frances E. Allen.lnk" "$DESKTOP\"
	Delete "$INSTDIR\Frances E. Allen.lnk"
	Delete "$INSTDIR\Disinstalla.lnk"

	; Add uninstaller to Add/Remove programs
	WriteRegStr SHCTX "${UNINST_KEY}" "DisplayName" "Frances E. Allen"
	WriteRegStr SHCTX "${UNINST_KEY}" "UninstallString" \
		"$\"$INSTDIR\uninstaller.exe$\" /$MultiUser.InstallMode"
	WriteRegStr SHCTX "${UNINST_KEY}" "QuietUninstallString" \
		"$\"$INSTDIR\uninstaller.exe$\" /$MultiUser.InstallMode /S"
SectionEnd

Section "Uninstall"
	RMDir /r /REBOOTOK "$INSTDIR"
	Delete "$DESKTOP\Frances E. Allen.lnk"
	Delete "$SMPROGRAMS\Frances E. Allen\Frances E. Allen.lnk"
	Delete "$SMPROGRAMS\Frances E. Allen\Disinstalla.lnk"
	RMDir "$SMPROGRAMS\Frances E. Allen"
	DeleteRegKey SHCTX "${UNINST_KEY}"
SectionEnd