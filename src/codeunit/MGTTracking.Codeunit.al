codeunit 50003 "MGT Tracking"
{
    //  Nts/loco/grc   23.04.2010 create object
    //  JUH            14.09.16    Filter .xml


    trigger OnRun()
    begin


        //export();

        importXMLFiles1();
        importXMLFiles2();
        move1();
        move2();
    end;

    var
        MyFile: Record "2000000022";
        MyStream: InStream;
        NgtsSetup: Record "50000";
        TestFile: File;
        TrackingGeneral: Record "50012";
        fso: DotNet File;
        outStreamtest: OutStream;
        charXml: Text;
        Pos: Integer;

    [Scope('Internal')]
    procedure importXMLFiles1()
    begin
        IF NgtsSetup.GET() THEN;
        // JUH 14.09.16 START
        charXml := '.xml';
        MyFile.SETRANGE(Path, NgtsSetup."Folder Expeditors");
        MyFile.SETRANGE("Is a file", TRUE);
        IF MyFile.FINDFIRST THEN BEGIN
            REPEAT
                Pos := STRPOS(MyFile.Name, charXml);
                IF Pos <> 0 THEN BEGIN
                    TestFile.OPEN(NgtsSetup."Folder Expeditors" + MyFile.Name);
                    TestFile.CREATEINSTREAM(MyStream);
                    XMLPORT.IMPORT(XMLPORT::"Import tracking", MyStream);
                    TestFile.CLOSE;
                    TrackingGeneral.SETRANGE(Nom_Fichier, '');
                    IF TrackingGeneral.FINDFIRST THEN BEGIN
                        REPEAT
                            TrackingGeneral.Nom_Fichier := MyFile.Name;
                            TrackingGeneral.MODIFY();
                        UNTIL TrackingGeneral.NEXT = 0;
                    END;
                END;
            UNTIL MyFile.NEXT = 0;
        END;
        // JUH 14.09.16 END
        MESSAGE('Import Xml completed 1!');
    end;

    [Scope('Internal')]
    procedure importXMLFiles2()
    begin
        IF NgtsSetup.GET() THEN;

        MyFile.SETRANGE(Path, NgtsSetup."Folder Maersk");
        MyFile.SETRANGE("Is a file", TRUE);
        IF MyFile.FINDFIRST THEN BEGIN

            REPEAT

                TestFile.OPEN(NgtsSetup."Folder Maersk" + MyFile.Name);
                TestFile.CREATEINSTREAM(MyStream);
                XMLPORT.IMPORT(XMLPORT::"Import tracking", MyStream);
                TestFile.CLOSE;
                TrackingGeneral.SETRANGE(Nom_Fichier, '');
                IF TrackingGeneral.FINDFIRST THEN BEGIN
                    REPEAT
                        TrackingGeneral.Nom_Fichier := MyFile.Name;
                        TrackingGeneral.MODIFY();
                    UNTIL TrackingGeneral.NEXT = 0;
                END;
            UNTIL MyFile.NEXT = 0;
        END;

        MESSAGE('Import Xml completed 2!');
    end;

    [Scope('Internal')]
    procedure move1()
    begin
        IF NgtsSetup.GET() THEN;

        MyFile.SETRANGE(Path, NgtsSetup."Folder Expeditors");
        MyFile.SETRANGE("Is a file", TRUE);
        IF MyFile.FINDFIRST THEN BEGIN

            REPEAT
                fso.Copy(NgtsSetup."Folder Expeditors" + MyFile.Name, NgtsSetup."Folder Expeditors Archive" + MyFile.Name);
                fso.Delete(NgtsSetup."Folder Expeditors" + MyFile.Name);
            UNTIL MyFile.NEXT = 0;
        END;
    end;

    [Scope('Internal')]
    procedure move2()
    begin

        IF NgtsSetup.GET() THEN;

        MyFile.SETRANGE(Path, NgtsSetup."Folder Maersk");
        MyFile.SETRANGE("Is a file", TRUE);
        IF MyFile.FINDFIRST THEN BEGIN

            REPEAT
                fso.Copy(NgtsSetup."Folder Maersk" + MyFile.Name, NgtsSetup."Folder Maersk Archive" + MyFile.Name);
                fso.Delete(NgtsSetup."Folder Maersk" + MyFile.Name);
            UNTIL MyFile.NEXT = 0;
        END;
    end;

    [Scope('Internal')]
    procedure export()
    begin

        TestFile.CREATE('C:\Transitaire\trans 1\Entry\Export.xml');
        TestFile.CREATEOUTSTREAM(outStreamtest);
        XMLPORT.EXPORT(XMLPORT::"Import tracking", outStreamtest);
        TestFile.CLOSE;
        MESSAGE('Export Xml completed!');
    end;
}

