dotnet
{
    assembly("System")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.Net.FtpWebRequest"; "FtpWebRequest")
        {
        }

        type("System.Net.FtpWebResponse"; "FtpWebResponse")
        {
        }

        type("System.Net.NetworkCredential"; "NetworkCredential")
        {
        }

        type("System.Net.FtpStatusCode"; "FtpStatusCode")
        {
        }
    }

    assembly("mscorlib")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.IO.Stream"; "Stream")
        {
        }

        type("System.IO.StreamReader"; "StreamReader")
        {
        }

        type("System.IO.File"; "File")
        {
        }

        type("System.IO.FileStream"; "FileStream")
        {
        }

        type("System.Collections.Generic.List`1"; "List_Of_T")
        {
        }

        type("System.String"; "String")
        {
        }
    }

    assembly("NAV.SFTP.Mgt")
    {
        Version = '1.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'null';

        type("NAV.SFTP.Mgt.SFTP"; "SFTP")
        {
        }
    }

}
