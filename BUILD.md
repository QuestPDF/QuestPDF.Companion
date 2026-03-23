# Companion App Build Instructions

## Regenerate JSON serialization code

```sh
dart run build_runner build --delete-conflicting-outputs
```


## Sign msix file on Windows:

```ps
cd "C:\Program Files (x86)\Windows Kits\10\bin\10.0.22621.0/x64"
certutil -repairstore -user My A62CA27B2664393FE05F13238467FEB6822617FD
./signtool.exe sign /fd SHA256 /sha1 a62ca27b2664393fe05f13238467feb6822617fd /tr http://time.certum.pl /td SHA256 /v /debug "C:\Users\marci\Downloads\questpdf_companion-2026.3.0-windows.msix"
```

## MacOS

### Build app

1. Open XCode and open the project
2. Select "Product" -> "Archive"
3. Select latest archive and click "Distribute App"
4. Select "Direct Distribution" and click "Distribute"
5. Wait for notary service to finish
6. Hover mouse over the archive, click "Export App", and select path

### Create installer:

Do only once:

```sh
npm install --global create-dmg
```

For each new build:

```sh
create-dmg "QuestPDF Companion 2026.2.1.app" --overwrite 
```


### Notarize installer:

Do only once:

```sh
xcrun notarytool store-credentials "QuestPDF Companion Profile" \
  --apple-id "marcin@ziabek.com" \
  --team-id "L57GK9Y59F" \
  --password "<NOTARY_TOOL_PASSWORD>"
```

For each new build:

```sh
xcrun notarytool submit "QuestPDF Companion 2026.2.1.dmg" --keychain-profile "QuestPDF Companion Profile" --wait
xcrun stapler staple "QuestPDF Companion 2026.2.1.dmg"
```