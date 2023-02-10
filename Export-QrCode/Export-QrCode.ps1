# $QrGeneratorPath2 = "http://api.qrserver.com/v1/create-qr-code";

function Export-QrCode() {
  <#
  .SYNOPSIS
    Exports parameterized Qr Code to a file.
  .DESCRIPTION
    The Export-QrCode function generates GoQr.me API URL, sends GET request towards it and downloads the generated QR code image into a choosed path.
  .EXAMPLE
    PS C:\> Export-QrCode -Path "C:\QrCodes\" -Body "NazdarSvet!";
    Downloads a Qr code with "NazdarSvet!" text into 'C:\QrCodes\' folder. Folder has to exists!
  .EXAMPLE
    PS C:\> Export-QrCode -Path "C:\QrCodes" -Body "https://www.google.com/search?q=baronprosimir" -FileName "WhoIsBaronProsimir" -Size 300 -Color 9-97-153 -BgColor 230-147-34  -Margin 5 -QZone 2 -Format svg;
    Downolads a QR code which contains Google search of the "BaronProsimir" text url with size of 300px, blue data color and orange background, 5px margin and 2px quiet-zone on SVG format.
  .INPUTS
    String

    You can pipe a strings containg a path and a body ( bodies ) of QR code/s to this cmdlet.
  .OUTPUTS
    File ( *.eps, *.gif, *.jpeg, *.jpg, *.png, *.svg ).
  .NOTES
    Version: 1.0.1
    Created by: BaronProsimir
  .LINK
    Original goqr.me API documentation: https://goqr.me/api/doc/create-qr-code
    Github repository: https://github.com/BaronProsimir/PS-QrCodes-Haven
  #>
  [CmdletBinding()]
  param (
    # A required parameter that specifies the location to save the QR code file.
    [Parameter(Mandatory,HelpMessage="A required parameter that specifies the location to save the QR code file.")]
    [string]$Path,
    # The text to store within the QR code/s.
    #
    # If one string is passed, only one QR code will be generated without count.
    # If more strings are passed, the count on the end of the $FileName is added. ( Starting with 0! )
    # ( QrCode0, QrCode1, QrCode2 etc. )
    [Parameter(Mandatory, HelpMessage="The text to store within the QR code/s.")]
    [string[]]$Body,
    # The name/s of the downloaded QR code file/s.
    # ( If more than one string is passed as a $Body parameter, count from 0 is added on the end of the name. )
    [Parameter()]
    [string]$FileName = "QrCode",
    # Specifies the size of the QR code image you want to generate"
    #
    # - In PIXELS for raster graphic formats like PNG, GIF or JPEG.
    # - As LOGICAL UNIT for vector graphics (SVG, EPS).
    #
    # Minimum value: 10
    # Maximum value: 1000
    [ValidateRange(10, 1000)]
    [Parameter()]
    [int16]$Size = 200,
    # Specifies the charset the text submitted via $Body parameter is encoded in.
    [ValidateSet("ISO-8859-1", "UTF-8")]
    [Parameter()]
    [string]$CharsetSource = "UTF-8",
    # The data color of the final QR code.
    #
    # Format: RGB ( Red-Green-Blue)
    # Example: 255-0-0 => Red
    [Parameter()]
    [string]$Color = "0-0-0",
    # The background color of the final QR code.
    #
    # Format: RGB ( Red-Green-Blue)
    # Example: 255-255-255 => White
    [Parameter()]
    [string]$BgColor = "255-255-255",
    # Thickness of a margin in PIXELS.
    #
    # Minimum value: 0
    # Maximum value: 50
    [ValidateRange(0, 50)]
    [Parameter()]
    [int16]$Margin = 1,
    # Thickness of a "quiet zone" ( An area without disturbing elements to help readers locating the QR code), in modules as measuring unit.
    #
    # Minimum value: 0
    # Maximum value: 100
    # Default value: No "quiet zone".
    [ValidateRange(0, 100)]
    [Parameter()]
    [int16]$QZone = 0,
    # It is possible to create the QR code picture using different file formats, available are PNG, GIF, JPEG and the vector graphic formats SVG and EPS.
    #
    # Default value: png
    [ValidateSet("png", "gif", "jpeg", "jpg", "svg", "eps")]
    [Parameter()]
    [string]$Format = "png"
  )
  begin{

    # Url's array init:
    $qrUrls = @();

    # Convert passed path into valid one:
    $DownloadPath = Convert-Path -Path $Path;

    # Goqr.me API server URL:
    $QrGeneratorPath = "http://api.qrserver.com/v1/create-qr-code";

  }
  process {

    # Build an URL for each passed Body string:
    foreach ($item in $Body) {

      # Generate URL string:
      $FullQrCodePath = "$QrGeneratorPath/?data=$item"; # Add body.
      $FullQrCodePath += "&size=$($Size)x$Size";        # Add size.
      $FullQrCodePath += "&color=$Color";               # Add color.
      $FullQrCodePath += "&bgcolor=$BgColor";           # Add background color.
      $FullQrCodePath += "&margin=$Margin";             # Add margin.
      $FullQrCodePath += "&qzone=$QZone";               # Add "Quite zone".
      $FullQrCodePath += "&format=$Format";             # Add file format.

      # Add newly generated URL string into array:
      $qrUrls += $FullQrCodePath;

    }
  }
  end {
    try {

      # Naming counter init:
      $qrCounter = 0;

      # Loop throuhg the Uls and download each QR code:
      foreach ($qrUrl in $qrUrls) {

        # Generate path for download:
        $downloadFilePath = "$DownloadPath\$FileName$(if ( $qrUrls.Length -ge 2 ){ "$qrCounter" }).$format";

        # Download file:
        [System.Net.WebClient]::new().DownloadFile($qrUrl, $downloadFilePath);

        # Increment a naming counter:
        $qrCounter++;
      }

      # End the function:
      return;
      
    }
    catch {
      Write-Error $Error
    }
  }
}