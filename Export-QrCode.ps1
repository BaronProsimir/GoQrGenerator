# $QrGeneratorPath2 = "http://api.qrserver.com/v1/create-qr-code";

function Export-QrCode() {
  <#
  .SYNOPSIS
    Short description
  .DESCRIPTION
    Long description
  .EXAMPLE
    PS C:\> <example usage>
    Explanation of what the example does
  .INPUTS
  .OUTPUTS
    File ( *.eps, *.gif, *.jpeg, *.jpg, *.png, *.svg ).
  .NOTES
    Version: 1.0.1
    Created by: BaronProsimir
  #>
  [CmdletBinding()]
  param (
    # A required parameter that specifies the location to save the QR code file.
    [Parameter(Mandatory,HelpMessage="A required parameter that specifies the location to save the QR code file.")]
    [string]$Path,
    # The text to store within the QR code.
    [Parameter(Mandatory, HelpMessage="The text to store within the QR code.")]
    [string[]]$Body,
    # The name of the downloaded QR code file.
    [Parameter()]
    [string]$FileName = "QrCode",
    # Specifies the size of the QR code image you want to generate.
    #   - In PIXELS for raster graphic formats like PNG, GIF or JPEG.
    #   - As LOGICAL UNIT for vector graphics (SVG, EPS).
    #
    # Minimum value: 10
    # Maximum value: 1000
    # Default value: 200
    [ValidateRange(10, 1000)]
    [Parameter()]
    [int16]$Size = 200,
    # Specifies the charset the text submitted via data parameter is encoded in.
    [ValidateSet("ISO-8859-1", "UTF-8")]
    [Parameter()]
    [string]$CharsetSource = "UTF-8",
    # The data color of the final QR code.
    [Parameter()]#[ValidatePattern("[0-25]-[0-256]-[0-256]")]
    [string]$Color = "0-0-0",
    # The background color of the final QR code.
    [Parameter()]
    #[ValidatePattern("[0-25]-[0-256]-[0-256]")]
    [string]$BgColor = "255-255-255",
    # Thickness of a margin in PIXELS.
    #
    # Minimum value: 0
    # Maximum value: 50
    # Default value: 1
    [ValidateRange(0, 50)]
    [Parameter()]
    [int16]$Margin = 1,
    # Thickness of a "quiet zone" ( An area without disturbing elements to help readers locating the QR code), in modules as measuring unit.
    #
    # Minimum value: 0
    # Maximum value: 100
    # Default value: 0 => No "quiet zone".
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
    $Path = Convert-Path -Path $Path;
    $QrGeneratorPath = "http://api.qrserver.com/v1/create-qr-code";
  }
  process {
    $FullQrCodePath = "$QrGeneratorPath/?data=$Body&size=$($Size)x$Size&color=$Color&bgcolor=$BgColor&margin=$Margin&qzone=$QZone&format=$Format";
    Write-Debug $FullQrCodePath;
  }
  end {
    [System.Net.WebClient]::new().DownloadFile($FullQrCodePath, "$Path\$FileName.$format");
    return;
  }
}