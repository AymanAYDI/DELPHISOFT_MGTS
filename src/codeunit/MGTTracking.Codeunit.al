codeunit 50003 "DEL MGT Tracking"
{


    trigger OnRun()
    begin


        importXMLFiles1();
        importXMLFiles2();
        move1();
        move2();
    end;

    var
        MyFile: Record File;
        NgtsSetup: Record "DEL General Setup";
        TrackingGeneral: Record "DEL Tracking non traité";
        TempBlob: Codeunit "Temp Blob";
        FileManagement: Codeunit "File Management";

        MyStream: InStream;
        TestFile: File;
        //TODO fso: DotNet File;
        outStreamtest: OutStream;
        charXml: Text;
        Pos: Integer;


        OutStr: OutStream;


    procedure importXMLFiles1()
    begin
        IF NgtsSetup.GET() THEN;
        charXml := '.xml';
        MyFile.SETRANGE(Path, NgtsSetup."Folder Expeditors");
        MyFile.SETRANGE("Is a file", TRUE);
        IF MyFile.FINDFIRST() THEN
            REPEAT
                Pos := STRPOS(MyFile.Name, charXml);
                IF Pos <> 0 THEN BEGIN
                    // TestFile.OPEN(NgtsSetup."Folder Expeditors" + MyFile.Name);
                    // TestFile.CREATEINSTREAM(MyStream);
                    // XMLPORT.IMPORT(XMLPORT::"Import tracking", MyStream);
                    // TestFile.CLOSE; // TODO: ancient code
                    //UploadIntoStream('', NgtsSetup."Folder Expeditors", '', MyFile.Name, MyStream); // TODO:  check new code
                    TempBlob.CreateInStream(MyStream, TEXTENCODING::UTF8);
                    XMLPORT.Import(XMLPORT::"DEL Import tracking", MyStream);
                    FileManagement.BLOBImport(TempBlob, 'exemple.xml');
                    TrackingGeneral.SETRANGE(Nom_Fichier, '');
                    IF TrackingGeneral.FINDFIRST() THEN
                        REPEAT
                            TrackingGeneral.Nom_Fichier := MyFile.Name;
                            TrackingGeneral.MODIFY();
                        UNTIL TrackingGeneral.NEXT() = 0;
                END;
            UNTIL MyFile.NEXT() = 0;
        MESSAGE('Import Xml completed 1!');
    end;


    procedure importXMLFiles2()
    var
    begin
        IF NgtsSetup.GET() THEN;

        MyFile.SETRANGE(Path, NgtsSetup."Folder Maersk");
        MyFile.SETRANGE("Is a file", TRUE);
        IF MyFile.FINDFIRST() THEN
            REPEAT

                // TestFile.OPEN(NgtsSetup."Folder Maersk" + MyFile.Name);
                // TestFile.CREATEINSTREAM(MyStream);
                // XMLPORT.IMPORT(XMLPORT::"Import tracking", MyStream);
                // TestFile.CLOSE; // TODO: ancient code

                TempBlob.CreateInStream(MyStream, TEXTENCODING::UTF8);
                XMLPORT.Import(XMLPORT::"DEL Import tracking", MyStream);
                FileManagement.BLOBImport(TempBlob, 'exemple.xml');

                TrackingGeneral.SETRANGE(Nom_Fichier, '');
                IF TrackingGeneral.FINDFIRST() THEN
                    REPEAT
                        TrackingGeneral.Nom_Fichier := MyFile.Name;
                        TrackingGeneral.MODIFY();
                    UNTIL TrackingGeneral.NEXT() = 0;
            UNTIL MyFile.NEXT() = 0;

        MESSAGE('Import Xml completed 2!');
    end;


    procedure move1()
    begin
        IF NgtsSetup.GET() THEN;

        MyFile.SETRANGE(Path, NgtsSetup."Folder Expeditors");
        MyFile.SETRANGE("Is a file", TRUE);
        IF MyFile.FINDFIRST() THEN
            REPEAT
            // fso.Copy(NgtsSetup."Folder Expeditors" + MyFile.Name, NgtsSetup."Folder Expeditors Archive" + MyFile.Name);
            // fso.Delete(NgtsSetup."Folder Expeditors" + MyFile.Name); // TODO: 


            UNTIL MyFile.NEXT() = 0;
    end;


    procedure move2()
    begin

        IF NgtsSetup.GET() THEN;

        MyFile.SETRANGE(Path, NgtsSetup."Folder Maersk");
        MyFile.SETRANGE("Is a file", TRUE);
        IF MyFile.FINDFIRST() THEN
            REPEAT
            // fso.Copy(NgtsSetup."Folder Maersk" + MyFile.Name, NgtsSetup."Folder Maersk Archive" + MyFile.Name);
            // fso.Delete(NgtsSetup."Folder Maersk" + MyFile.Name); // TODO: 
            UNTIL MyFile.NEXT() = 0;
    end;


    procedure export()
    var
        tempBlob: Codeunit "Temp Blob";
        FileManagement: Codeunit "File Management";
        tempfilename: text;
    begin

        // TestFile.CREATE('C:\Transitaire\trans 1\Entry\Export.xml');
        // TestFile.CREATEOUTSTREAM(outStreamtest);
        // XMLPORT.EXPORT(XMLPORT::"Import tracking", outStreamtest);
        // TestFile.CLOSE; // TODO: ancient code

        tempfilename := 'Export.xml';
        TempBlob.CreateOutStream(outStreamtest, TEXTENCODING::UTF8);
        XMLPORT.EXPORT(XMLPORT::"DEL Import tracking", outStreamtest);
        FileManagement.BLOBExport(TempBlob, tempfilename, TRUE);
        MESSAGE('Export Xml completed!');
    end;
}

