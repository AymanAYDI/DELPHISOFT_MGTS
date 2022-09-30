codeunit 50007 "Document Sheet"
{

    trigger OnRun()
    begin
    end;

    var
        DialogFilterIndex: Integer;
        DialogFileName: Text;
        DialogFilter: Text;

    [Scope('Internal')]
    procedure GetOpenFileName(var ClientFileName: Text; UploadToServer: Boolean): Boolean
    var
        DummyFileName: Text;
        ServerFilename: Text;
    begin
        EXIT(ShowOpenFileDialog(ClientFileName, DummyFileName, FALSE));
    end;

    [Scope('Internal')]
    procedure OpenFile(var ClientFileName: Text; var ServerFileName: Text): Boolean
    begin
        EXIT(ShowOpenFileDialog(ClientFileName, ServerFileName, TRUE));
    end;

    local procedure ShowOpenFileDialog(var ClientFileName: Text; var ServerFileName: Text; UploadToServer: Boolean): Boolean
    var
        DialogResult: DotNet DialogResult;
        [RunOnClient]
        OpenFileDialog: DotNet OpenFileDialog;
    begin
        OpenFileDialog := OpenFileDialog.OpenFileDialog;
        OpenFileDialog.Filter := GetDialogFilter;

        IF ClientFileName <> '' THEN BEGIN
            OpenFileDialog.InitialDirectory := GetDirectoryName(ClientFileName);
            OpenFileDialog.FileName := GetFileName(ClientFileName);
        END;

        OpenFileDialog.FilterIndex := DialogFilterIndex;

        IF NOT (FORMAT(OpenFileDialog.ShowDialog) = FORMAT(DialogResult.OK)) THEN
            EXIT;

        IF OpenFileDialog.FileName = '' THEN
            EXIT;

        DialogFileName := OpenFileDialog.FileName;
        ClientFileName := OpenFileDialog.FileName;
        DialogFilterIndex := OpenFileDialog.FilterIndex;

        IF UploadToServer THEN
            ServerFileName := UploadToServerRTC(ClientFileName, '');


        EXIT(TRUE);
    end;

    [Scope('Internal')]
    procedure SelectDirectory(var Directory: Text): Boolean
    var
        ActiveFolder: Text;
        DialogResult: DotNet DialogResult;
        [RunOnClient]
        FolderBrowserDialog: DotNet FolderBrowserDialog;
    begin
        FolderBrowserDialog := FolderBrowserDialog.FolderBrowserDialog;

        IF Directory <> '' THEN
            ActiveFolder := Directory;

        FolderBrowserDialog.SelectedPath := ActiveFolder;

        IF NOT (FORMAT(FolderBrowserDialog.ShowDialog) = FORMAT(DialogResult.OK)) THEN
            EXIT;

        Directory := FolderBrowserDialog.SelectedPath;
        AddBackSlash(Directory);

        EXIT(TRUE);
    end;

    [Scope('Internal')]
    procedure OpenDirectory(Directory: Text)
    var
        WindowsShell: Automation;
        ctFolderNotFound: Label 'The folder does not exist.';
    begin
        IF NOT ServerDirectoryExists(Directory) THEN
            ERROR(ctFolderNotFound);

        IF ISCLEAR(WindowsShell) THEN
            CREATE(WindowsShell, FALSE, TRUE);

        WindowsShell.Open(Directory);

        CLEAR(WindowsShell);
    end;

    local procedure GetDialogFilter(): Text
    var
        ctAllFiles: Label 'All Files (*.*)|*.*';
    begin
        IF DialogFilter = '' THEN
            EXIT(ctAllFiles)
        ELSE
            EXIT(DialogFilter + '|' + ctAllFiles);
    end;

    [Scope('Internal')]
    procedure GetFileName(FileName: Text): Text
    var
        i: Integer;
    begin
        FOR i := STRLEN(FileName) DOWNTO 1 DO
            IF FileName[i] = '\' THEN
                EXIT(COPYSTR(FileName, i + 1));

        EXIT(FileName);
    end;

    [Scope('Internal')]
    procedure GetDirectoryName(FileName: Text): Text
    var
        i: Integer;
    begin
        FOR i := STRLEN(FileName) DOWNTO 1 DO
            IF FileName[i] = '\' THEN
                EXIT(COPYSTR(FileName, 1, i));
    end;

    [Scope('Internal')]
    procedure AddBackSlash(var Directory: Text)
    begin
        IF Directory <> '' THEN
            IF Directory[STRLEN(Directory)] <> '\' THEN
                Directory += '\';
    end;

    [Scope('Internal')]
    procedure ServerDirectoryExists(DirectoryName: Text): Boolean
    var
        IODirectory: DotNet Directory;
    begin
        EXIT(IODirectory.Exists(DirectoryName));
    end;

    [Scope('Internal')]
    procedure UploadToServerRTC(ClientFileName: Text; ServerFileName: Text): Text
    var
        TmpServerFile: File;
        TmpClientFileName: Text;
        TmpServerFileName: Text;
        ctAllFiles: Label 'All Files (*.*)|*.*';
        [RunOnClient]
        IOFile: DotNet File;
    begin

        TmpServerFile.CREATETEMPFILE;
        TmpServerFileName := TmpServerFile.NAME;
        TmpServerFile.CLOSE;

        TmpServerFile.CREATE(TmpServerFileName);
        TmpServerFile.CLOSE;

        DOWNLOAD(TmpServerFileName, '', '<TEMP>', ctAllFiles, TmpClientFileName);
        ERASE(TmpServerFileName);

        IOFile.Copy(ClientFileName, TmpClientFileName, TRUE);

        UPLOAD('', '<TEMP>', ctAllFiles, GetFileName(TmpClientFileName), TmpServerFileName);

        IF ServerFileName = '' THEN BEGIN
            ServerFileName := TmpServerFileName;
            CopyExtension(ClientFileName, ServerFileName);
        END;

        IF ServerFileName <> TmpServerFileName THEN BEGIN
            IF EXISTS(ServerFileName) THEN
                ERASE(ServerFileName);

            RENAME(TmpServerFileName, ServerFileName);
        END;


        EXIT(ServerFileName);
    end;

    local procedure CopyExtension(FromFileName: Text; var ToFileName: Text)
    var
        Extension: Text;
    begin
        Extension := GetExtension(FromFileName);
        SetExtension(ToFileName, Extension);
    end;

    [Scope('Internal')]
    procedure GetExtension(FileName: Text): Text
    var
        i: Integer;
    begin
        FOR i := STRLEN(FileName) DOWNTO 1 DO
            CASE FileName[i] OF
                '\':
                    EXIT;
                '.':
                    EXIT(COPYSTR(FileName, i + 1));
            END;
    end;

    local procedure SetExtension(var FileName: Text; Extension: Text)
    var
        DotPos: Integer;
        i: Integer;
    begin
        FOR i := 1 TO STRLEN(FileName) DO
            CASE FileName[i] OF
                '\':
                    DotPos := 0;
                '.':
                    DotPos := i;
            END;

        IF DotPos = 0 THEN
            FileName := FileName + '.' + Extension
        ELSE
            FileName := DELSTR(FileName, DotPos) + '.' + Extension;
    end;

    [Scope('Internal')]
    procedure TempDirectory() ExitValue: Text
    begin
        ExitValue := TEMPORARYPATH;

        AddBackSlash(ExitValue);
    end;
}

