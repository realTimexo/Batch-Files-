import sys
import os
import shutil
import subprocess
from pathlib import Path

def create_sfx_exe(hta_path):
    hta_path = Path(hta_path)
    if not hta_path.exists() or hta_path.suffix.lower() != ".hta":
        print("Bitte eine gültige .hta-Datei übergeben.")
        return

    output_exe = hta_path.with_suffix(".exe")
    temp_dir = Path("temp_sfx")
    temp_dir.mkdir(exist_ok=True)

    # 1. HTA kopieren
    hta_copy = temp_dir / hta_path.name
    shutil.copy2(hta_path, hta_copy)

    # 2. SFX-Konfig erstellen
    sfx_config = temp_dir / "config.txt"
    sfx_config.write_text(f"""
;The comment below contains SFX script commands
Setup=mshta.exe {hta_path.name}
TempMode
Silent=1
Overwrite=1
""")

    # 3. SFX erstellen
    sfx_module = Path(os.environ["SystemRoot"]) / "System32" / "iexpress.exe"
    if not sfx_module.exists():
        print("iexpress.exe nicht gefunden!")
        return

    # IEXPRESS-Skriptdatei generieren
    sed_file = temp_dir / "pack.sed"
    sed_file.write_text(f'''
[Version]
Class=IEXPRESS
SEDVersion=3
[Options]
PackagePurpose=InstallApp
ShowInstallProgramWindow=0
HideExtractAnimation=1
UseLongFileName=1
InsideCompressed=0
CAB_FixedSize=0
CAB_ResvCodeSigning=0
RebootMode=N
InstallPrompt=
DisplayLicense=
FinishMessage=
TargetName={output_exe}
FriendlyName=HTA to EXE
AppLaunched=mshta.exe {hta_path.name}
PostInstallCmd=
AdminQuietInstCmd=
UserQuietInstCmd=
SourceFiles=SourceFiles
[SourceFiles]
SourceFiles0={temp_dir}
[SourceFiles0]
%file%={hta_path.name}
'''.replace('%file%', hta_path.name))

    # 4. IExpress starten
    subprocess.run(["iexpress", "/n", str(sed_file)], check=True)

    print(f"Fertig: {output_exe}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Bitte eine .hta-Datei auf das Skript ziehen.")
    else:
        create_sfx_exe(sys.argv[1])
