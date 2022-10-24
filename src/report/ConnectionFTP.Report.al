//TODO //Dotnet 
report 50038 "DEL Connection FTP"
{
    //     ProcessingOnly = true;

    //     dataset
    //     {
    //     }

    //     requestpage
    //     {

    //         layout
    //         {
    //         }

    //         actions
    //         {
    //         }
    //     }

    //     labels
    //     {
    //     }

    //     trigger OnPreReport()
    //     var
    //         MP: Label 'Fpuk0''0''';
    //     begin
    //         //DownloadFiles('ftp://pucx.ftp.infomaniak.com/SIGMA/Purchase_invoice/','C:\Delphisoft\ExportImportGrafax\','pucx_nav','s1gm42018GExyzzy4611');//
    //         //ConnectionFTP.DownloadFiles('ftp://178.211.240.218:8022/sigma/','C:\Delphisoft\ImportQuadrigis\','sigma','63g4LUhgGJi45h');
    //     end;

    //     var
    //         FTPRequest: DotNet FtpWebRequest;
    //         FTPResponse: DotNet FtpWebResponse;
    //         Credentials: DotNet NetworkCredential;
    //         ResponseStream: DotNet Stream;
    //         StreamReader: DotNet StreamReader;
    //         FileStream: DotNet File;
    //         RealFileStream: DotNet FileStream;
    //         FilesList: DotNet List_Of_T;
    //         SimpleStream: DotNet Stream;
    //         StatusCode: DotNet FtpStatusCode;
    //         Files: Record "2000000022";
    //         NetworkCredential: DotNet NetworkCredential;
    //         FileName: Text;
    //         TempBLOB: Record "99008535" temporary;
    //         OutStreamVar: OutStream;


    //     procedure GetFilesList(FTPAddress: Text; Login: Text; Password: Text): Integer
    //     begin
    //         FTPRequest := FTPRequest.Create(FTPAddress);
    //         Credentials := NetworkCredential.NetworkCredential(Login, Password);
    //         FTPRequest.Credentials := Credentials;
    //         FTPRequest.KeepAlive := TRUE;
    //         FTPRequest.Method := 'NLST';
    //         FTPRequest.UsePassive := TRUE;
    //         FTPRequest.UseBinary := TRUE;

    //         FTPResponse := FTPRequest.GetResponse;
    //         StreamReader := StreamReader.StreamReader(FTPResponse.GetResponseStream);
    //         FilesList := FilesList.List;
    //         FileName := StreamReader.ReadLine;
    //         WHILE FileName <> '' DO BEGIN
    //             FilesList.Add(FileName);
    //             FileName := StreamReader.ReadLine;
    //         END;

    //         StreamReader.Close;
    //         FTPResponse.Close;
    //         EXIT(FilesList.Count);
    //     end;


    //     procedure DownloadFile(FTPAddressFile: Text; DownloadToFile: Text; Login: Text; Password: Text; DeleteAfterDownload: Boolean)
    //     var
    //         separator: DotNet String;
    //         result: DotNet String;
    //     begin
    //         FTPRequest := FTPRequest.Create(FTPAddressFile);
    //         FTPRequest.Credentials := NetworkCredential.NetworkCredential(Login, Password);
    //         FTPRequest.KeepAlive := TRUE;
    //         FTPRequest.Method := 'RETR';
    //         FTPRequest.UsePassive := TRUE;
    //         FTPRequest.UseBinary := TRUE;
    //         FTPResponse := FTPRequest.GetResponse;
    //         ResponseStream := FTPResponse.GetResponseStream();
    //         TempBLOB.Blob.CREATEOUTSTREAM(OutStreamVar);
    //         COPYSTREAM(OutStreamVar, ResponseStream);
    //         TempBLOB.Blob.EXPORT(DownloadToFile);

    //         IF DeleteAfterDownload THEN BEGIN
    //             DeleteFile(FTPAddressFile, Login, Password);
    //         END;
    //     end;


    //     procedure DeleteFile(FTPAddressFile: Text; Login: Text; Password: Text): Boolean
    //     var
    //         Deleted: Boolean;
    //     begin
    //         CLEAR(Deleted);
    //         FTPRequest := FTPRequest.Create(FTPAddressFile);
    //         FTPRequest.Credentials := NetworkCredential.NetworkCredential(Login, Password);
    //         FTPRequest.KeepAlive := TRUE;
    //         FTPRequest.Method := 'DELE';
    //         FTPRequest.UsePassive := TRUE;
    //         FTPRequest.UseBinary := TRUE;
    //         //StatusCode := FTPResponse.StatusCode;
    //         FTPResponse := FTPRequest.GetResponse;
    //         /*IF FTPResponse.StatusCode.ToString() = StatusCode.FileActionOK.ToString() THEN BEGIN
    //           Deleted := TRUE;
    //         END;*/
    //         FTPResponse.Close;
    //         EXIT(Deleted);

    //     end;


    //     procedure UploadFile(FileNameToUpload: Text; UploadToFtp: Text; Login: Text; Password: Text)
    //     begin
    //         FTPRequest := FTPRequest.Create(UploadToFtp);
    //         Credentials := Credentials.NetworkCredential(Login, Password);
    //         FTPRequest.Credentials := Credentials;
    //         //FTPRequest.KeepAlive := TRUE;
    //         FTPRequest.Method := 'STOR';
    //         //FTPRequest.UsePassive := TRUE;
    //         //FTPRequest.UsePassive := FALSE;

    //         //FTPRequest.UseBinary := TRUE;
    //         RealFileStream := FileStream.OpenRead(FileNameToUpload);
    //         SimpleStream := FTPRequest.GetRequestStream;
    //         RealFileStream.CopyTo(SimpleStream);
    //         SimpleStream.Close;
    //         RealFileStream.Close;
    //     end;


    //     procedure GetFilename(Index: Integer): Text
    //     begin
    //         EXIT(FORMAT(FilesList.Item(Index)));
    //     end;


    //     procedure DownloadFiles(FTPAddressWithFolder: Text; DownloadToFolder: Text; FTPUserID: Text; FTPPassword: Text)
    //     var
    //         Counter: Integer;
    //         FilesCount: Integer;
    //     begin
    //         FilesCount := GetFilesList(FTPAddressWithFolder, FTPUserID, FTPPassword);
    //         IF FilesCount > 0 THEN BEGIN
    //             //MESSAGE(FORMAT(FilesCount));
    //             FOR Counter := 0 TO FilesCount - 1 DO BEGIN
    //                 //MESSAGE('sourc %1 dest %2',FTPAddressWithFolder + GetFilename(Counter),DownloadToFolder + GetFilename(Counter));
    //                 IF (GetFilename(Counter) <> '.') AND (GetFilename(Counter) <> '..') THEN
    //                     DownloadFile(FTPAddressWithFolder + GetFilename(Counter), DownloadToFolder + GetFilename(Counter), FTPUserID, FTPPassword, TRUE);//TRUE TO DELETE
    //             END;
    //         END;
    //     end;


    //     procedure UploadFiles(UploadFromFolder: Text; UploadToFTPAddressWithFolder: Text; FTPUserID: Text; FTPPassword: Text)
    //     begin
    //         Files.RESET;
    //         Files.SETRANGE(Path, UploadFromFolder);
    //         Files.SETRANGE("Is a file", TRUE);
    //         IF Files.FIND('-') THEN BEGIN
    //             REPEAT
    //                 UploadFile(Files.Path + Files.Name, UploadToFTPAddressWithFolder + Files.Name, FTPUserID, FTPPassword);
    //             UNTIL Files.NEXT = 0;
    //         END;
    //     end;
}

